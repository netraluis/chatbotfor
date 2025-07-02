-- RLS policies for team_header_buttons
create policy "Anyone can select team header button"
on public.team_header_buttons
for select
to anon
using (true);

create policy "Any authenticated user can select team header button"
on public.team_header_buttons
for select
to authenticated
using (true);

create policy "Team admin or global admin can insert team header button"
on public.team_header_buttons
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

create policy "Team admin or global admin can update team header button"
on public.team_header_buttons
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

create policy "Team admin or global admin can delete team header button"
on public.team_header_buttons
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