# chatbotfor

> **UI Style:** This project uses the 'zinc' style for shadui components.

## Supabase local development

1. Install Docker Desktop or a compatible alternative (Rancher Desktop, Podman, OrbStack, colima).
2. Install the Supabase CLI (optional, you can use npx):

```sh
npm install supabase --save-dev
```

Or just use npx:

```sh
npx supabase --help
```

3. Initialize the Supabase project (this creates the `supabase` folder):

```sh
npx supabase init
```

4. Start the Supabase services locally:

```sh
npx supabase start
```

This will spin up all required services (DB, API, Studio, etc). When it's done, you'll see the local URLs and access keys in your console.

- Studio: [http://localhost:54323](http://localhost:54323)
- API: [http://localhost:54321](http://localhost:54321)
- DB: `postgresql://postgres:postgres@localhost:54322/postgres`

To stop the services:

```sh
npx supabase stop
```

More info: [Supabase CLI - Getting Started](https://supabase.com/docs/guides/local-development/cli/getting-started?queryGroups=access-method&access-method=studio)

## 🌐 Internacionalización (i18n)

Este proyecto usa [next-intl](https://next-intl-docs.vercel.app/) para soportar múltiples idiomas de forma estándar en Next.js (App Router) y TypeScript.

### Estructura

- Las traducciones están en `app/locales/` con un archivo JSON por idioma (`en.json`, `es.json`, `ca.json`, `fr.json`, ...).
- El archivo `i18n/routing.ts` define los idiomas soportados y el idioma por defecto.
- El archivo `middleware.ts` detecta el idioma de cada request y carga las traducciones adecuadas.

### Ejemplo de archivo de traducción (`app/locales/en.json`):
```json
{
  "HomePage": {
    "title": "Hello world!"
  },
  "LoginPage": {
    "company": "Acme Inc"
  }
}
```

### Uso en componentes

Importa y usa el hook `useTranslations` de next-intl:

```tsx
import {useTranslations} from 'next-intl';

export default function HomePage() {
  const t = useTranslations('HomePage');
  return <h1>{t('title')}</h1>;
}
```

### Agregar/editar traducciones

1. Edita o agrega claves en los archivos de `app/locales/`.
2. Usa el hook `useTranslations` en tus componentes para acceder a los textos traducidos.

### Configuración de idiomas

Edita `i18n/routing.ts` para cambiar los idiomas soportados o el idioma por defecto:
```ts
export const routing = defineRouting({
  locales: ['ca', 'fr', 'en', 'es'],
  defaultLocale: 'ca'
});
```
