-- Assistant entry points table: multilingual, ordered entry points per assistant
create table if not exists public.assistant_entry_points (
  id uuid primary key default gen_random_uuid(),
  assistant_id uuid references public.assistants(id) on delete cascade,
  item_key text not null, -- logical key for the entry point
  position integer not null, -- order in the list (main language only)
  language text not null references public.languages(code),
  text text not null, -- display text
  question text not null, -- entry point content
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (assistant_id, item_key, language),
  unique (assistant_id, position) -- enforce in app logic: only for main language
);

comment on table public.assistant_entry_points is 'Multilingual, ordered entry points for each assistant.';
comment on column public.assistant_entry_points.id is 'Primary key.';
comment on column public.assistant_entry_points.assistant_id is 'References public.assistants(id).';
comment on column public.assistant_entry_points.item_key is 'Logical key for the entry point, shared across languages.';
comment on column public.assistant_entry_points.position is 'Order in the list (main language only).';
comment on column public.assistant_entry_points.language is 'Language code for the entry point, references public.languages(code).';
comment on column public.assistant_entry_points.text is 'Display text for the entry point.';
comment on column public.assistant_entry_points.question is 'Entry point content.';
comment on column public.assistant_entry_points.created_at is 'Timestamp when the entry point was created.';
comment on column public.assistant_entry_points.updated_at is 'Timestamp when the entry point was last updated.';