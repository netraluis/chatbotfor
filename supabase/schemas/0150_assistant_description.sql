-- Assistant descriptions table: multilingual descriptions for each assistant
create table if not exists public.assistant_descriptions (
  id uuid primary key default gen_random_uuid(),
  assistant_id uuid references public.assistants(id) on delete cascade,
  language text not null references public.languages(code),
  description text not null,
  title text not null,
  intro_message text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (assistant_id, language)
);

comment on table public.assistant_descriptions is 'Multilingual descriptions for each assistant.';
comment on column public.assistant_descriptions.id is 'Primary key.';
comment on column public.assistant_descriptions.assistant_id is 'References public.assistants(id).';
comment on column public.assistant_descriptions.language is 'Language code for the description, references public.languages(code).';
comment on column public.assistant_descriptions.description is 'Assistant description text.';
comment on column public.assistant_descriptions.title is 'Title for the assistant.';
comment on column public.assistant_descriptions.intro_message is 'Intro message for the assistant.';
comment on column public.assistant_descriptions.created_at is 'Timestamp when the description was created.';
comment on column public.assistant_descriptions.updated_at is 'Timestamp when the description was last updated.';