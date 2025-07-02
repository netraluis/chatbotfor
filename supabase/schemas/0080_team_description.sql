-- Team descriptions table: multilingual descriptions for each team
create table if not exists public.team_descriptions (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  language text not null references public.languages(code),
  description text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (team_id, language)
);

comment on table public.team_descriptions is 'Multilingual descriptions for each team.';
comment on column public.team_descriptions.id is 'Primary key.';
comment on column public.team_descriptions.team_id is 'References public.teams(id).';
comment on column public.team_descriptions.language is 'Language code for the description, references public.languages(code).';
comment on column public.team_descriptions.description is 'Team description text.';
comment on column public.team_descriptions.created_at is 'Timestamp when the description was created.';
comment on column public.team_descriptions.updated_at is 'Timestamp when the description was last updated.';