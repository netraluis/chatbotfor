-- Messages table: multilingual messages for each assistant, with thread and run context
create type public.message_mode as enum ('prod', 'test');

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  assistant_id uuid references public.assistants(id) on delete cascade,
  thread_id uuid not null,
  run_id uuid not null,
  mode public.message_mode not null,
  language text not null references public.languages(code),
  description text not null,
  title text not null,
  intro_message text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (assistant_id, language, thread_id, run_id, mode)
);

comment on table public.messages is 'Multilingual messages for each assistant, with thread and run context.';
comment on column public.messages.id is 'Primary key.';
comment on column public.messages.assistant_id is 'References public.assistants(id).';
comment on column public.messages.thread_id is 'Thread identifier.';
comment on column public.messages.run_id is 'Run identifier.';
comment on column public.messages.mode is 'Message mode: prod or test.';
comment on column public.messages.language is 'Language code for the message, references public.languages(code).';
comment on column public.messages.description is 'Message description text.';
comment on column public.messages.title is 'Title for the message.';
comment on column public.messages.intro_message is 'Intro message for the message.';
comment on column public.messages.created_at is 'Timestamp when the message was created.';
comment on column public.messages.updated_at is 'Timestamp when the message was last updated.';
