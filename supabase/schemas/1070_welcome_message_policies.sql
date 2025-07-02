-- RLS policies for welcome_messages
create policy "Anyone can select welcome message"
on public.welcome_messages
for select
to anon
using (true);

create policy "Any authenticated user can select welcome message"
on public.welcome_messages
for select
to authenticated
using (true);

create policy "Team admin or global admin can insert welcome message"
on public.welcome_messages
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

create policy "Team admin or global admin can update welcome message"
on public.welcome_messages
for update
to authenticated
using (
  team_id in (
    select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
)
with check (
  team_id in (
    select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "Team admin or global admin can delete welcome message"
on public.welcome_messages
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