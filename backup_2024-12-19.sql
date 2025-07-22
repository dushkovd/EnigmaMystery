

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."get_current_protocol"() RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN COALESCE(current_setting('app.settings.protocol', true), 'https://');
END;
$$;


ALTER FUNCTION "public"."get_current_protocol"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_game_image_url"("image_path" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    supabase_url TEXT;
BEGIN
  -- Try multiple sources for the Supabase URL in order of preference:
  -- 1. app.settings.supabase_url (if set via set_config)
  -- 2. SUPABASE_URL environment variable
  -- 3. Hardcoded fallback (should be overridden in production)
  supabase_url := COALESCE(
    current_setting('app.settings.supabase_url', true),
    current_setting('SUPABASE_URL', true),
    'gkuwrqpxwehfnmlsqsxa.supabase.co'  -- Fallback for test environment
  );
  
  -- If image_path is provided, construct the Supabase Storage URL
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN 'https://' || supabase_url || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$;


ALTER FUNCTION "public"."get_game_image_url"("image_path" "text") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."get_game_image_url"("image_path" "text") IS 'Generates Supabase Storage URLs using environment variables or configuration. Priority: app.settings.supabase_url > SUPABASE_URL env var > hardcoded fallback';



CREATE OR REPLACE FUNCTION "public"."get_game_image_url_secure"("image_path" "text", "game_id" integer DEFAULT NULL::integer) RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
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
$$;


ALTER FUNCTION "public"."get_game_image_url_secure"("image_path" "text", "game_id" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."grant_game_access_on_purchase"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
    INSERT INTO "User_Game_Access" (user_id, game_id)
    VALUES (v_user_id, NEW.game_id)
    ON CONFLICT DO NOTHING;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."grant_game_access_on_purchase"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public."Users" (user_id, email, created_at)
  VALUES (NEW.id, NEW.email, NOW());
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_protocol_setting"("new_protocol" "text") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF auth.role() != 'authenticated' THEN
        RAISE EXCEPTION 'Only authenticated users can update protocol setting';
    END IF;
    
    IF new_protocol NOT IN ('http://', 'https://') THEN
        RAISE EXCEPTION 'Protocol must be either http:// or https://';
    END IF;
    
    PERFORM set_config('app.settings.protocol', new_protocol, false);
END;
$$;


ALTER FUNCTION "public"."update_protocol_setting"("new_protocol" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_supabase_url"("new_url" "text") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $_$
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
$_$;


ALTER FUNCTION "public"."update_supabase_url"("new_url" "text") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."update_supabase_url"("new_url" "text") IS 'Updates Supabase URL configuration. Only authenticated users can call this function.';


SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."Character_Variations" (
    "character_id" integer NOT NULL,
    "variation_id" integer NOT NULL
);


ALTER TABLE "public"."Character_Variations" OWNER TO "postgres";


COMMENT ON TABLE "public"."Character_Variations" IS 'Junction table linking characters to game variations';



COMMENT ON COLUMN "public"."Character_Variations"."character_id" IS 'Reference to Characters table';



COMMENT ON COLUMN "public"."Character_Variations"."variation_id" IS 'Reference to Game_Variations table';



CREATE TABLE IF NOT EXISTS "public"."Characters" (
    "character_id" integer NOT NULL,
    "variation_id" integer,
    "name" character varying(255) NOT NULL,
    "description" "text",
    "secret" "text",
    "name_bg" "text",
    "description_bg" "text",
    "secret_bg" "text",
    "connection" "text",
    "connection_bg" "text",
    "circumstances" "text",
    "circumstances_bg" "text"
);


ALTER TABLE "public"."Characters" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."Characters_character_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Characters_character_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Characters_character_id_seq" OWNED BY "public"."Characters"."character_id";



CREATE TABLE IF NOT EXISTS "public"."Clue_Rounds" (
    "clue_id" integer NOT NULL,
    "round_id" integer NOT NULL,
    "clue_number" integer NOT NULL
);


ALTER TABLE "public"."Clue_Rounds" OWNER TO "postgres";


COMMENT ON TABLE "public"."Clue_Rounds" IS 'Junction table linking clues to rounds';



COMMENT ON COLUMN "public"."Clue_Rounds"."clue_id" IS 'Reference to Clues table';



COMMENT ON COLUMN "public"."Clue_Rounds"."round_id" IS 'Reference to Rounds table';



COMMENT ON COLUMN "public"."Clue_Rounds"."clue_number" IS 'Order of clue within the round';



CREATE TABLE IF NOT EXISTS "public"."Clues" (
    "clue_id" integer NOT NULL,
    "round_id" integer,
    "clue_number" integer,
    "content" "text" NOT NULL,
    "content_bg" "text",
    "hidden" boolean DEFAULT false
);


ALTER TABLE "public"."Clues" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."Clues_clue_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Clues_clue_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Clues_clue_id_seq" OWNED BY "public"."Clues"."clue_id";



CREATE TABLE IF NOT EXISTS "public"."Final_Reveal" (
    "reveal_id" integer NOT NULL,
    "variation_id" integer NOT NULL,
    "content" "text" NOT NULL,
    "murderer" "text",
    "content_bg" "text",
    "murderer_bg" "text"
);


ALTER TABLE "public"."Final_Reveal" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."Final_Reveal_reveal_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Final_Reveal_reveal_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Final_Reveal_reveal_id_seq" OWNED BY "public"."Final_Reveal"."reveal_id";



CREATE TABLE IF NOT EXISTS "public"."Game_Variations" (
    "variation_id" integer NOT NULL,
    "game_id" integer NOT NULL,
    "num_players" integer NOT NULL,
    "variation_title" character varying(255),
    "notes" "text",
    "variation_title_bg" "text",
    "notes_bg" "text",
    CONSTRAINT "Game_Variations_num_players_check" CHECK ((("num_players" >= 5) AND ("num_players" <= 10)))
);


ALTER TABLE "public"."Game_Variations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."Game_Variations_variation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Game_Variations_variation_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Game_Variations_variation_id_seq" OWNED BY "public"."Game_Variations"."variation_id";



CREATE TABLE IF NOT EXISTS "public"."Games" (
    "game_id" integer NOT NULL,
    "title" character varying(255) NOT NULL,
    "description" "text",
    "setting" "text",
    "price" numeric(10,2) NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "subtitle" character varying(255),
    "image" character varying(255),
    "difficulty" character varying(10),
    "players" character varying(50),
    "duration" character varying(50),
    "featured" boolean DEFAULT false,
    "title_bg" "text",
    "subtitle_bg" "text",
    "description_bg" "text",
    "difficulty_bg" character varying,
    "victim" "text",
    "victim_bg" "text",
    "setting_bg" "text",
    "image_path" "text",
    CONSTRAINT "Games_difficulty_check" CHECK ((("difficulty")::"text" = ANY (ARRAY[('Easy'::character varying)::"text", ('Medium'::character varying)::"text", ('Hard'::character varying)::"text"])))
);


ALTER TABLE "public"."Games" OWNER TO "postgres";


COMMENT ON COLUMN "public"."Games"."image_path" IS 'Supabase Storage path for the game image';



CREATE SEQUENCE IF NOT EXISTS "public"."Games_game_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Games_game_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Games_game_id_seq" OWNED BY "public"."Games"."game_id";



CREATE TABLE IF NOT EXISTS "public"."Order_Items" (
    "order_item_id" integer NOT NULL,
    "order_id" integer NOT NULL,
    "game_id" integer NOT NULL,
    "price" numeric(10,2) NOT NULL,
    "quantity" integer DEFAULT 1 NOT NULL,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "public"."Order_Items" OWNER TO "postgres";


COMMENT ON COLUMN "public"."Order_Items"."order_id" IS 'Reference to the order';



COMMENT ON COLUMN "public"."Order_Items"."game_id" IS 'Reference to the game';



COMMENT ON COLUMN "public"."Order_Items"."price" IS 'Price per item at time of purchase';



COMMENT ON COLUMN "public"."Order_Items"."quantity" IS 'Number of items ordered';



COMMENT ON COLUMN "public"."Order_Items"."created_at" IS 'When the order item was created';



CREATE SEQUENCE IF NOT EXISTS "public"."Order_Items_order_item_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Order_Items_order_item_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Order_Items_order_item_id_seq" OWNED BY "public"."Order_Items"."order_item_id";



CREATE TABLE IF NOT EXISTS "public"."Orders" (
    "order_id" integer NOT NULL,
    "user_id" "uuid" NOT NULL,
    "order_date" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "total_amount" numeric(10,2) NOT NULL,
    "status" character varying(50) NOT NULL,
    "payment_intent_id" "text"
);


ALTER TABLE "public"."Orders" OWNER TO "postgres";


COMMENT ON COLUMN "public"."Orders"."payment_intent_id" IS 'Stripe payment intent ID for tracking payments';



CREATE SEQUENCE IF NOT EXISTS "public"."Orders_order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Orders_order_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Orders_order_id_seq" OWNED BY "public"."Orders"."order_id";



CREATE TABLE IF NOT EXISTS "public"."Rounds" (
    "round_id" integer NOT NULL,
    "variation_id" integer NOT NULL,
    "round_number" integer NOT NULL,
    "title" character varying(255),
    "description" "text",
    "title_bg" "text",
    "description_bg" "text"
);


ALTER TABLE "public"."Rounds" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."Rounds_round_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."Rounds_round_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Rounds_round_id_seq" OWNED BY "public"."Rounds"."round_id";



CREATE TABLE IF NOT EXISTS "public"."User_Game_Access" (
    "user_id" "uuid" NOT NULL,
    "game_id" integer NOT NULL,
    "access_granted" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."User_Game_Access" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."Users" (
    "user_id" "uuid" NOT NULL,
    "email" character varying(255) NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."Users" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."games_with_images" WITH ("security_barrier"='true') AS
 SELECT "game_id",
    "title",
    "description",
    "setting",
    "price",
    "is_active",
    "subtitle",
    "image",
    "difficulty",
    "players",
    "duration",
    "featured",
    "title_bg",
    "subtitle_bg",
    "description_bg",
    "difficulty_bg",
    "victim",
    "victim_bg",
    "setting_bg",
    "image_path",
    COALESCE("public"."get_game_image_url"("image_path"), ("image")::"text") AS "image_url"
   FROM "public"."Games" "g";


ALTER VIEW "public"."games_with_images" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."new_character_id_seq"
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."new_character_id_seq" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."new_clue_id_seq"
    START WITH 2000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."new_clue_id_seq" OWNER TO "postgres";


ALTER TABLE ONLY "public"."Characters" ALTER COLUMN "character_id" SET DEFAULT "nextval"('"public"."Characters_character_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Clues" ALTER COLUMN "clue_id" SET DEFAULT "nextval"('"public"."Clues_clue_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Final_Reveal" ALTER COLUMN "reveal_id" SET DEFAULT "nextval"('"public"."Final_Reveal_reveal_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Game_Variations" ALTER COLUMN "variation_id" SET DEFAULT "nextval"('"public"."Game_Variations_variation_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Games" ALTER COLUMN "game_id" SET DEFAULT "nextval"('"public"."Games_game_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Order_Items" ALTER COLUMN "order_item_id" SET DEFAULT "nextval"('"public"."Order_Items_order_item_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Orders" ALTER COLUMN "order_id" SET DEFAULT "nextval"('"public"."Orders_order_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Rounds" ALTER COLUMN "round_id" SET DEFAULT "nextval"('"public"."Rounds_round_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."Character_Variations"
    ADD CONSTRAINT "Character_Variations_pkey" PRIMARY KEY ("character_id", "variation_id");



ALTER TABLE ONLY "public"."Characters"
    ADD CONSTRAINT "Characters_pkey" PRIMARY KEY ("character_id");



ALTER TABLE ONLY "public"."Clue_Rounds"
    ADD CONSTRAINT "Clue_Rounds_pkey" PRIMARY KEY ("clue_id", "round_id");



ALTER TABLE ONLY "public"."Clues"
    ADD CONSTRAINT "Clues_pkey" PRIMARY KEY ("clue_id");



ALTER TABLE ONLY "public"."Final_Reveal"
    ADD CONSTRAINT "Final_Reveal_pkey" PRIMARY KEY ("reveal_id");



ALTER TABLE ONLY "public"."Game_Variations"
    ADD CONSTRAINT "Game_Variations_pkey" PRIMARY KEY ("variation_id");



ALTER TABLE ONLY "public"."Games"
    ADD CONSTRAINT "Games_pkey" PRIMARY KEY ("game_id");



ALTER TABLE ONLY "public"."Order_Items"
    ADD CONSTRAINT "Order_Items_pkey" PRIMARY KEY ("order_item_id");



ALTER TABLE ONLY "public"."Orders"
    ADD CONSTRAINT "Orders_pkey" PRIMARY KEY ("order_id");



ALTER TABLE ONLY "public"."Rounds"
    ADD CONSTRAINT "Rounds_pkey" PRIMARY KEY ("round_id");



ALTER TABLE ONLY "public"."User_Game_Access"
    ADD CONSTRAINT "User_Game_Access_pkey" PRIMARY KEY ("user_id", "game_id");



ALTER TABLE ONLY "public"."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("user_id");



CREATE INDEX "idx_character_variations_character_id" ON "public"."Character_Variations" USING "btree" ("character_id");



CREATE INDEX "idx_character_variations_variation_id" ON "public"."Character_Variations" USING "btree" ("variation_id");



CREATE INDEX "idx_clue_rounds_clue_id" ON "public"."Clue_Rounds" USING "btree" ("clue_id");



CREATE INDEX "idx_clue_rounds_round_id" ON "public"."Clue_Rounds" USING "btree" ("round_id");



CREATE OR REPLACE TRIGGER "trg_grant_game_access" AFTER INSERT ON "public"."Order_Items" FOR EACH ROW EXECUTE FUNCTION "public"."grant_game_access_on_purchase"();



ALTER TABLE ONLY "public"."Character_Variations"
    ADD CONSTRAINT "Character_Variations_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "public"."Characters"("character_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Character_Variations"
    ADD CONSTRAINT "Character_Variations_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."Game_Variations"("variation_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Characters"
    ADD CONSTRAINT "Characters_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."Game_Variations"("variation_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Clue_Rounds"
    ADD CONSTRAINT "Clue_Rounds_clue_id_fkey" FOREIGN KEY ("clue_id") REFERENCES "public"."Clues"("clue_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Clue_Rounds"
    ADD CONSTRAINT "Clue_Rounds_round_id_fkey" FOREIGN KEY ("round_id") REFERENCES "public"."Rounds"("round_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Clues"
    ADD CONSTRAINT "Clues_round_id_fkey" FOREIGN KEY ("round_id") REFERENCES "public"."Rounds"("round_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Final_Reveal"
    ADD CONSTRAINT "Final_Reveal_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."Game_Variations"("variation_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Game_Variations"
    ADD CONSTRAINT "Game_Variations_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."Games"("game_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Order_Items"
    ADD CONSTRAINT "Order_Items_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."Games"("game_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Order_Items"
    ADD CONSTRAINT "Order_Items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."Orders"("order_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Orders"
    ADD CONSTRAINT "Orders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."Users"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."Rounds"
    ADD CONSTRAINT "Rounds_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."Game_Variations"("variation_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."User_Game_Access"
    ADD CONSTRAINT "User_Game_Access_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."Games"("game_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."User_Game_Access"
    ADD CONSTRAINT "User_Game_Access_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."Users"("user_id") ON DELETE CASCADE;



CREATE POLICY "Allow access to clues of purchased games via rounds" ON "public"."Clues" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (((("public"."Clue_Rounds" "cr"
     JOIN "public"."Rounds" "r" ON (("cr"."round_id" = "r"."round_id")))
     JOIN "public"."Game_Variations" "gv" ON (("r"."variation_id" = "gv"."variation_id")))
     JOIN "public"."Order_Items" "oi" ON (("gv"."game_id" = "oi"."game_id")))
     JOIN "public"."Orders" "o" ON (("oi"."order_id" = "o"."order_id")))
  WHERE (("cr"."clue_id" = "Clues"."clue_id") AND ("o"."user_id" = "auth"."uid"()) AND (("o"."status")::"text" = 'completed'::"text")))));



CREATE POLICY "Allow admin access to Clue_Rounds" ON "public"."Clue_Rounds" USING (("auth"."role"() = 'service_role'::"text"));



CREATE POLICY "Allow public read access to Character_Variations for active gam" ON "public"."Character_Variations" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM ("public"."Game_Variations" "gv"
     JOIN "public"."Games" "g" ON (("gv"."game_id" = "g"."game_id")))
  WHERE (("gv"."variation_id" = "Character_Variations"."variation_id") AND ("g"."is_active" = true)))));



CREATE POLICY "Allow public read access to Characters for active games" ON "public"."Characters" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (("public"."Character_Variations" "cv"
     JOIN "public"."Game_Variations" "gv" ON (("cv"."variation_id" = "gv"."variation_id")))
     JOIN "public"."Games" "g" ON (("gv"."game_id" = "g"."game_id")))
  WHERE (("cv"."character_id" = "Characters"."character_id") AND ("g"."is_active" = true)))));



CREATE POLICY "Allow read access to Clue_Rounds" ON "public"."Clue_Rounds" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Allow service role access to Character_Variations" ON "public"."Character_Variations" USING (("auth"."role"() = 'service_role'::"text"));



CREATE POLICY "Allow service role access to Characters" ON "public"."Characters" USING (("auth"."role"() = 'service_role'::"text"));



CREATE POLICY "Anyone can view active games" ON "public"."Games" FOR SELECT USING (("is_active" = true));



ALTER TABLE "public"."Character_Variations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Characters" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Clue_Rounds" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Clues" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Final_Reveal" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Game_Variations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Games" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Order_Items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Orders" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Rounds" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."User_Game_Access" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."Users" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "Users can access clues of purchased games" ON "public"."Clues" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (("public"."Rounds" "r"
     JOIN "public"."Game_Variations" "gv" ON (("gv"."variation_id" = "r"."variation_id")))
     JOIN "public"."User_Game_Access" "uga" ON (("uga"."game_id" = "gv"."game_id")))
  WHERE (("r"."round_id" = "Clues"."round_id") AND ("uga"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can access final reveals of purchased games" ON "public"."Final_Reveal" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM ("public"."User_Game_Access" "uga"
     JOIN "public"."Game_Variations" "gv" ON (("gv"."variation_id" = "Final_Reveal"."variation_id")))
  WHERE (("uga"."game_id" = "gv"."game_id") AND ("uga"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can access purchased game content" ON "public"."Game_Variations" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."User_Game_Access"
  WHERE (("User_Game_Access"."game_id" = "Game_Variations"."game_id") AND ("User_Game_Access"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can access rounds of purchased games" ON "public"."Rounds" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM ("public"."User_Game_Access" "uga"
     JOIN "public"."Game_Variations" "gv" ON (("gv"."variation_id" = "Rounds"."variation_id")))
  WHERE (("uga"."game_id" = "gv"."game_id") AND ("uga"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can add items to their own orders" ON "public"."Order_Items" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."Orders"
  WHERE (("Orders"."order_id" = "Order_Items"."order_id") AND ("Orders"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can create their own order items" ON "public"."Order_Items" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."Orders"
  WHERE (("Orders"."order_id" = "Order_Items"."order_id") AND ("Orders"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can create their own orders" ON "public"."Orders" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view purchased games" ON "public"."Games" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM ("public"."Orders" "o"
     JOIN "public"."Order_Items" "oi" ON (("o"."order_id" = "oi"."order_id")))
  WHERE (("o"."user_id" = "auth"."uid"()) AND ("oi"."game_id" = "Games"."game_id")))));



CREATE POLICY "Users can view their own data" ON "public"."Users" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own game access" ON "public"."User_Game_Access" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own order items" ON "public"."Order_Items" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."Orders"
  WHERE (("Orders"."order_id" = "Order_Items"."order_id") AND ("Orders"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can view their own orders" ON "public"."Orders" FOR SELECT USING (("auth"."uid"() = "user_id"));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."get_current_protocol"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_current_protocol"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_current_protocol"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_game_image_url"("image_path" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."get_game_image_url"("image_path" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_game_image_url"("image_path" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_game_image_url_secure"("image_path" "text", "game_id" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_game_image_url_secure"("image_path" "text", "game_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_game_image_url_secure"("image_path" "text", "game_id" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."grant_game_access_on_purchase"() TO "anon";
GRANT ALL ON FUNCTION "public"."grant_game_access_on_purchase"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."grant_game_access_on_purchase"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_protocol_setting"("new_protocol" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."update_protocol_setting"("new_protocol" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_protocol_setting"("new_protocol" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_supabase_url"("new_url" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."update_supabase_url"("new_url" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_supabase_url"("new_url" "text") TO "service_role";


















GRANT ALL ON TABLE "public"."Character_Variations" TO "anon";
GRANT ALL ON TABLE "public"."Character_Variations" TO "authenticated";
GRANT ALL ON TABLE "public"."Character_Variations" TO "service_role";



GRANT ALL ON TABLE "public"."Characters" TO "anon";
GRANT ALL ON TABLE "public"."Characters" TO "authenticated";
GRANT ALL ON TABLE "public"."Characters" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Characters_character_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Characters_character_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Characters_character_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Clue_Rounds" TO "anon";
GRANT ALL ON TABLE "public"."Clue_Rounds" TO "authenticated";
GRANT ALL ON TABLE "public"."Clue_Rounds" TO "service_role";



GRANT ALL ON TABLE "public"."Clues" TO "anon";
GRANT ALL ON TABLE "public"."Clues" TO "authenticated";
GRANT ALL ON TABLE "public"."Clues" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Clues_clue_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Clues_clue_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Clues_clue_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Final_Reveal" TO "anon";
GRANT ALL ON TABLE "public"."Final_Reveal" TO "authenticated";
GRANT ALL ON TABLE "public"."Final_Reveal" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Final_Reveal_reveal_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Final_Reveal_reveal_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Final_Reveal_reveal_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Game_Variations" TO "anon";
GRANT ALL ON TABLE "public"."Game_Variations" TO "authenticated";
GRANT ALL ON TABLE "public"."Game_Variations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Game_Variations_variation_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Game_Variations_variation_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Game_Variations_variation_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Games" TO "anon";
GRANT ALL ON TABLE "public"."Games" TO "authenticated";
GRANT ALL ON TABLE "public"."Games" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Games_game_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Games_game_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Games_game_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Order_Items" TO "anon";
GRANT ALL ON TABLE "public"."Order_Items" TO "authenticated";
GRANT ALL ON TABLE "public"."Order_Items" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Order_Items_order_item_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Order_Items_order_item_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Order_Items_order_item_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Orders" TO "anon";
GRANT ALL ON TABLE "public"."Orders" TO "authenticated";
GRANT ALL ON TABLE "public"."Orders" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Orders_order_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Orders_order_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Orders_order_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."Rounds" TO "anon";
GRANT ALL ON TABLE "public"."Rounds" TO "authenticated";
GRANT ALL ON TABLE "public"."Rounds" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Rounds_round_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Rounds_round_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Rounds_round_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."User_Game_Access" TO "anon";
GRANT ALL ON TABLE "public"."User_Game_Access" TO "authenticated";
GRANT ALL ON TABLE "public"."User_Game_Access" TO "service_role";



GRANT ALL ON TABLE "public"."Users" TO "anon";
GRANT ALL ON TABLE "public"."Users" TO "authenticated";
GRANT ALL ON TABLE "public"."Users" TO "service_role";



GRANT ALL ON TABLE "public"."games_with_images" TO "anon";
GRANT ALL ON TABLE "public"."games_with_images" TO "authenticated";
GRANT ALL ON TABLE "public"."games_with_images" TO "service_role";



GRANT ALL ON SEQUENCE "public"."new_character_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."new_character_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."new_character_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."new_clue_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."new_clue_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."new_clue_id_seq" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






























RESET ALL;
