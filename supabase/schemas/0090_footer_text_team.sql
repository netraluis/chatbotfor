-- Footer text team table: multilingual footer texts for each team
create table if not exists public.footer_text_team (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  language text not null references public.languages(code),
  text text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (team_id, language)
);

comment on table public.footer_text_team is 'Multilingual footer texts for each team.';
comment on column public.footer_text_team.id is 'Primary key.';
comment on column public.footer_text_team.team_id is 'References public.teams(id).';
comment on column public.footer_text_team.language is 'Language code for the footer, references public.languages(code).';
comment on column public.footer_text_team.text is 'Footer text.';
comment on column public.footer_text_team.created_at is 'Timestamp when the footer was created.';
comment on column public.footer_text_team.updated_at is 'Timestamp when the footer was last updated.';