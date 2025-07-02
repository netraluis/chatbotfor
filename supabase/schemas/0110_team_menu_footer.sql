-- Team menu footers table: multilingual menu footers for each team
create table if not exists public.team_menu_footers (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  language text not null references public.languages(code),
  text text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (team_id, language)
);

comment on table public.team_menu_footers is 'Multilingual menu footers for each team.';
comment on column public.team_menu_footers.id is 'Primary key.';
comment on column public.team_menu_footers.team_id is 'References public.teams(id).';
comment on column public.team_menu_footers.language is 'Language code for the menu footer, references public.languages(code).';
comment on column public.team_menu_footers.text is 'Menu footer text.';
comment on column public.team_menu_footers.created_at is 'Timestamp when the menu footer was created.';
comment on column public.team_menu_footers.updated_at is 'Timestamp when the menu footer was last updated.';