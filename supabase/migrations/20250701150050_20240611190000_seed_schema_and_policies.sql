create type "public"."message_mode" as enum ('prod', 'test');

create type "public"."team_role" as enum ('admin', 'read_only', 'intermediate');

create table "public"."assistant_descriptions" (
    "id" uuid not null default gen_random_uuid(),
    "assistant_id" uuid,
    "language" text not null,
    "description" text not null,
    "title" text not null,
    "intro_message" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."assistant_entry_points" (
    "id" uuid not null default gen_random_uuid(),
    "assistant_id" uuid,
    "item_key" text not null,
    "position" integer not null,
    "language" text not null,
    "text" text not null,
    "question" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."assistants" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "name" text not null,
    "status" text not null,
    "url" text,
    "webhook" text,
    "emoji" text,
    "is_active" boolean default true,
    "internal_assistant_definition" jsonb,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."footer_text_team" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "language" text not null,
    "text" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."invitations" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "email" text not null,
    "token" text not null,
    "expires_at" timestamp with time zone not null,
    "status" text not null default 'sended'::text
);


create table "public"."languages" (
    "code" text not null,
    "name" text not null
);


create table "public"."messages" (
    "id" uuid not null default gen_random_uuid(),
    "assistant_id" uuid,
    "thread_id" uuid not null,
    "run_id" uuid not null,
    "mode" message_mode not null,
    "language" text not null,
    "description" text not null,
    "title" text not null,
    "intro_message" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."team_descriptions" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "language" text not null,
    "description" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."team_header_buttons" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "language" text not null,
    "button_text" text not null,
    "popup_title" text not null,
    "popup_text" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."team_members" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid,
    "team_id" uuid,
    "role" team_role not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."team_menu_body_items" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "item_key" text not null,
    "position" integer not null,
    "language" text not null,
    "text_body_menu" text not null,
    "href" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."team_menu_footers" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "language" text not null,
    "text" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."team_menu_header_items" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "item_key" text not null,
    "position" integer not null,
    "language" text not null,
    "text_header_menu" text not null,
    "href" text,
    "icon" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."teams" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "subdomain" text not null,
    "customdomain" text,
    "selected_language" text,
    "logo_url" text,
    "symbol_url" text,
    "avatar_url" text,
    "welcome_type" text,
    "is_active" boolean default true,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."users" (
    "id" uuid not null,
    "email" text not null,
    "image_url" text,
    "language" text,
    "name" text,
    "surname" text,
    "phone" text,
    "dimensions" jsonb,
    "role" text,
    "sector" text,
    "is_global_admin" boolean default false,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


create table "public"."welcome_messages" (
    "id" uuid not null default gen_random_uuid(),
    "team_id" uuid,
    "language" text not null,
    "text" text not null,
    "description" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


CREATE UNIQUE INDEX assistant_descriptions_assistant_id_language_key ON public.assistant_descriptions USING btree (assistant_id, language);

CREATE UNIQUE INDEX assistant_descriptions_pkey ON public.assistant_descriptions USING btree (id);

CREATE UNIQUE INDEX assistant_entry_points_assistant_id_item_key_language_key ON public.assistant_entry_points USING btree (assistant_id, item_key, language);

CREATE UNIQUE INDEX assistant_entry_points_assistant_id_position_key ON public.assistant_entry_points USING btree (assistant_id, "position");

CREATE UNIQUE INDEX assistant_entry_points_pkey ON public.assistant_entry_points USING btree (id);

CREATE UNIQUE INDEX assistants_pkey ON public.assistants USING btree (id);

CREATE UNIQUE INDEX footer_text_team_pkey ON public.footer_text_team USING btree (id);

CREATE UNIQUE INDEX footer_text_team_team_id_language_key ON public.footer_text_team USING btree (team_id, language);

CREATE UNIQUE INDEX invitations_pkey ON public.invitations USING btree (id);

CREATE UNIQUE INDEX invitations_token_key ON public.invitations USING btree (token);

CREATE UNIQUE INDEX languages_pkey ON public.languages USING btree (code);

CREATE UNIQUE INDEX messages_assistant_id_language_thread_id_run_id_mode_key ON public.messages USING btree (assistant_id, language, thread_id, run_id, mode);

CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id);

CREATE UNIQUE INDEX team_descriptions_pkey ON public.team_descriptions USING btree (id);

CREATE UNIQUE INDEX team_descriptions_team_id_language_key ON public.team_descriptions USING btree (team_id, language);

CREATE UNIQUE INDEX team_header_buttons_pkey ON public.team_header_buttons USING btree (id);

CREATE UNIQUE INDEX team_header_buttons_team_id_language_key ON public.team_header_buttons USING btree (team_id, language);

CREATE UNIQUE INDEX team_members_pkey ON public.team_members USING btree (id);

CREATE UNIQUE INDEX team_members_user_id_team_id_key ON public.team_members USING btree (user_id, team_id);

CREATE UNIQUE INDEX team_menu_body_items_pkey ON public.team_menu_body_items USING btree (id);

CREATE UNIQUE INDEX team_menu_body_items_team_id_item_key_language_key ON public.team_menu_body_items USING btree (team_id, item_key, language);

CREATE UNIQUE INDEX team_menu_body_items_team_id_position_key ON public.team_menu_body_items USING btree (team_id, "position");

CREATE UNIQUE INDEX team_menu_footers_pkey ON public.team_menu_footers USING btree (id);

CREATE UNIQUE INDEX team_menu_footers_team_id_language_key ON public.team_menu_footers USING btree (team_id, language);

CREATE UNIQUE INDEX team_menu_header_items_pkey ON public.team_menu_header_items USING btree (id);

CREATE UNIQUE INDEX team_menu_header_items_team_id_item_key_language_key ON public.team_menu_header_items USING btree (team_id, item_key, language);

CREATE UNIQUE INDEX team_menu_header_items_team_id_position_key ON public.team_menu_header_items USING btree (team_id, "position");

CREATE UNIQUE INDEX teams_pkey ON public.teams USING btree (id);

CREATE UNIQUE INDEX teams_subdomain_key ON public.teams USING btree (subdomain);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

CREATE UNIQUE INDEX welcome_messages_pkey ON public.welcome_messages USING btree (id);

CREATE UNIQUE INDEX welcome_messages_team_id_language_key ON public.welcome_messages USING btree (team_id, language);

alter table "public"."assistant_descriptions" add constraint "assistant_descriptions_pkey" PRIMARY KEY using index "assistant_descriptions_pkey";

alter table "public"."assistant_entry_points" add constraint "assistant_entry_points_pkey" PRIMARY KEY using index "assistant_entry_points_pkey";

alter table "public"."assistants" add constraint "assistants_pkey" PRIMARY KEY using index "assistants_pkey";

alter table "public"."footer_text_team" add constraint "footer_text_team_pkey" PRIMARY KEY using index "footer_text_team_pkey";

alter table "public"."invitations" add constraint "invitations_pkey" PRIMARY KEY using index "invitations_pkey";

alter table "public"."languages" add constraint "languages_pkey" PRIMARY KEY using index "languages_pkey";

alter table "public"."messages" add constraint "messages_pkey" PRIMARY KEY using index "messages_pkey";

alter table "public"."team_descriptions" add constraint "team_descriptions_pkey" PRIMARY KEY using index "team_descriptions_pkey";

alter table "public"."team_header_buttons" add constraint "team_header_buttons_pkey" PRIMARY KEY using index "team_header_buttons_pkey";

alter table "public"."team_members" add constraint "team_members_pkey" PRIMARY KEY using index "team_members_pkey";

alter table "public"."team_menu_body_items" add constraint "team_menu_body_items_pkey" PRIMARY KEY using index "team_menu_body_items_pkey";

alter table "public"."team_menu_footers" add constraint "team_menu_footers_pkey" PRIMARY KEY using index "team_menu_footers_pkey";

alter table "public"."team_menu_header_items" add constraint "team_menu_header_items_pkey" PRIMARY KEY using index "team_menu_header_items_pkey";

alter table "public"."teams" add constraint "teams_pkey" PRIMARY KEY using index "teams_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."welcome_messages" add constraint "welcome_messages_pkey" PRIMARY KEY using index "welcome_messages_pkey";

alter table "public"."assistant_descriptions" add constraint "assistant_descriptions_assistant_id_fkey" FOREIGN KEY (assistant_id) REFERENCES assistants(id) ON DELETE CASCADE not valid;

alter table "public"."assistant_descriptions" validate constraint "assistant_descriptions_assistant_id_fkey";

alter table "public"."assistant_descriptions" add constraint "assistant_descriptions_assistant_id_language_key" UNIQUE using index "assistant_descriptions_assistant_id_language_key";

alter table "public"."assistant_descriptions" add constraint "assistant_descriptions_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."assistant_descriptions" validate constraint "assistant_descriptions_language_fkey";

alter table "public"."assistant_entry_points" add constraint "assistant_entry_points_assistant_id_fkey" FOREIGN KEY (assistant_id) REFERENCES assistants(id) ON DELETE CASCADE not valid;

alter table "public"."assistant_entry_points" validate constraint "assistant_entry_points_assistant_id_fkey";

alter table "public"."assistant_entry_points" add constraint "assistant_entry_points_assistant_id_item_key_language_key" UNIQUE using index "assistant_entry_points_assistant_id_item_key_language_key";

alter table "public"."assistant_entry_points" add constraint "assistant_entry_points_assistant_id_position_key" UNIQUE using index "assistant_entry_points_assistant_id_position_key";

alter table "public"."assistant_entry_points" add constraint "assistant_entry_points_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."assistant_entry_points" validate constraint "assistant_entry_points_language_fkey";

alter table "public"."assistants" add constraint "assistants_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."assistants" validate constraint "assistants_team_id_fkey";

alter table "public"."footer_text_team" add constraint "footer_text_team_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."footer_text_team" validate constraint "footer_text_team_language_fkey";

alter table "public"."footer_text_team" add constraint "footer_text_team_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."footer_text_team" validate constraint "footer_text_team_team_id_fkey";

alter table "public"."footer_text_team" add constraint "footer_text_team_team_id_language_key" UNIQUE using index "footer_text_team_team_id_language_key";

alter table "public"."invitations" add constraint "invitations_status_check" CHECK ((status = ANY (ARRAY['sended'::text, 'used'::text]))) not valid;

alter table "public"."invitations" validate constraint "invitations_status_check";

alter table "public"."invitations" add constraint "invitations_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."invitations" validate constraint "invitations_team_id_fkey";

alter table "public"."invitations" add constraint "invitations_token_key" UNIQUE using index "invitations_token_key";

alter table "public"."messages" add constraint "messages_assistant_id_fkey" FOREIGN KEY (assistant_id) REFERENCES assistants(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_assistant_id_fkey";

alter table "public"."messages" add constraint "messages_assistant_id_language_thread_id_run_id_mode_key" UNIQUE using index "messages_assistant_id_language_thread_id_run_id_mode_key";

alter table "public"."messages" add constraint "messages_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."messages" validate constraint "messages_language_fkey";

alter table "public"."team_descriptions" add constraint "team_descriptions_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."team_descriptions" validate constraint "team_descriptions_language_fkey";

alter table "public"."team_descriptions" add constraint "team_descriptions_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."team_descriptions" validate constraint "team_descriptions_team_id_fkey";

alter table "public"."team_descriptions" add constraint "team_descriptions_team_id_language_key" UNIQUE using index "team_descriptions_team_id_language_key";

alter table "public"."team_header_buttons" add constraint "team_header_buttons_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."team_header_buttons" validate constraint "team_header_buttons_language_fkey";

alter table "public"."team_header_buttons" add constraint "team_header_buttons_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."team_header_buttons" validate constraint "team_header_buttons_team_id_fkey";

alter table "public"."team_header_buttons" add constraint "team_header_buttons_team_id_language_key" UNIQUE using index "team_header_buttons_team_id_language_key";

alter table "public"."team_members" add constraint "team_members_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."team_members" validate constraint "team_members_team_id_fkey";

alter table "public"."team_members" add constraint "team_members_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."team_members" validate constraint "team_members_user_id_fkey";

alter table "public"."team_members" add constraint "team_members_user_id_team_id_key" UNIQUE using index "team_members_user_id_team_id_key";

alter table "public"."team_menu_body_items" add constraint "team_menu_body_items_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."team_menu_body_items" validate constraint "team_menu_body_items_language_fkey";

alter table "public"."team_menu_body_items" add constraint "team_menu_body_items_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."team_menu_body_items" validate constraint "team_menu_body_items_team_id_fkey";

alter table "public"."team_menu_body_items" add constraint "team_menu_body_items_team_id_item_key_language_key" UNIQUE using index "team_menu_body_items_team_id_item_key_language_key";

alter table "public"."team_menu_body_items" add constraint "team_menu_body_items_team_id_position_key" UNIQUE using index "team_menu_body_items_team_id_position_key";

alter table "public"."team_menu_footers" add constraint "team_menu_footers_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."team_menu_footers" validate constraint "team_menu_footers_language_fkey";

alter table "public"."team_menu_footers" add constraint "team_menu_footers_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."team_menu_footers" validate constraint "team_menu_footers_team_id_fkey";

alter table "public"."team_menu_footers" add constraint "team_menu_footers_team_id_language_key" UNIQUE using index "team_menu_footers_team_id_language_key";

alter table "public"."team_menu_header_items" add constraint "team_menu_header_items_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) not valid;

alter table "public"."team_menu_header_items" validate constraint "team_menu_header_items_language_fkey";

alter table "public"."team_menu_header_items" add constraint "team_menu_header_items_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."team_menu_header_items" validate constraint "team_menu_header_items_team_id_fkey";

alter table "public"."team_menu_header_items" add constraint "team_menu_header_items_team_id_item_key_language_key" UNIQUE using index "team_menu_header_items_team_id_item_key_language_key";

alter table "public"."team_menu_header_items" add constraint "team_menu_header_items_team_id_position_key" UNIQUE using index "team_menu_header_items_team_id_position_key";

alter table "public"."teams" add constraint "teams_subdomain_key" UNIQUE using index "teams_subdomain_key";

alter table "public"."users" add constraint "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."users" validate constraint "users_id_fkey";

alter table "public"."welcome_messages" add constraint "welcome_messages_language_fkey" FOREIGN KEY (language) REFERENCES languages(code) ON DELETE CASCADE not valid;

alter table "public"."welcome_messages" validate constraint "welcome_messages_language_fkey";

alter table "public"."welcome_messages" add constraint "welcome_messages_team_id_fkey" FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE not valid;

alter table "public"."welcome_messages" validate constraint "welcome_messages_team_id_fkey";

alter table "public"."welcome_messages" add constraint "welcome_messages_team_id_language_key" UNIQUE using index "welcome_messages_team_id_language_key";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_auth_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  insert into public.users (id, email)
  values (new.id, new.email);
  return new;
end;
$function$
;

grant delete on table "public"."assistant_descriptions" to "anon";

grant insert on table "public"."assistant_descriptions" to "anon";

grant references on table "public"."assistant_descriptions" to "anon";

grant select on table "public"."assistant_descriptions" to "anon";

grant trigger on table "public"."assistant_descriptions" to "anon";

grant truncate on table "public"."assistant_descriptions" to "anon";

grant update on table "public"."assistant_descriptions" to "anon";

grant delete on table "public"."assistant_descriptions" to "authenticated";

grant insert on table "public"."assistant_descriptions" to "authenticated";

grant references on table "public"."assistant_descriptions" to "authenticated";

grant select on table "public"."assistant_descriptions" to "authenticated";

grant trigger on table "public"."assistant_descriptions" to "authenticated";

grant truncate on table "public"."assistant_descriptions" to "authenticated";

grant update on table "public"."assistant_descriptions" to "authenticated";

grant delete on table "public"."assistant_descriptions" to "service_role";

grant insert on table "public"."assistant_descriptions" to "service_role";

grant references on table "public"."assistant_descriptions" to "service_role";

grant select on table "public"."assistant_descriptions" to "service_role";

grant trigger on table "public"."assistant_descriptions" to "service_role";

grant truncate on table "public"."assistant_descriptions" to "service_role";

grant update on table "public"."assistant_descriptions" to "service_role";

grant delete on table "public"."assistant_entry_points" to "anon";

grant insert on table "public"."assistant_entry_points" to "anon";

grant references on table "public"."assistant_entry_points" to "anon";

grant select on table "public"."assistant_entry_points" to "anon";

grant trigger on table "public"."assistant_entry_points" to "anon";

grant truncate on table "public"."assistant_entry_points" to "anon";

grant update on table "public"."assistant_entry_points" to "anon";

grant delete on table "public"."assistant_entry_points" to "authenticated";

grant insert on table "public"."assistant_entry_points" to "authenticated";

grant references on table "public"."assistant_entry_points" to "authenticated";

grant select on table "public"."assistant_entry_points" to "authenticated";

grant trigger on table "public"."assistant_entry_points" to "authenticated";

grant truncate on table "public"."assistant_entry_points" to "authenticated";

grant update on table "public"."assistant_entry_points" to "authenticated";

grant delete on table "public"."assistant_entry_points" to "service_role";

grant insert on table "public"."assistant_entry_points" to "service_role";

grant references on table "public"."assistant_entry_points" to "service_role";

grant select on table "public"."assistant_entry_points" to "service_role";

grant trigger on table "public"."assistant_entry_points" to "service_role";

grant truncate on table "public"."assistant_entry_points" to "service_role";

grant update on table "public"."assistant_entry_points" to "service_role";

grant delete on table "public"."assistants" to "anon";

grant insert on table "public"."assistants" to "anon";

grant references on table "public"."assistants" to "anon";

grant select on table "public"."assistants" to "anon";

grant trigger on table "public"."assistants" to "anon";

grant truncate on table "public"."assistants" to "anon";

grant update on table "public"."assistants" to "anon";

grant delete on table "public"."assistants" to "authenticated";

grant insert on table "public"."assistants" to "authenticated";

grant references on table "public"."assistants" to "authenticated";

grant select on table "public"."assistants" to "authenticated";

grant trigger on table "public"."assistants" to "authenticated";

grant truncate on table "public"."assistants" to "authenticated";

grant update on table "public"."assistants" to "authenticated";

grant delete on table "public"."assistants" to "service_role";

grant insert on table "public"."assistants" to "service_role";

grant references on table "public"."assistants" to "service_role";

grant select on table "public"."assistants" to "service_role";

grant trigger on table "public"."assistants" to "service_role";

grant truncate on table "public"."assistants" to "service_role";

grant update on table "public"."assistants" to "service_role";

grant delete on table "public"."footer_text_team" to "anon";

grant insert on table "public"."footer_text_team" to "anon";

grant references on table "public"."footer_text_team" to "anon";

grant select on table "public"."footer_text_team" to "anon";

grant trigger on table "public"."footer_text_team" to "anon";

grant truncate on table "public"."footer_text_team" to "anon";

grant update on table "public"."footer_text_team" to "anon";

grant delete on table "public"."footer_text_team" to "authenticated";

grant insert on table "public"."footer_text_team" to "authenticated";

grant references on table "public"."footer_text_team" to "authenticated";

grant select on table "public"."footer_text_team" to "authenticated";

grant trigger on table "public"."footer_text_team" to "authenticated";

grant truncate on table "public"."footer_text_team" to "authenticated";

grant update on table "public"."footer_text_team" to "authenticated";

grant delete on table "public"."footer_text_team" to "service_role";

grant insert on table "public"."footer_text_team" to "service_role";

grant references on table "public"."footer_text_team" to "service_role";

grant select on table "public"."footer_text_team" to "service_role";

grant trigger on table "public"."footer_text_team" to "service_role";

grant truncate on table "public"."footer_text_team" to "service_role";

grant update on table "public"."footer_text_team" to "service_role";

grant delete on table "public"."invitations" to "anon";

grant insert on table "public"."invitations" to "anon";

grant references on table "public"."invitations" to "anon";

grant select on table "public"."invitations" to "anon";

grant trigger on table "public"."invitations" to "anon";

grant truncate on table "public"."invitations" to "anon";

grant update on table "public"."invitations" to "anon";

grant delete on table "public"."invitations" to "authenticated";

grant insert on table "public"."invitations" to "authenticated";

grant references on table "public"."invitations" to "authenticated";

grant select on table "public"."invitations" to "authenticated";

grant trigger on table "public"."invitations" to "authenticated";

grant truncate on table "public"."invitations" to "authenticated";

grant update on table "public"."invitations" to "authenticated";

grant delete on table "public"."invitations" to "service_role";

grant insert on table "public"."invitations" to "service_role";

grant references on table "public"."invitations" to "service_role";

grant select on table "public"."invitations" to "service_role";

grant trigger on table "public"."invitations" to "service_role";

grant truncate on table "public"."invitations" to "service_role";

grant update on table "public"."invitations" to "service_role";

grant delete on table "public"."languages" to "anon";

grant insert on table "public"."languages" to "anon";

grant references on table "public"."languages" to "anon";

grant select on table "public"."languages" to "anon";

grant trigger on table "public"."languages" to "anon";

grant truncate on table "public"."languages" to "anon";

grant update on table "public"."languages" to "anon";

grant delete on table "public"."languages" to "authenticated";

grant insert on table "public"."languages" to "authenticated";

grant references on table "public"."languages" to "authenticated";

grant select on table "public"."languages" to "authenticated";

grant trigger on table "public"."languages" to "authenticated";

grant truncate on table "public"."languages" to "authenticated";

grant update on table "public"."languages" to "authenticated";

grant delete on table "public"."languages" to "service_role";

grant insert on table "public"."languages" to "service_role";

grant references on table "public"."languages" to "service_role";

grant select on table "public"."languages" to "service_role";

grant trigger on table "public"."languages" to "service_role";

grant truncate on table "public"."languages" to "service_role";

grant update on table "public"."languages" to "service_role";

grant delete on table "public"."messages" to "anon";

grant insert on table "public"."messages" to "anon";

grant references on table "public"."messages" to "anon";

grant select on table "public"."messages" to "anon";

grant trigger on table "public"."messages" to "anon";

grant truncate on table "public"."messages" to "anon";

grant update on table "public"."messages" to "anon";

grant delete on table "public"."messages" to "authenticated";

grant insert on table "public"."messages" to "authenticated";

grant references on table "public"."messages" to "authenticated";

grant select on table "public"."messages" to "authenticated";

grant trigger on table "public"."messages" to "authenticated";

grant truncate on table "public"."messages" to "authenticated";

grant update on table "public"."messages" to "authenticated";

grant delete on table "public"."messages" to "service_role";

grant insert on table "public"."messages" to "service_role";

grant references on table "public"."messages" to "service_role";

grant select on table "public"."messages" to "service_role";

grant trigger on table "public"."messages" to "service_role";

grant truncate on table "public"."messages" to "service_role";

grant update on table "public"."messages" to "service_role";

grant delete on table "public"."team_descriptions" to "anon";

grant insert on table "public"."team_descriptions" to "anon";

grant references on table "public"."team_descriptions" to "anon";

grant select on table "public"."team_descriptions" to "anon";

grant trigger on table "public"."team_descriptions" to "anon";

grant truncate on table "public"."team_descriptions" to "anon";

grant update on table "public"."team_descriptions" to "anon";

grant delete on table "public"."team_descriptions" to "authenticated";

grant insert on table "public"."team_descriptions" to "authenticated";

grant references on table "public"."team_descriptions" to "authenticated";

grant select on table "public"."team_descriptions" to "authenticated";

grant trigger on table "public"."team_descriptions" to "authenticated";

grant truncate on table "public"."team_descriptions" to "authenticated";

grant update on table "public"."team_descriptions" to "authenticated";

grant delete on table "public"."team_descriptions" to "service_role";

grant insert on table "public"."team_descriptions" to "service_role";

grant references on table "public"."team_descriptions" to "service_role";

grant select on table "public"."team_descriptions" to "service_role";

grant trigger on table "public"."team_descriptions" to "service_role";

grant truncate on table "public"."team_descriptions" to "service_role";

grant update on table "public"."team_descriptions" to "service_role";

grant delete on table "public"."team_header_buttons" to "anon";

grant insert on table "public"."team_header_buttons" to "anon";

grant references on table "public"."team_header_buttons" to "anon";

grant select on table "public"."team_header_buttons" to "anon";

grant trigger on table "public"."team_header_buttons" to "anon";

grant truncate on table "public"."team_header_buttons" to "anon";

grant update on table "public"."team_header_buttons" to "anon";

grant delete on table "public"."team_header_buttons" to "authenticated";

grant insert on table "public"."team_header_buttons" to "authenticated";

grant references on table "public"."team_header_buttons" to "authenticated";

grant select on table "public"."team_header_buttons" to "authenticated";

grant trigger on table "public"."team_header_buttons" to "authenticated";

grant truncate on table "public"."team_header_buttons" to "authenticated";

grant update on table "public"."team_header_buttons" to "authenticated";

grant delete on table "public"."team_header_buttons" to "service_role";

grant insert on table "public"."team_header_buttons" to "service_role";

grant references on table "public"."team_header_buttons" to "service_role";

grant select on table "public"."team_header_buttons" to "service_role";

grant trigger on table "public"."team_header_buttons" to "service_role";

grant truncate on table "public"."team_header_buttons" to "service_role";

grant update on table "public"."team_header_buttons" to "service_role";

grant delete on table "public"."team_members" to "anon";

grant insert on table "public"."team_members" to "anon";

grant references on table "public"."team_members" to "anon";

grant select on table "public"."team_members" to "anon";

grant trigger on table "public"."team_members" to "anon";

grant truncate on table "public"."team_members" to "anon";

grant update on table "public"."team_members" to "anon";

grant delete on table "public"."team_members" to "authenticated";

grant insert on table "public"."team_members" to "authenticated";

grant references on table "public"."team_members" to "authenticated";

grant select on table "public"."team_members" to "authenticated";

grant trigger on table "public"."team_members" to "authenticated";

grant truncate on table "public"."team_members" to "authenticated";

grant update on table "public"."team_members" to "authenticated";

grant delete on table "public"."team_members" to "service_role";

grant insert on table "public"."team_members" to "service_role";

grant references on table "public"."team_members" to "service_role";

grant select on table "public"."team_members" to "service_role";

grant trigger on table "public"."team_members" to "service_role";

grant truncate on table "public"."team_members" to "service_role";

grant update on table "public"."team_members" to "service_role";

grant delete on table "public"."team_menu_body_items" to "anon";

grant insert on table "public"."team_menu_body_items" to "anon";

grant references on table "public"."team_menu_body_items" to "anon";

grant select on table "public"."team_menu_body_items" to "anon";

grant trigger on table "public"."team_menu_body_items" to "anon";

grant truncate on table "public"."team_menu_body_items" to "anon";

grant update on table "public"."team_menu_body_items" to "anon";

grant delete on table "public"."team_menu_body_items" to "authenticated";

grant insert on table "public"."team_menu_body_items" to "authenticated";

grant references on table "public"."team_menu_body_items" to "authenticated";

grant select on table "public"."team_menu_body_items" to "authenticated";

grant trigger on table "public"."team_menu_body_items" to "authenticated";

grant truncate on table "public"."team_menu_body_items" to "authenticated";

grant update on table "public"."team_menu_body_items" to "authenticated";

grant delete on table "public"."team_menu_body_items" to "service_role";

grant insert on table "public"."team_menu_body_items" to "service_role";

grant references on table "public"."team_menu_body_items" to "service_role";

grant select on table "public"."team_menu_body_items" to "service_role";

grant trigger on table "public"."team_menu_body_items" to "service_role";

grant truncate on table "public"."team_menu_body_items" to "service_role";

grant update on table "public"."team_menu_body_items" to "service_role";

grant delete on table "public"."team_menu_footers" to "anon";

grant insert on table "public"."team_menu_footers" to "anon";

grant references on table "public"."team_menu_footers" to "anon";

grant select on table "public"."team_menu_footers" to "anon";

grant trigger on table "public"."team_menu_footers" to "anon";

grant truncate on table "public"."team_menu_footers" to "anon";

grant update on table "public"."team_menu_footers" to "anon";

grant delete on table "public"."team_menu_footers" to "authenticated";

grant insert on table "public"."team_menu_footers" to "authenticated";

grant references on table "public"."team_menu_footers" to "authenticated";

grant select on table "public"."team_menu_footers" to "authenticated";

grant trigger on table "public"."team_menu_footers" to "authenticated";

grant truncate on table "public"."team_menu_footers" to "authenticated";

grant update on table "public"."team_menu_footers" to "authenticated";

grant delete on table "public"."team_menu_footers" to "service_role";

grant insert on table "public"."team_menu_footers" to "service_role";

grant references on table "public"."team_menu_footers" to "service_role";

grant select on table "public"."team_menu_footers" to "service_role";

grant trigger on table "public"."team_menu_footers" to "service_role";

grant truncate on table "public"."team_menu_footers" to "service_role";

grant update on table "public"."team_menu_footers" to "service_role";

grant delete on table "public"."team_menu_header_items" to "anon";

grant insert on table "public"."team_menu_header_items" to "anon";

grant references on table "public"."team_menu_header_items" to "anon";

grant select on table "public"."team_menu_header_items" to "anon";

grant trigger on table "public"."team_menu_header_items" to "anon";

grant truncate on table "public"."team_menu_header_items" to "anon";

grant update on table "public"."team_menu_header_items" to "anon";

grant delete on table "public"."team_menu_header_items" to "authenticated";

grant insert on table "public"."team_menu_header_items" to "authenticated";

grant references on table "public"."team_menu_header_items" to "authenticated";

grant select on table "public"."team_menu_header_items" to "authenticated";

grant trigger on table "public"."team_menu_header_items" to "authenticated";

grant truncate on table "public"."team_menu_header_items" to "authenticated";

grant update on table "public"."team_menu_header_items" to "authenticated";

grant delete on table "public"."team_menu_header_items" to "service_role";

grant insert on table "public"."team_menu_header_items" to "service_role";

grant references on table "public"."team_menu_header_items" to "service_role";

grant select on table "public"."team_menu_header_items" to "service_role";

grant trigger on table "public"."team_menu_header_items" to "service_role";

grant truncate on table "public"."team_menu_header_items" to "service_role";

grant update on table "public"."team_menu_header_items" to "service_role";

grant delete on table "public"."teams" to "anon";

grant insert on table "public"."teams" to "anon";

grant references on table "public"."teams" to "anon";

grant select on table "public"."teams" to "anon";

grant trigger on table "public"."teams" to "anon";

grant truncate on table "public"."teams" to "anon";

grant update on table "public"."teams" to "anon";

grant delete on table "public"."teams" to "authenticated";

grant insert on table "public"."teams" to "authenticated";

grant references on table "public"."teams" to "authenticated";

grant select on table "public"."teams" to "authenticated";

grant trigger on table "public"."teams" to "authenticated";

grant truncate on table "public"."teams" to "authenticated";

grant update on table "public"."teams" to "authenticated";

grant delete on table "public"."teams" to "service_role";

grant insert on table "public"."teams" to "service_role";

grant references on table "public"."teams" to "service_role";

grant select on table "public"."teams" to "service_role";

grant trigger on table "public"."teams" to "service_role";

grant truncate on table "public"."teams" to "service_role";

grant update on table "public"."teams" to "service_role";

grant delete on table "public"."users" to "anon";

grant insert on table "public"."users" to "anon";

grant references on table "public"."users" to "anon";

grant select on table "public"."users" to "anon";

grant trigger on table "public"."users" to "anon";

grant truncate on table "public"."users" to "anon";

grant update on table "public"."users" to "anon";

grant delete on table "public"."users" to "authenticated";

grant insert on table "public"."users" to "authenticated";

grant references on table "public"."users" to "authenticated";

grant select on table "public"."users" to "authenticated";

grant trigger on table "public"."users" to "authenticated";

grant truncate on table "public"."users" to "authenticated";

grant update on table "public"."users" to "authenticated";

grant delete on table "public"."users" to "service_role";

grant insert on table "public"."users" to "service_role";

grant references on table "public"."users" to "service_role";

grant select on table "public"."users" to "service_role";

grant trigger on table "public"."users" to "service_role";

grant truncate on table "public"."users" to "service_role";

grant update on table "public"."users" to "service_role";

grant delete on table "public"."welcome_messages" to "anon";

grant insert on table "public"."welcome_messages" to "anon";

grant references on table "public"."welcome_messages" to "anon";

grant select on table "public"."welcome_messages" to "anon";

grant trigger on table "public"."welcome_messages" to "anon";

grant truncate on table "public"."welcome_messages" to "anon";

grant update on table "public"."welcome_messages" to "anon";

grant delete on table "public"."welcome_messages" to "authenticated";

grant insert on table "public"."welcome_messages" to "authenticated";

grant references on table "public"."welcome_messages" to "authenticated";

grant select on table "public"."welcome_messages" to "authenticated";

grant trigger on table "public"."welcome_messages" to "authenticated";

grant truncate on table "public"."welcome_messages" to "authenticated";

grant update on table "public"."welcome_messages" to "authenticated";

grant delete on table "public"."welcome_messages" to "service_role";

grant insert on table "public"."welcome_messages" to "service_role";

grant references on table "public"."welcome_messages" to "service_role";

grant select on table "public"."welcome_messages" to "service_role";

grant trigger on table "public"."welcome_messages" to "service_role";

grant truncate on table "public"."welcome_messages" to "service_role";

grant update on table "public"."welcome_messages" to "service_role";

create policy "Any authenticated user can select assistant description"
on "public"."assistant_descriptions"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select assistant description"
on "public"."assistant_descriptions"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete assistant description"
on "public"."assistant_descriptions"
as permissive
for delete
to authenticated
using ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))));


create policy "Team admin or global admin can insert assistant description"
on "public"."assistant_descriptions"
as permissive
for insert
to authenticated
with check ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))));


create policy "Team admin or global admin can update assistant description"
on "public"."assistant_descriptions"
as permissive
for update
to authenticated
using ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))))
with check ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))));


create policy "Any authenticated user can select assistant entry point"
on "public"."assistant_entry_points"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select assistant entry point"
on "public"."assistant_entry_points"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete assistant entry point"
on "public"."assistant_entry_points"
as permissive
for delete
to authenticated
using ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))));


create policy "Team admin or global admin can insert assistant entry point"
on "public"."assistant_entry_points"
as permissive
for insert
to authenticated
with check ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))));


create policy "Team admin or global admin can update assistant entry point"
on "public"."assistant_entry_points"
as permissive
for update
to authenticated
using ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))))
with check ((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE ((assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
           FROM users u
          WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))));


create policy "Anyone can select assistant"
on "public"."assistants"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete assistant"
on "public"."assistants"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert assistant"
on "public"."assistants"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can select assistant"
on "public"."assistants"
as permissive
for select
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update assistant"
on "public"."assistants"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Any authenticated user can select footer text"
on "public"."footer_text_team"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select footer text"
on "public"."footer_text_team"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete footer text"
on "public"."footer_text_team"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert footer text"
on "public"."footer_text_team"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update footer text"
on "public"."footer_text_team"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Admin global or team admin can delete invitations"
on "public"."invitations"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Admin global or team admin can insert invitations"
on "public"."invitations"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Admin global or team admin can select invitations"
on "public"."invitations"
as permissive
for select
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "System can update invitation status"
on "public"."invitations"
as permissive
for update
to service_role
using (true)
with check (true);


create policy "Any authenticated user can select language"
on "public"."languages"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select language"
on "public"."languages"
as permissive
for select
to anon
using (true);


create policy "System can insert message"
on "public"."messages"
as permissive
for insert
to service_role
with check (true);


create policy "Team member or global admin can select message"
on "public"."messages"
as permissive
for select
to authenticated
using (((assistant_id IN ( SELECT assistants.id
   FROM assistants
  WHERE (assistants.team_id IN ( SELECT team_members.team_id
           FROM team_members
          WHERE (team_members.user_id = ( SELECT auth.uid() AS uid)))))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Any authenticated user can select team description"
on "public"."team_descriptions"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select team description"
on "public"."team_descriptions"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete team description"
on "public"."team_descriptions"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert team description"
on "public"."team_descriptions"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update team description"
on "public"."team_descriptions"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Any authenticated user can select team header button"
on "public"."team_header_buttons"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select team header button"
on "public"."team_header_buttons"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete team header button"
on "public"."team_header_buttons"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert team header button"
on "public"."team_header_buttons"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update team header button"
on "public"."team_header_buttons"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Admin global or team admin can delete team membership"
on "public"."team_members"
as permissive
for delete
to authenticated
using (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (team_id IN ( SELECT team_members_1.team_id
   FROM team_members team_members_1
  WHERE ((team_members_1.user_id = ( SELECT auth.uid() AS uid)) AND (team_members_1.role = 'admin'::team_role))))));


create policy "Admin global or team admin can insert team membership"
on "public"."team_members"
as permissive
for insert
to authenticated
with check (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (team_id IN ( SELECT team_members_1.team_id
   FROM team_members team_members_1
  WHERE ((team_members_1.user_id = ( SELECT auth.uid() AS uid)) AND (team_members_1.role = 'admin'::team_role))))));


create policy "Admin global or team admin can update team membership"
on "public"."team_members"
as permissive
for update
to authenticated
using (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (team_id IN ( SELECT team_members_1.team_id
   FROM team_members team_members_1
  WHERE ((team_members_1.user_id = ( SELECT auth.uid() AS uid)) AND (team_members_1.role = 'admin'::team_role))))))
with check (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (team_id IN ( SELECT team_members_1.team_id
   FROM team_members team_members_1
  WHERE ((team_members_1.user_id = ( SELECT auth.uid() AS uid)) AND (team_members_1.role = 'admin'::team_role))))));


create policy "User, admin global or team admin can select team membership"
on "public"."team_members"
as permissive
for select
to authenticated
using (((user_id = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (team_id IN ( SELECT team_members_1.team_id
   FROM team_members team_members_1
  WHERE ((team_members_1.user_id = ( SELECT auth.uid() AS uid)) AND (team_members_1.role = 'admin'::team_role))))));


create policy "Any authenticated user can select team menu body item"
on "public"."team_menu_body_items"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select team menu body item"
on "public"."team_menu_body_items"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete team menu body item"
on "public"."team_menu_body_items"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert team menu body item"
on "public"."team_menu_body_items"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update team menu body item"
on "public"."team_menu_body_items"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Any authenticated user can select team menu header item"
on "public"."team_menu_header_items"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select team menu header item"
on "public"."team_menu_header_items"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete team menu header item"
on "public"."team_menu_header_items"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert team menu header item"
on "public"."team_menu_header_items"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update team menu header item"
on "public"."team_menu_header_items"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Admin global or team admin can delete team"
on "public"."teams"
as permissive
for delete
to authenticated
using (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role))))));


create policy "Admin global or team admin can update team"
on "public"."teams"
as permissive
for update
to authenticated
using (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role))))))
with check (((EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true)))) OR (id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role))))));


create policy "Any authenticated user can insert team"
on "public"."teams"
as permissive
for insert
to authenticated
with check (true);


create policy "Team member or admin global can select team"
on "public"."teams"
as permissive
for select
to authenticated
using (((id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE (team_members.user_id = ( SELECT auth.uid() AS uid)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "User can insert own profile"
on "public"."users"
as permissive
for insert
to authenticated
with check ((( SELECT auth.uid() AS uid) = id));


create policy "User or admin global can delete user"
on "public"."users"
as permissive
for delete
to authenticated
using (((( SELECT auth.uid() AS uid) = id) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "User or admin global can select user"
on "public"."users"
as permissive
for select
to authenticated
using (((( SELECT auth.uid() AS uid) = id) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "User or admin global can update user"
on "public"."users"
as permissive
for update
to authenticated
using (((( SELECT auth.uid() AS uid) = id) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((( SELECT auth.uid() AS uid) = id) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Any authenticated user can select welcome message"
on "public"."welcome_messages"
as permissive
for select
to authenticated
using (true);


create policy "Anyone can select welcome message"
on "public"."welcome_messages"
as permissive
for select
to anon
using (true);


create policy "Team admin or global admin can delete welcome message"
on "public"."welcome_messages"
as permissive
for delete
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can insert welcome message"
on "public"."welcome_messages"
as permissive
for insert
to authenticated
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));


create policy "Team admin or global admin can update welcome message"
on "public"."welcome_messages"
as permissive
for update
to authenticated
using (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))))
with check (((team_id IN ( SELECT team_members.team_id
   FROM team_members
  WHERE ((team_members.user_id = ( SELECT auth.uid() AS uid)) AND (team_members.role = 'admin'::team_role)))) OR (EXISTS ( SELECT 1
   FROM users u
  WHERE ((u.id = ( SELECT auth.uid() AS uid)) AND (u.is_global_admin = true))))));



