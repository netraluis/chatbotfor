-- RLS policies for languages
create policy "Anyone can select language"
on public.languages
for select
to anon
using (true);

create policy "Any authenticated user can select language"
on public.languages
for select
to authenticated
using (true); 