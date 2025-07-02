-- Languages table: list of supported languages
create table if not exists public.languages (
  code text primary key, -- e.g. 'en', 'es', 'fr'
  name text not null
);

comment on table public.languages is 'List of supported languages.';
comment on column public.languages.code is 'Language code (e.g. en, es, fr).';
comment on column public.languages.name is 'Human-readable language name.';