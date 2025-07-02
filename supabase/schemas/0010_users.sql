-- Users table synchronized with auth.users
create table if not exists public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  image_url text,
  language text,
  name text,
  surname text,
  phone text,
  dimensions jsonb,
  role text,
  sector text,
  is_global_admin boolean default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Comments for the users table
comment on table public.users is 'Business users table, synchronized with auth.users for authentication and profile data.';
comment on column public.users.id is 'Primary key, references auth.users(id).';
comment on column public.users.email is 'User email address.';
comment on column public.users.image_url is 'URL for user profile image.';
comment on column public.users.language is 'Preferred language of the user.';
comment on column public.users.name is 'User first name.';
comment on column public.users.surname is 'User surname.';
comment on column public.users.phone is 'User phone number.';
comment on column public.users.dimensions is 'User dimensions (custom field, integer).';
comment on column public.users.role is 'Business role of the user.';
comment on column public.users.sector is 'Business sector of the user.';
comment on column public.users.is_global_admin is 'Indicates if the user is a global admin.';
comment on column public.users.created_at is 'Timestamp when the user was created.';
comment on column public.users.updated_at is 'Timestamp when the user was last updated.';

-- Trigger to synchronize users with auth.users
create or replace function public.handle_new_auth_user()
returns trigger as $$
begin
  insert into public.users (id, email)
  values (new.id, new.email);
  return new;
end;
$$ language plpgsql security definer;

do $$
begin
  if exists (
    select 1 from pg_trigger
    where tgname = 'on_auth_user_created'
  ) then
    drop trigger on_auth_user_created on auth.users;
  end if;
end $$;

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_auth_user();