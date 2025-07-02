-- RLS policies for assistant_descriptions
create policy "Anyone can select assistant description"
on public.assistant_descriptions
for select
to anon
using (true);

create policy "Any authenticated user can select assistant description"
on public.assistant_descriptions
for select
to authenticated
using (true);

create policy "Team admin or global admin can insert assistant description"
on public.assistant_descriptions
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

create policy "Team admin or global admin can update assistant description"
on public.assistant_descriptions
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

create policy "Team admin or global admin can delete assistant description"
on public.assistant_descriptions
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