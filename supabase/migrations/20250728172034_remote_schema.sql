create sequence "public"."Characters_character_id_seq";

create sequence "public"."Clues_clue_id_seq";

create sequence "public"."Final_Reveal_reveal_id_seq";

create sequence "public"."Game_Variations_variation_id_seq";

create sequence "public"."Games_game_id_seq";

create sequence "public"."Order_Items_order_item_id_seq";

create sequence "public"."Orders_order_id_seq";

create sequence "public"."Rounds_round_id_seq";

create sequence "public"."new_character_id_seq";

create sequence "public"."new_clue_id_seq";

create table "public"."Character_Variations" (
    "character_id" integer not null,
    "variation_id" integer not null
);


alter table "public"."Character_Variations" enable row level security;

create table "public"."Characters" (
    "character_id" integer not null default nextval('"Characters_character_id_seq"'::regclass),
    "variation_id" integer,
    "name" character varying(255) not null,
    "description" text,
    "secret" text,
    "name_bg" text,
    "description_bg" text,
    "secret_bg" text,
    "connection" text,
    "connection_bg" text,
    "circumstances" text,
    "circumstances_bg" text
);


alter table "public"."Characters" enable row level security;

create table "public"."Clue_Rounds" (
    "clue_id" integer not null,
    "round_id" integer not null,
    "clue_number" integer not null
);


alter table "public"."Clue_Rounds" enable row level security;

create table "public"."Clues" (
    "clue_id" integer not null default nextval('"Clues_clue_id_seq"'::regclass),
    "round_id" integer,
    "clue_number" integer,
    "content" text not null,
    "content_bg" text,
    "hidden" boolean default false
);


alter table "public"."Clues" enable row level security;

create table "public"."Final_Reveal" (
    "reveal_id" integer not null default nextval('"Final_Reveal_reveal_id_seq"'::regclass),
    "variation_id" integer not null,
    "content" text not null,
    "murderer" text,
    "content_bg" text,
    "murderer_bg" text
);


alter table "public"."Final_Reveal" enable row level security;

create table "public"."Game_Variations" (
    "variation_id" integer not null default nextval('"Game_Variations_variation_id_seq"'::regclass),
    "game_id" integer not null,
    "num_players" integer not null,
    "variation_title" character varying(255),
    "notes" text,
    "variation_title_bg" text,
    "notes_bg" text
);


alter table "public"."Game_Variations" enable row level security;

create table "public"."Games" (
    "game_id" integer not null default nextval('"Games_game_id_seq"'::regclass),
    "title" character varying(255) not null,
    "description" text,
    "setting" text,
    "price" numeric(10,2) not null,
    "is_active" boolean not null default true,
    "subtitle" character varying(255),
    "image" character varying(255),
    "difficulty" character varying(10),
    "players" character varying(50),
    "duration" character varying(50),
    "featured" boolean default false,
    "title_bg" text,
    "subtitle_bg" text,
    "description_bg" text,
    "difficulty_bg" character varying,
    "victim" text,
    "victim_bg" text,
    "setting_bg" text,
    "image_path" text
);


alter table "public"."Games" enable row level security;

create table "public"."Order_Items" (
    "order_item_id" integer not null default nextval('"Order_Items_order_item_id_seq"'::regclass),
    "order_id" integer not null,
    "game_id" integer not null,
    "price" numeric(10,2) not null,
    "quantity" integer not null default 1,
    "created_at" timestamp with time zone default CURRENT_TIMESTAMP
);


alter table "public"."Order_Items" enable row level security;

create table "public"."Orders" (
    "order_id" integer not null default nextval('"Orders_order_id_seq"'::regclass),
    "user_id" uuid not null,
    "order_date" timestamp without time zone not null default CURRENT_TIMESTAMP,
    "total_amount" numeric(10,2) not null,
    "status" character varying(50) not null,
    "payment_intent_id" text
);


alter table "public"."Orders" enable row level security;

create table "public"."Rounds" (
    "round_id" integer not null default nextval('"Rounds_round_id_seq"'::regclass),
    "variation_id" integer not null,
    "round_number" integer not null,
    "title" character varying(255),
    "description" text,
    "title_bg" text,
    "description_bg" text
);


alter table "public"."Rounds" enable row level security;

create table "public"."User_Game_Access" (
    "user_id" uuid not null,
    "game_id" integer not null,
    "access_granted" timestamp without time zone not null default CURRENT_TIMESTAMP
);


alter table "public"."User_Game_Access" enable row level security;

create table "public"."Users" (
    "user_id" uuid not null,
    "email" character varying(255) not null,
    "created_at" timestamp without time zone not null default CURRENT_TIMESTAMP
);


alter table "public"."Users" enable row level security;

alter sequence "public"."Characters_character_id_seq" owned by "public"."Characters"."character_id";

alter sequence "public"."Clues_clue_id_seq" owned by "public"."Clues"."clue_id";

alter sequence "public"."Final_Reveal_reveal_id_seq" owned by "public"."Final_Reveal"."reveal_id";

alter sequence "public"."Game_Variations_variation_id_seq" owned by "public"."Game_Variations"."variation_id";

alter sequence "public"."Games_game_id_seq" owned by "public"."Games"."game_id";

alter sequence "public"."Order_Items_order_item_id_seq" owned by "public"."Order_Items"."order_item_id";

alter sequence "public"."Orders_order_id_seq" owned by "public"."Orders"."order_id";

alter sequence "public"."Rounds_round_id_seq" owned by "public"."Rounds"."round_id";

CREATE UNIQUE INDEX "Character_Variations_pkey" ON public."Character_Variations" USING btree (character_id, variation_id);

CREATE UNIQUE INDEX "Characters_pkey" ON public."Characters" USING btree (character_id);

CREATE UNIQUE INDEX "Clue_Rounds_pkey" ON public."Clue_Rounds" USING btree (clue_id, round_id);

CREATE UNIQUE INDEX "Clues_pkey" ON public."Clues" USING btree (clue_id);

CREATE UNIQUE INDEX "Final_Reveal_pkey" ON public."Final_Reveal" USING btree (reveal_id);

CREATE UNIQUE INDEX "Game_Variations_pkey" ON public."Game_Variations" USING btree (variation_id);

CREATE UNIQUE INDEX "Games_pkey" ON public."Games" USING btree (game_id);

CREATE UNIQUE INDEX "Order_Items_pkey" ON public."Order_Items" USING btree (order_item_id);

CREATE UNIQUE INDEX "Orders_pkey" ON public."Orders" USING btree (order_id);

CREATE UNIQUE INDEX "Rounds_pkey" ON public."Rounds" USING btree (round_id);

CREATE UNIQUE INDEX "User_Game_Access_pkey" ON public."User_Game_Access" USING btree (user_id, game_id);

CREATE UNIQUE INDEX "Users_email_key" ON public."Users" USING btree (email);

CREATE UNIQUE INDEX "Users_pkey" ON public."Users" USING btree (user_id);

CREATE INDEX idx_character_variations_character_id ON public."Character_Variations" USING btree (character_id);

CREATE INDEX idx_character_variations_variation_id ON public."Character_Variations" USING btree (variation_id);

CREATE INDEX idx_clue_rounds_clue_id ON public."Clue_Rounds" USING btree (clue_id);

CREATE INDEX idx_clue_rounds_round_id ON public."Clue_Rounds" USING btree (round_id);

alter table "public"."Character_Variations" add constraint "Character_Variations_pkey" PRIMARY KEY using index "Character_Variations_pkey";

alter table "public"."Characters" add constraint "Characters_pkey" PRIMARY KEY using index "Characters_pkey";

alter table "public"."Clue_Rounds" add constraint "Clue_Rounds_pkey" PRIMARY KEY using index "Clue_Rounds_pkey";

alter table "public"."Clues" add constraint "Clues_pkey" PRIMARY KEY using index "Clues_pkey";

alter table "public"."Final_Reveal" add constraint "Final_Reveal_pkey" PRIMARY KEY using index "Final_Reveal_pkey";

alter table "public"."Game_Variations" add constraint "Game_Variations_pkey" PRIMARY KEY using index "Game_Variations_pkey";

alter table "public"."Games" add constraint "Games_pkey" PRIMARY KEY using index "Games_pkey";

alter table "public"."Order_Items" add constraint "Order_Items_pkey" PRIMARY KEY using index "Order_Items_pkey";

alter table "public"."Orders" add constraint "Orders_pkey" PRIMARY KEY using index "Orders_pkey";

alter table "public"."Rounds" add constraint "Rounds_pkey" PRIMARY KEY using index "Rounds_pkey";

alter table "public"."User_Game_Access" add constraint "User_Game_Access_pkey" PRIMARY KEY using index "User_Game_Access_pkey";

alter table "public"."Users" add constraint "Users_pkey" PRIMARY KEY using index "Users_pkey";

alter table "public"."Character_Variations" add constraint "Character_Variations_character_id_fkey" FOREIGN KEY (character_id) REFERENCES "Characters"(character_id) ON DELETE CASCADE not valid;

alter table "public"."Character_Variations" validate constraint "Character_Variations_character_id_fkey";

alter table "public"."Character_Variations" add constraint "Character_Variations_variation_id_fkey" FOREIGN KEY (variation_id) REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE not valid;

alter table "public"."Character_Variations" validate constraint "Character_Variations_variation_id_fkey";

alter table "public"."Characters" add constraint "Characters_variation_id_fkey" FOREIGN KEY (variation_id) REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE not valid;

alter table "public"."Characters" validate constraint "Characters_variation_id_fkey";

alter table "public"."Clue_Rounds" add constraint "Clue_Rounds_clue_id_fkey" FOREIGN KEY (clue_id) REFERENCES "Clues"(clue_id) ON DELETE CASCADE not valid;

alter table "public"."Clue_Rounds" validate constraint "Clue_Rounds_clue_id_fkey";

alter table "public"."Clue_Rounds" add constraint "Clue_Rounds_round_id_fkey" FOREIGN KEY (round_id) REFERENCES "Rounds"(round_id) ON DELETE CASCADE not valid;

alter table "public"."Clue_Rounds" validate constraint "Clue_Rounds_round_id_fkey";

alter table "public"."Clues" add constraint "Clues_round_id_fkey" FOREIGN KEY (round_id) REFERENCES "Rounds"(round_id) ON DELETE CASCADE not valid;

alter table "public"."Clues" validate constraint "Clues_round_id_fkey";

alter table "public"."Final_Reveal" add constraint "Final_Reveal_variation_id_fkey" FOREIGN KEY (variation_id) REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE not valid;

alter table "public"."Final_Reveal" validate constraint "Final_Reveal_variation_id_fkey";

alter table "public"."Game_Variations" add constraint "Game_Variations_game_id_fkey" FOREIGN KEY (game_id) REFERENCES "Games"(game_id) ON DELETE CASCADE not valid;

alter table "public"."Game_Variations" validate constraint "Game_Variations_game_id_fkey";

alter table "public"."Game_Variations" add constraint "Game_Variations_num_players_check" CHECK (((num_players >= 5) AND (num_players <= 10))) not valid;

alter table "public"."Game_Variations" validate constraint "Game_Variations_num_players_check";

alter table "public"."Games" add constraint "Games_difficulty_check" CHECK (((difficulty)::text = ANY (ARRAY[('Easy'::character varying)::text, ('Medium'::character varying)::text, ('Hard'::character varying)::text]))) not valid;

alter table "public"."Games" validate constraint "Games_difficulty_check";

alter table "public"."Order_Items" add constraint "Order_Items_game_id_fkey" FOREIGN KEY (game_id) REFERENCES "Games"(game_id) ON DELETE CASCADE not valid;

alter table "public"."Order_Items" validate constraint "Order_Items_game_id_fkey";

alter table "public"."Order_Items" add constraint "Order_Items_order_id_fkey" FOREIGN KEY (order_id) REFERENCES "Orders"(order_id) ON DELETE CASCADE not valid;

alter table "public"."Order_Items" validate constraint "Order_Items_order_id_fkey";

alter table "public"."Orders" add constraint "Orders_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "Users"(user_id) ON DELETE CASCADE not valid;

alter table "public"."Orders" validate constraint "Orders_user_id_fkey";

alter table "public"."Rounds" add constraint "Rounds_variation_id_fkey" FOREIGN KEY (variation_id) REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE not valid;

alter table "public"."Rounds" validate constraint "Rounds_variation_id_fkey";

alter table "public"."User_Game_Access" add constraint "User_Game_Access_game_id_fkey" FOREIGN KEY (game_id) REFERENCES "Games"(game_id) ON DELETE CASCADE not valid;

alter table "public"."User_Game_Access" validate constraint "User_Game_Access_game_id_fkey";

alter table "public"."User_Game_Access" add constraint "User_Game_Access_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "Users"(user_id) ON DELETE CASCADE not valid;

alter table "public"."User_Game_Access" validate constraint "User_Game_Access_user_id_fkey";

alter table "public"."Users" add constraint "Users_email_key" UNIQUE using index "Users_email_key";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.get_current_protocol()
 RETURNS text
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN COALESCE(current_setting('app.settings.protocol', true), 'https://');
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_game_image_url(image_path text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    supabase_url TEXT;
    protocol TEXT;
BEGIN
  -- Get protocol setting (default to https://)
  protocol := COALESCE(current_setting('app.settings.protocol', true), 'https://');
  
  -- Get Supabase URL from multiple sources
  supabase_url := COALESCE(
    current_setting('app.settings.supabase_url', true),
    current_setting('SUPABASE_URL', true),
    'gkuwrqpxwehfnmlsqsxa.supabase.co'  -- Fallback
  );
  
  -- If image_path is provided, construct the Supabase Storage URL
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN protocol || supabase_url || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_game_image_url_secure(image_path text, game_id integer DEFAULT NULL::integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
  user_id UUID;
  has_access BOOLEAN := FALSE;
BEGIN
  user_id := auth.uid();
  
  IF game_id IS NULL THEN
    has_access := TRUE;
  ELSE
    SELECT EXISTS (
      SELECT 1 FROM "Order_Items" oi
      JOIN "Orders" o ON oi.order_id = o.order_id
      WHERE oi.game_id = game_id 
      AND o.user_id = user_id 
      AND o.status = 'completed'
    ) INTO has_access;
    
    IF NOT has_access THEN
      SELECT is_active FROM "Games" WHERE game_id = game_id INTO has_access;
    END IF;
  END IF;
  
  IF has_access AND image_path IS NOT NULL AND image_path != '' THEN
    RETURN COALESCE(current_setting('app.settings.protocol', true), 'https://') || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.grant_game_access_on_purchase()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_user_id UUID;
  v_status TEXT;
BEGIN
  -- Get the user_id and status from the Orders table
  SELECT user_id, status INTO v_user_id, v_status
  FROM "Orders"
  WHERE order_id = NEW.order_id;
  
  -- Only grant access if the order is completed
  IF v_status = 'completed' THEN
    -- Insert access record if it doesn't exist
    INSERT INTO "User_Game_Access" (user_id, game_id)
    VALUES (v_user_id, NEW.game_id)
    ON CONFLICT (user_id, game_id) DO NOTHING;
  END IF;
  
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Insert the new user into the Users table
  INSERT INTO "Users" (user_id, email)
  VALUES (NEW.id, NEW.email)
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.update_protocol_setting(new_protocol text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF auth.role() != 'authenticated' THEN
        RAISE EXCEPTION 'Only authenticated users can update protocol setting';
    END IF;
    
    IF new_protocol NOT IN ('http://', 'https://') THEN
        RAISE EXCEPTION 'Protocol must be either http:// or https://';
    END IF;
    
    PERFORM set_config('app.settings.protocol', new_protocol, false);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.update_supabase_url(new_url text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Only allow authenticated users to update the URL
    IF auth.role() != 'authenticated' THEN
        RAISE EXCEPTION 'Only authenticated users can update Supabase URL';
    END IF;
    
    -- Validate URL format
    IF new_url !~ '^[a-zA-Z0-9.-]+\.supabase\.co$' THEN
        RAISE EXCEPTION 'Invalid Supabase URL format. Expected: your-project.supabase.co';
    END IF;
    
    PERFORM set_config('app.settings.supabase_url', new_url, false);
END;
$function$
;

create or replace view "public"."games_with_images" as  SELECT game_id,
    title,
    description,
    setting,
    price,
    is_active,
    subtitle,
    image,
    difficulty,
    players,
    duration,
    featured,
    title_bg,
    subtitle_bg,
    description_bg,
    difficulty_bg,
    victim,
    victim_bg,
    setting_bg,
    image_path,
    COALESCE(get_game_image_url(image_path), (image)::text) AS image_url
   FROM "Games" g;


grant delete on table "public"."Character_Variations" to "anon";

grant insert on table "public"."Character_Variations" to "anon";

grant references on table "public"."Character_Variations" to "anon";

grant select on table "public"."Character_Variations" to "anon";

grant trigger on table "public"."Character_Variations" to "anon";

grant truncate on table "public"."Character_Variations" to "anon";

grant update on table "public"."Character_Variations" to "anon";

grant delete on table "public"."Character_Variations" to "authenticated";

grant insert on table "public"."Character_Variations" to "authenticated";

grant references on table "public"."Character_Variations" to "authenticated";

grant select on table "public"."Character_Variations" to "authenticated";

grant trigger on table "public"."Character_Variations" to "authenticated";

grant truncate on table "public"."Character_Variations" to "authenticated";

grant update on table "public"."Character_Variations" to "authenticated";

grant delete on table "public"."Character_Variations" to "service_role";

grant insert on table "public"."Character_Variations" to "service_role";

grant references on table "public"."Character_Variations" to "service_role";

grant select on table "public"."Character_Variations" to "service_role";

grant trigger on table "public"."Character_Variations" to "service_role";

grant truncate on table "public"."Character_Variations" to "service_role";

grant update on table "public"."Character_Variations" to "service_role";

grant delete on table "public"."Characters" to "anon";

grant insert on table "public"."Characters" to "anon";

grant references on table "public"."Characters" to "anon";

grant select on table "public"."Characters" to "anon";

grant trigger on table "public"."Characters" to "anon";

grant truncate on table "public"."Characters" to "anon";

grant update on table "public"."Characters" to "anon";

grant delete on table "public"."Characters" to "authenticated";

grant insert on table "public"."Characters" to "authenticated";

grant references on table "public"."Characters" to "authenticated";

grant select on table "public"."Characters" to "authenticated";

grant trigger on table "public"."Characters" to "authenticated";

grant truncate on table "public"."Characters" to "authenticated";

grant update on table "public"."Characters" to "authenticated";

grant delete on table "public"."Characters" to "service_role";

grant insert on table "public"."Characters" to "service_role";

grant references on table "public"."Characters" to "service_role";

grant select on table "public"."Characters" to "service_role";

grant trigger on table "public"."Characters" to "service_role";

grant truncate on table "public"."Characters" to "service_role";

grant update on table "public"."Characters" to "service_role";

grant delete on table "public"."Clue_Rounds" to "anon";

grant insert on table "public"."Clue_Rounds" to "anon";

grant references on table "public"."Clue_Rounds" to "anon";

grant select on table "public"."Clue_Rounds" to "anon";

grant trigger on table "public"."Clue_Rounds" to "anon";

grant truncate on table "public"."Clue_Rounds" to "anon";

grant update on table "public"."Clue_Rounds" to "anon";

grant delete on table "public"."Clue_Rounds" to "authenticated";

grant insert on table "public"."Clue_Rounds" to "authenticated";

grant references on table "public"."Clue_Rounds" to "authenticated";

grant select on table "public"."Clue_Rounds" to "authenticated";

grant trigger on table "public"."Clue_Rounds" to "authenticated";

grant truncate on table "public"."Clue_Rounds" to "authenticated";

grant update on table "public"."Clue_Rounds" to "authenticated";

grant delete on table "public"."Clue_Rounds" to "service_role";

grant insert on table "public"."Clue_Rounds" to "service_role";

grant references on table "public"."Clue_Rounds" to "service_role";

grant select on table "public"."Clue_Rounds" to "service_role";

grant trigger on table "public"."Clue_Rounds" to "service_role";

grant truncate on table "public"."Clue_Rounds" to "service_role";

grant update on table "public"."Clue_Rounds" to "service_role";

grant delete on table "public"."Clues" to "anon";

grant insert on table "public"."Clues" to "anon";

grant references on table "public"."Clues" to "anon";

grant select on table "public"."Clues" to "anon";

grant trigger on table "public"."Clues" to "anon";

grant truncate on table "public"."Clues" to "anon";

grant update on table "public"."Clues" to "anon";

grant delete on table "public"."Clues" to "authenticated";

grant insert on table "public"."Clues" to "authenticated";

grant references on table "public"."Clues" to "authenticated";

grant select on table "public"."Clues" to "authenticated";

grant trigger on table "public"."Clues" to "authenticated";

grant truncate on table "public"."Clues" to "authenticated";

grant update on table "public"."Clues" to "authenticated";

grant delete on table "public"."Clues" to "service_role";

grant insert on table "public"."Clues" to "service_role";

grant references on table "public"."Clues" to "service_role";

grant select on table "public"."Clues" to "service_role";

grant trigger on table "public"."Clues" to "service_role";

grant truncate on table "public"."Clues" to "service_role";

grant update on table "public"."Clues" to "service_role";

grant delete on table "public"."Final_Reveal" to "anon";

grant insert on table "public"."Final_Reveal" to "anon";

grant references on table "public"."Final_Reveal" to "anon";

grant select on table "public"."Final_Reveal" to "anon";

grant trigger on table "public"."Final_Reveal" to "anon";

grant truncate on table "public"."Final_Reveal" to "anon";

grant update on table "public"."Final_Reveal" to "anon";

grant delete on table "public"."Final_Reveal" to "authenticated";

grant insert on table "public"."Final_Reveal" to "authenticated";

grant references on table "public"."Final_Reveal" to "authenticated";

grant select on table "public"."Final_Reveal" to "authenticated";

grant trigger on table "public"."Final_Reveal" to "authenticated";

grant truncate on table "public"."Final_Reveal" to "authenticated";

grant update on table "public"."Final_Reveal" to "authenticated";

grant delete on table "public"."Final_Reveal" to "service_role";

grant insert on table "public"."Final_Reveal" to "service_role";

grant references on table "public"."Final_Reveal" to "service_role";

grant select on table "public"."Final_Reveal" to "service_role";

grant trigger on table "public"."Final_Reveal" to "service_role";

grant truncate on table "public"."Final_Reveal" to "service_role";

grant update on table "public"."Final_Reveal" to "service_role";

grant delete on table "public"."Game_Variations" to "anon";

grant insert on table "public"."Game_Variations" to "anon";

grant references on table "public"."Game_Variations" to "anon";

grant select on table "public"."Game_Variations" to "anon";

grant trigger on table "public"."Game_Variations" to "anon";

grant truncate on table "public"."Game_Variations" to "anon";

grant update on table "public"."Game_Variations" to "anon";

grant delete on table "public"."Game_Variations" to "authenticated";

grant insert on table "public"."Game_Variations" to "authenticated";

grant references on table "public"."Game_Variations" to "authenticated";

grant select on table "public"."Game_Variations" to "authenticated";

grant trigger on table "public"."Game_Variations" to "authenticated";

grant truncate on table "public"."Game_Variations" to "authenticated";

grant update on table "public"."Game_Variations" to "authenticated";

grant delete on table "public"."Game_Variations" to "service_role";

grant insert on table "public"."Game_Variations" to "service_role";

grant references on table "public"."Game_Variations" to "service_role";

grant select on table "public"."Game_Variations" to "service_role";

grant trigger on table "public"."Game_Variations" to "service_role";

grant truncate on table "public"."Game_Variations" to "service_role";

grant update on table "public"."Game_Variations" to "service_role";

grant delete on table "public"."Games" to "anon";

grant insert on table "public"."Games" to "anon";

grant references on table "public"."Games" to "anon";

grant select on table "public"."Games" to "anon";

grant trigger on table "public"."Games" to "anon";

grant truncate on table "public"."Games" to "anon";

grant update on table "public"."Games" to "anon";

grant delete on table "public"."Games" to "authenticated";

grant insert on table "public"."Games" to "authenticated";

grant references on table "public"."Games" to "authenticated";

grant select on table "public"."Games" to "authenticated";

grant trigger on table "public"."Games" to "authenticated";

grant truncate on table "public"."Games" to "authenticated";

grant update on table "public"."Games" to "authenticated";

grant delete on table "public"."Games" to "service_role";

grant insert on table "public"."Games" to "service_role";

grant references on table "public"."Games" to "service_role";

grant select on table "public"."Games" to "service_role";

grant trigger on table "public"."Games" to "service_role";

grant truncate on table "public"."Games" to "service_role";

grant update on table "public"."Games" to "service_role";

grant delete on table "public"."Order_Items" to "anon";

grant insert on table "public"."Order_Items" to "anon";

grant references on table "public"."Order_Items" to "anon";

grant select on table "public"."Order_Items" to "anon";

grant trigger on table "public"."Order_Items" to "anon";

grant truncate on table "public"."Order_Items" to "anon";

grant update on table "public"."Order_Items" to "anon";

grant delete on table "public"."Order_Items" to "authenticated";

grant insert on table "public"."Order_Items" to "authenticated";

grant references on table "public"."Order_Items" to "authenticated";

grant select on table "public"."Order_Items" to "authenticated";

grant trigger on table "public"."Order_Items" to "authenticated";

grant truncate on table "public"."Order_Items" to "authenticated";

grant update on table "public"."Order_Items" to "authenticated";

grant delete on table "public"."Order_Items" to "service_role";

grant insert on table "public"."Order_Items" to "service_role";

grant references on table "public"."Order_Items" to "service_role";

grant select on table "public"."Order_Items" to "service_role";

grant trigger on table "public"."Order_Items" to "service_role";

grant truncate on table "public"."Order_Items" to "service_role";

grant update on table "public"."Order_Items" to "service_role";

grant delete on table "public"."Orders" to "anon";

grant insert on table "public"."Orders" to "anon";

grant references on table "public"."Orders" to "anon";

grant select on table "public"."Orders" to "anon";

grant trigger on table "public"."Orders" to "anon";

grant truncate on table "public"."Orders" to "anon";

grant update on table "public"."Orders" to "anon";

grant delete on table "public"."Orders" to "authenticated";

grant insert on table "public"."Orders" to "authenticated";

grant references on table "public"."Orders" to "authenticated";

grant select on table "public"."Orders" to "authenticated";

grant trigger on table "public"."Orders" to "authenticated";

grant truncate on table "public"."Orders" to "authenticated";

grant update on table "public"."Orders" to "authenticated";

grant delete on table "public"."Orders" to "service_role";

grant insert on table "public"."Orders" to "service_role";

grant references on table "public"."Orders" to "service_role";

grant select on table "public"."Orders" to "service_role";

grant trigger on table "public"."Orders" to "service_role";

grant truncate on table "public"."Orders" to "service_role";

grant update on table "public"."Orders" to "service_role";

grant delete on table "public"."Rounds" to "anon";

grant insert on table "public"."Rounds" to "anon";

grant references on table "public"."Rounds" to "anon";

grant select on table "public"."Rounds" to "anon";

grant trigger on table "public"."Rounds" to "anon";

grant truncate on table "public"."Rounds" to "anon";

grant update on table "public"."Rounds" to "anon";

grant delete on table "public"."Rounds" to "authenticated";

grant insert on table "public"."Rounds" to "authenticated";

grant references on table "public"."Rounds" to "authenticated";

grant select on table "public"."Rounds" to "authenticated";

grant trigger on table "public"."Rounds" to "authenticated";

grant truncate on table "public"."Rounds" to "authenticated";

grant update on table "public"."Rounds" to "authenticated";

grant delete on table "public"."Rounds" to "service_role";

grant insert on table "public"."Rounds" to "service_role";

grant references on table "public"."Rounds" to "service_role";

grant select on table "public"."Rounds" to "service_role";

grant trigger on table "public"."Rounds" to "service_role";

grant truncate on table "public"."Rounds" to "service_role";

grant update on table "public"."Rounds" to "service_role";

grant delete on table "public"."User_Game_Access" to "anon";

grant insert on table "public"."User_Game_Access" to "anon";

grant references on table "public"."User_Game_Access" to "anon";

grant select on table "public"."User_Game_Access" to "anon";

grant trigger on table "public"."User_Game_Access" to "anon";

grant truncate on table "public"."User_Game_Access" to "anon";

grant update on table "public"."User_Game_Access" to "anon";

grant delete on table "public"."User_Game_Access" to "authenticated";

grant insert on table "public"."User_Game_Access" to "authenticated";

grant references on table "public"."User_Game_Access" to "authenticated";

grant select on table "public"."User_Game_Access" to "authenticated";

grant trigger on table "public"."User_Game_Access" to "authenticated";

grant truncate on table "public"."User_Game_Access" to "authenticated";

grant update on table "public"."User_Game_Access" to "authenticated";

grant delete on table "public"."User_Game_Access" to "service_role";

grant insert on table "public"."User_Game_Access" to "service_role";

grant references on table "public"."User_Game_Access" to "service_role";

grant select on table "public"."User_Game_Access" to "service_role";

grant trigger on table "public"."User_Game_Access" to "service_role";

grant truncate on table "public"."User_Game_Access" to "service_role";

grant update on table "public"."User_Game_Access" to "service_role";

grant delete on table "public"."Users" to "anon";

grant insert on table "public"."Users" to "anon";

grant references on table "public"."Users" to "anon";

grant select on table "public"."Users" to "anon";

grant trigger on table "public"."Users" to "anon";

grant truncate on table "public"."Users" to "anon";

grant update on table "public"."Users" to "anon";

grant delete on table "public"."Users" to "authenticated";

grant insert on table "public"."Users" to "authenticated";

grant references on table "public"."Users" to "authenticated";

grant select on table "public"."Users" to "authenticated";

grant trigger on table "public"."Users" to "authenticated";

grant truncate on table "public"."Users" to "authenticated";

grant update on table "public"."Users" to "authenticated";

grant delete on table "public"."Users" to "service_role";

grant insert on table "public"."Users" to "service_role";

grant references on table "public"."Users" to "service_role";

grant select on table "public"."Users" to "service_role";

grant trigger on table "public"."Users" to "service_role";

grant truncate on table "public"."Users" to "service_role";

grant update on table "public"."Users" to "service_role";

create policy "Allow public read access to Character_Variations for active gam"
on "public"."Character_Variations"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM ("Game_Variations" gv
     JOIN "Games" g ON ((gv.game_id = g.game_id)))
  WHERE ((gv.variation_id = "Character_Variations".variation_id) AND (g.is_active = true)))));


create policy "Allow service role access to Character_Variations"
on "public"."Character_Variations"
as permissive
for all
to public
using ((auth.role() = 'service_role'::text));


create policy "Allow public read access to Characters for active games"
on "public"."Characters"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM (("Character_Variations" cv
     JOIN "Game_Variations" gv ON ((cv.variation_id = gv.variation_id)))
     JOIN "Games" g ON ((gv.game_id = g.game_id)))
  WHERE ((cv.character_id = "Characters".character_id) AND (g.is_active = true)))));


create policy "Allow service role access to Characters"
on "public"."Characters"
as permissive
for all
to public
using ((auth.role() = 'service_role'::text));


create policy "Allow admin access to Clue_Rounds"
on "public"."Clue_Rounds"
as permissive
for all
to public
using ((auth.role() = 'service_role'::text));


create policy "Allow read access to Clue_Rounds"
on "public"."Clue_Rounds"
as permissive
for select
to public
using ((auth.role() = 'authenticated'::text));


create policy "Allow access to clues of purchased games via rounds"
on "public"."Clues"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM (((("Clue_Rounds" cr
     JOIN "Rounds" r ON ((cr.round_id = r.round_id)))
     JOIN "Game_Variations" gv ON ((r.variation_id = gv.variation_id)))
     JOIN "Order_Items" oi ON ((gv.game_id = oi.game_id)))
     JOIN "Orders" o ON ((oi.order_id = o.order_id)))
  WHERE ((cr.clue_id = "Clues".clue_id) AND (o.user_id = auth.uid()) AND ((o.status)::text = 'completed'::text)))));


create policy "Users can access clues of purchased games"
on "public"."Clues"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM (("Rounds" r
     JOIN "Game_Variations" gv ON ((gv.variation_id = r.variation_id)))
     JOIN "User_Game_Access" uga ON ((uga.game_id = gv.game_id)))
  WHERE ((r.round_id = "Clues".round_id) AND (uga.user_id = auth.uid())))));


create policy "Users can access final reveals of purchased games"
on "public"."Final_Reveal"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM ("User_Game_Access" uga
     JOIN "Game_Variations" gv ON ((gv.variation_id = "Final_Reveal".variation_id)))
  WHERE ((uga.game_id = gv.game_id) AND (uga.user_id = auth.uid())))));


create policy "Allow public read access to Game_Variations for active games"
on "public"."Game_Variations"
as permissive
for select
to anon
using ((EXISTS ( SELECT 1
   FROM "Games" g
  WHERE ((g.game_id = "Game_Variations".game_id) AND (g.is_active = true)))));


create policy "Users can access purchased game content"
on "public"."Game_Variations"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM "User_Game_Access"
  WHERE (("User_Game_Access".game_id = "Game_Variations".game_id) AND ("User_Game_Access".user_id = auth.uid())))));


create policy "Anyone can view active games"
on "public"."Games"
as permissive
for select
to public
using ((is_active = true));


create policy "Users can view purchased games"
on "public"."Games"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM ("Orders" o
     JOIN "Order_Items" oi ON ((o.order_id = oi.order_id)))
  WHERE ((o.user_id = auth.uid()) AND (oi.game_id = "Games".game_id)))));


create policy "Allow authenticated users to create order items"
on "public"."Order_Items"
as permissive
for insert
to public
with check ((auth.role() = 'authenticated'::text));


create policy "Users can view their own order items"
on "public"."Order_Items"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM "Orders"
  WHERE (("Orders".order_id = "Order_Items".order_id) AND ("Orders".user_id = auth.uid())))));


create policy "Users can create their own orders"
on "public"."Orders"
as permissive
for insert
to public
with check ((auth.uid() = user_id));


create policy "Users can view their own orders"
on "public"."Orders"
as permissive
for select
to public
using ((auth.uid() = user_id));


create policy "Users can access rounds of purchased games"
on "public"."Rounds"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM ("User_Game_Access" uga
     JOIN "Game_Variations" gv ON ((gv.variation_id = "Rounds".variation_id)))
  WHERE ((uga.game_id = gv.game_id) AND (uga.user_id = auth.uid())))));


create policy "Allow authenticated users to create game access"
on "public"."User_Game_Access"
as permissive
for insert
to public
with check ((auth.role() = 'authenticated'::text));


create policy "Users can view their own game access"
on "public"."User_Game_Access"
as permissive
for select
to public
using ((auth.uid() = user_id));


create policy "Users can view their own data"
on "public"."Users"
as permissive
for select
to public
using ((auth.uid() = user_id));


CREATE TRIGGER trg_grant_game_access AFTER INSERT ON public."Order_Items" FOR EACH ROW EXECUTE FUNCTION grant_game_access_on_purchase();


