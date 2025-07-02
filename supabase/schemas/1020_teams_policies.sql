-- RLS policies for teams
create policy "Team member or admin global can select team"
on public.teams
for select
to authenticated
using (
  id in (
    select team_id from public.team_members where user_id = (select auth.uid())
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "Any authenticated user can insert team"
on public.teams
for insert
to authenticated
with check ( true );

create policy "Admin global or team admin can update team"
on public.teams
for update
to authenticated
using (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  )
)
with check (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  )
);

create policy "Admin global or team admin can delete team"
on public.teams
for delete
to authenticated
using (
  exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
  or id in (
    select team_id from public.team_members
    where user_id = (select auth.uid()) and role = 'admin'
  )
);