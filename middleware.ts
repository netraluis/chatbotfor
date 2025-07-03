import { NextResponse, type NextRequest } from 'next/server'
import { routing } from './i18n/routing';
import { createSupabaseServerClient } from './lib/supabase-server';


export async function middleware(request: NextRequest) {
  const host = request.headers.get('host') || '';
  const [subdomain] = host.split('.');
  const { pathname } = request.nextUrl;

  // Always set tenant cookie/header
  let response = NextResponse.next({ request });
  response.cookies.set('tenant', subdomain, {
    path: '/',
    httpOnly: false,
    // domain: '.tudominio.com', // descomenta solo en producción
    sameSite: 'lax',
  });
  response.headers.set('x-tenant', subdomain);


    // --- APP SUBDOMAIN LOGIC (AUTH ENFORCEMENT) ---
    if (subdomain === process.env.SUBDOMAIN_APP || subdomain === process.env.BASE_URL) {
      console.log('app subdomain');
      const supabase = await createSupabaseServerClient();
      const {
        data: { user },
      } = await supabase.auth.getUser();
      console.log({user});
      // If not logged in and not already on /auth/login, rewrite to /app/auth/login
      if (!user && !pathname.startsWith('/auth/login')) {
        const rewriteUrl = request.nextUrl.clone();
        rewriteUrl.pathname = '/auth/login';
        return NextResponse.redirect(rewriteUrl);
      }
      // If logged in or already on /auth/login, rewrite to /app/*
      const rewriteUrl = request.nextUrl.clone();
      rewriteUrl.pathname = `/app${pathname}`;
      return NextResponse.rewrite(rewriteUrl);
    }

  // --- TENANT SUBDOMAIN LOGIC (NO AUTH ENFORCEMENT) ---
  if (subdomain !== process.env.SUBDOMAIN_APP ) {
    const locale = pathname.split('/')[1] as 'ca' | 'fr' | 'en' | 'es';
    if (!routing.locales.includes(locale)) {
      let newPath = `/${routing.defaultLocale}${pathname}`;
      let absoluteUrl = `${request.nextUrl.origin}${newPath}`;
      return NextResponse.redirect(absoluteUrl);
    }
    // Rewrite to /[tenant]/... if not already
    const rewriteUrl = request.nextUrl.clone();
    rewriteUrl.pathname = `/${subdomain}${pathname}`;
    return NextResponse.rewrite(rewriteUrl);
  }

}

export const config = {
  // Match all pathnames except for
  // - … if they start with `/api`, `/trpc`, `/_next` or `/_vercel`
  // - … the ones containing a dot (e.g. `favicon.ico`)
  matcher: '/((?!api|trpc|_next|_vercel|.*\\..*).*)'
};