-- RLS policies for team_members
create policy "User, admin global or team admin can select team membership"
on public.team_members
for select
to authenticated
using (
  user_id = (select auth.uid())
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or team_id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  )
);

create policy "Admin global or team admin can insert team membership"
on public.team_members
for insert
to authenticated
with check (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or
  (team_id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  ))
);

create policy "Admin global or team admin can update team membership"
on public.team_members
for update
to authenticated
using (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or
  (team_id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  ))
)
with check (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or
  (team_id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  ))
);

create policy "Admin global or team admin can delete team membership"
on public.team_members
for delete
to authenticated
using (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or
  (team_id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  ))
);