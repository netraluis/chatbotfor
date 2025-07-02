-- Teams table
create table if not exists public.teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  subdomain text unique not null,
  customdomain text,
  selected_language text,
  logo_url text,
  symbol_url text,
  avatar_url text,
  welcome_type text,
  is_active boolean default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Comments for the teams table
comment on table public.teams is 'Teams for multi-tenant SaaS, each with subdomain and custom branding.';
comment on column public.teams.id is 'Primary key.';
comment on column public.teams.name is 'Team name.';
comment on column public.teams.subdomain is 'Unique subdomain for public access.';
comment on column public.teams.customdomain is 'Custom domain for the team.';
comment on column public.teams.selected_language is 'Default language for the team.';
comment on column public.teams.logo_url is 'URL for team logo.';
comment on column public.teams.symbol_url is 'URL for team symbol.';
comment on column public.teams.avatar_url is 'URL for team avatar.';
comment on column public.teams.welcome_type is 'Type of welcome experience for the team.';
comment on column public.teams.is_active is 'Indicates if the team is active.';
comment on column public.teams.created_at is 'Timestamp when the team was created.';
comment on column public.teams.updated_at is 'Timestamp when the team was last updated.';