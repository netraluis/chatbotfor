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
