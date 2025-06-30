import { NextRequest, NextResponse } from 'next/server';
import createMiddleware from 'next-intl/middleware';
import { routing } from './i18n/routing';

const intlMiddleware = createMiddleware(routing);

export function middleware(request: NextRequest) {
  const host = request.headers.get('host') || '';
  const [subdomain] = host.split('.');

  let response = intlMiddleware(request) || NextResponse.next();
  response.cookies.set('tenant', subdomain, {
    path: '/',
    httpOnly: false,
    // domain: '.tudominio.com', // descomenta solo en producción
    sameSite: 'lax',
  });
  response.headers.set('x-tenant', subdomain);
  return response;
}

export const config = {
  // Match all pathnames except for
  // - … if they start with `/api`, `/trpc`, `/_next` or `/_vercel`
  // - … the ones containing a dot (e.g. `favicon.ico`)
  matcher: '/((?!api|trpc|_next|_vercel|.*\\..*).*)'
};