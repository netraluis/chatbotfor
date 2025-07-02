-- Team header buttons table: multilingual button and popup content for each team
create table if not exists public.team_header_buttons (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  language text not null references public.languages(code),
  button_text text not null,
  popup_title text not null,
  popup_text text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (team_id, language)
);

comment on table public.team_header_buttons is 'Multilingual button and popup content for each team header.';
comment on column public.team_header_buttons.id is 'Primary key.';
comment on column public.team_header_buttons.team_id is 'References public.teams(id).';
comment on column public.team_header_buttons.language is 'Language code, references public.languages(code).';
comment on column public.team_header_buttons.button_text is 'Text displayed on the header button.';
comment on column public.team_header_buttons.popup_title is 'Title of the popup shown when the button is clicked.';
comment on column public.team_header_buttons.popup_text is 'Text content of the popup.';
comment on column public.team_header_buttons.created_at is 'Timestamp when the button was created.';
comment on column public.team_header_buttons.updated_at is 'Timestamp when the button was last updated.';