-- RLS policies for messages
create policy "System can insert message"
on public.messages
for insert
to service_role
with check (true);

create policy "Team member or global admin can select message"
on public.messages
for select
to authenticated
using (
  assistant_id in (
    select id from public.assistants where team_id in (
      select team_id from public.team_members where user_id = (select auth.uid())
    )
  )
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);
