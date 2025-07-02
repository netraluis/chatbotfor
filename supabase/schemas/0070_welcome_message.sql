-- Welcome messages table: multilingual welcome messages for each team
create table if not exists public.welcome_messages (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  language text not null references public.languages(code) on delete cascade,
  text text not null,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (team_id, language)
);

comment on table public.welcome_messages is 'Multilingual welcome messages for each team.';
comment on column public.welcome_messages.id is 'Primary key.';
comment on column public.welcome_messages.team_id is 'References public.teams(id).';
comment on column public.welcome_messages.language is 'Language code for the welcome message, references public.languages(code).';
comment on column public.welcome_messages.text is 'Welcome message text.';
comment on column public.welcome_messages.description is 'Description of the welcome message.';
comment on column public.welcome_messages.created_at is 'Timestamp when the welcome message was created.';
comment on column public.welcome_messages.updated_at is 'Timestamp when the welcome message was last updated.';