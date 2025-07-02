-- Invitations table
create table if not exists public.invitations (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  email text not null,
  token text unique not null,
  expires_at timestamptz not null,
  status text not null default 'sended' check (status in ('sended', 'used'))
);

-- Comments for the invitations table
comment on table public.invitations is 'Invitations for users to join teams, with status tracking.';
comment on column public.invitations.id is 'Primary key.';
comment on column public.invitations.team_id is 'References public.teams(id).';
comment on column public.invitations.email is 'Email address of the invited user.';
comment on column public.invitations.token is 'Unique invitation token.';
comment on column public.invitations.expires_at is 'Expiration timestamp for the invitation.';
comment on column public.invitations.status is 'Invitation status: sended, used.'; 