-- RLS policies for footer_text_team
create policy "Anyone can select footer text"
on public.footer_text_team
for select
to anon
using (true);

create policy "Any authenticated user can select footer text"
on public.footer_text_team
for select
to authenticated
using (true);

create policy "Team admin or global admin can insert footer text"
on public.footer_text_team
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

create policy "Team admin or global admin can update footer text"
on public.footer_text_team
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

create policy "Team admin or global admin can delete footer text"
on public.footer_text_team
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