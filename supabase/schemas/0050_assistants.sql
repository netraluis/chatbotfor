-- Assistants table: stores assistants for each team, with connection info or internal definition
create table if not exists public.assistants (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  name text not null,
  status text not null,
  url text,
  webhook text,
  emoji text,
  is_active boolean default true,
  internal_assistant_definition jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.assistants is 'Assistants for each team, can be connected via URL or defined internally.';
comment on column public.assistants.id is 'Primary key.';
comment on column public.assistants.team_id is 'References public.teams(id).';
comment on column public.assistants.name is 'Assistant name.';
comment on column public.assistants.status is 'Status of the assistant.';
comment on column public.assistants.url is 'External connection URL for the assistant.';
comment on column public.assistants.webhook is 'Endpoint or curl command for external automation.';
comment on column public.assistants.emoji is 'Emoji representing the assistant.';
comment on column public.assistants.is_active is 'Indicates if the assistant is active.';
comment on column public.assistants.internal_assistant_definition is 'JSONB field for internal assistant configuration.';
comment on column public.assistants.created_at is 'Timestamp when the assistant was created.';
comment on column public.assistants.updated_at is 'Timestamp when the assistant was last updated.';