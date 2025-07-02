-- RLS policies for assistant_entry_points
create policy "Anyone can select assistant entry point"
on public.assistant_entry_points
for select
to anon
using (true);

create policy "Any authenticated user can select assistant entry point"
on public.assistant_entry_points
for select
to authenticated
using (true);

create policy "Team admin or global admin can insert assistant entry point"
on public.assistant_entry_points
for insert
to authenticated
with check (
  assistant_id in (
    select id from public.assistants where team_id in (
      select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
    )
    or exists (
      select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
    )
  )
);

create policy "Team admin or global admin can update assistant entry point"
on public.assistant_entry_points
for update
to authenticated
using (
  assistant_id in (
    select id from public.assistants where team_id in (
      select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
    )
    or exists (
      select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
    )
  )
)
with check (
  assistant_id in (
    select id from public.assistants where team_id in (
      select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
    )
    or exists (
      select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
    )
  )
);

create policy "Team admin or global admin can delete assistant entry point"
on public.assistant_entry_points
for delete
to authenticated
using (
  assistant_id in (
    select id from public.assistants where team_id in (
      select team_id from public.team_members where user_id = (select auth.uid()) and role = 'admin'
    )
    or exists (
      select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
    )
  )
); 