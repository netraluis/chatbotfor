-- Enum for team member roles
DO $$ BEGIN
  CREATE TYPE public.team_role AS ENUM ('admin', 'read_only', 'intermediate');
EXCEPTION
  WHEN duplicate_object THEN null;
END $$;

-- Team members table
create table if not exists public.team_members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.users(id) on delete cascade,
  team_id uuid references public.teams(id) on delete cascade,
  role public.team_role not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, team_id)
);

-- Comments for the team_members table
comment on table public.team_members is 'Memberships linking users to teams with specific roles.';
comment on column public.team_members.id is 'Primary key.';
comment on column public.team_members.user_id is 'References public.users(id).';
comment on column public.team_members.team_id is 'References public.teams(id).';
comment on column public.team_members.role is 'Role of the user in the team (admin, read_only, intermediate).';
comment on column public.team_members.created_at is 'Timestamp when the membership was created.';
comment on column public.team_members.updated_at is 'Timestamp when the membership was last updated.';