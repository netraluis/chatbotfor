-- RLS for users table
create policy "User or admin global can select user"
on public.users
for select
to authenticated
using (
  (select auth.uid()) = id
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "User or admin global can update user"
on public.users
for update
to authenticated
using (
  (select auth.uid()) = id
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
)
with check (
  (select auth.uid()) = id
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "User or admin global can delete user"
on public.users
for delete
to authenticated
using (
  (select auth.uid()) = id
  or exists (
    select 1 from public.users u where u.id = (select auth.uid()) and u.is_global_admin = true
  )
);

create policy "User can insert own profile"
on public.users
for insert
to authenticated
with check (
  (select auth.uid()) = id
);