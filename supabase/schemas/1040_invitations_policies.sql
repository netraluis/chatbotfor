-- RLS policies for invitations
create policy "Admin global or team admin can select invitations"
on public.invitations
for select
to authenticated
using (
  team_id in (
    select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "Admin global or team admin can insert invitations"
on public.invitations
for insert
to authenticated
with check (
  team_id in (
    select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "Admin global or team admin can delete invitations"
on public.invitations
for delete
to authenticated
using (
  team_id in (
    select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

-- RLS to allow update only from the system (service_role)
create policy "System can update invitation status"
on public.invitations
for update
to service_role
using (true)
with check (true);