import { NextIntlClientProvider } from "next-intl";

export default async function LocaleLayout({ children, params }: { children: React.ReactNode, params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  const messages = (await import(`@/app/locales/${locale}.json`)).default;

  return (
    <NextIntlClientProvider locale={locale} messages={messages}>
      <div key={locale}>
        {children}
      </div>
    </NextIntlClientProvider>
  );
}