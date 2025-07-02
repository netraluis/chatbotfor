-- Team menu header items table: multilingual, logical item_key for order sync across languages
create table if not exists public.team_menu_header_items (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references public.teams(id) on delete cascade,
  item_key text not null, -- logical key for the menu item
  position integer not null, -- order in the menu (main language only)
  language text not null references public.languages(code),
  text_header_menu text not null, -- menu item text
  href text, -- menu item link
  icon text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (team_id, item_key, language),
  unique (team_id, position) -- enforce in app logic: only for main language
);

comment on table public.team_menu_header_items is 'Multilingual menu header items for each team, with logical item_key for order sync across languages.';
comment on column public.team_menu_header_items.id is 'Primary key.';
comment on column public.team_menu_header_items.team_id is 'References public.teams(id).';
comment on column public.team_menu_header_items.item_key is 'Logical key for the menu item, shared across languages.';
comment on column public.team_menu_header_items.position is 'Order in the menu (main language only).';
comment on column public.team_menu_header_items.language is 'Language code for the menu item, references public.languages(code).';
comment on column public.team_menu_header_items.text_header_menu is 'Text displayed for the menu header item.';
comment on column public.team_menu_header_items.href is 'Link (URL or route) for the menu item.';
comment on column public.team_menu_header_items.icon is 'Icon for the menu item.';
comment on column public.team_menu_header_items.created_at is 'Timestamp when the menu item was created.';
comment on column public.team_menu_header_items.updated_at is 'Timestamp when the menu item was last updated.';

