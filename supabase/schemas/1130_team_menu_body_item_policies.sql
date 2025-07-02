-- RLS policies for team_menu_body_items
create policy "Anyone can select team menu body item"
on public.team_menu_body_items
for select
to anon
using (true);

create policy "Any authenticated user can select team menu body item"
on public.team_menu_body_items
for select
to authenticated
using (true);

create policy "Team admin or global admin can insert team menu body item"
on public.team_menu_body_items
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

create policy "Team admin or global admin can update team menu body item"
on public.team_menu_body_items
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

create policy "Team admin or global admin can delete team menu body item"
on public.team_menu_body_items
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