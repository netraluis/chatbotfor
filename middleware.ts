import { NextRequest, NextResponse } from 'next/server';
import createMiddleware from 'next-intl/middleware';
import { routing } from './i18n/routing';

const intlMiddleware = createMiddleware(routing);

export function middleware(request: NextRequest) {
  const intlResponse = intlMiddleware(request);
  if (intlResponse) return intlResponse;

  const host = request.headers.get('host') || '';
  const [subdomain] = host.split('.');

  // Admin/app
  if (subdomain === 'app' || subdomain === 'admin') {
    const response = NextResponse.next();
    response.cookies.set('tenant', 'admin');
    return response;
  }

  // principal domain
  if (host === 'miurl.com' || subdomain === 'www') {
    return NextResponse.next();
  }

  // Custom domain
//   if (customDomains[host]) {
//     const response = NextResponse.next();
//     response.cookies.set('tenant', customDomains[host]);
//     return response;
//   }

  // classic subdomain
  const response = NextResponse.next();
  response.cookies.set('tenant', subdomain);
  return response;
}

export const config = {
  // Match all pathnames except for
  // - … if they start with `/api`, `/trpc`, `/_next` or `/_vercel`
  // - … the ones containing a dot (e.g. `favicon.ico`)
  matcher: '/((?!api|trpc|_next|_vercel|.*\\..*).*)'
};