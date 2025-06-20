-- Template: Game Insert Script for Supabase PostgreSQL
-- This template shows the proper format for inserting games with image storage support

-- 1. Insert Game
INSERT INTO "Games" (
  game_id, 
  title, 
  title_bg, 
  subtitle, 
  subtitle_bg, 
  description, 
  description_bg, 
  setting, 
  image,           -- Fallback external URL (optional)
  image_path,      -- Supabase Storage path (NULL until image is uploaded)
  difficulty, 
  players, 
  duration, 
  featured, 
  price, 
  is_active,
  victim,          -- Optional victim field
  victim_bg        -- Optional Bulgarian victim field
) VALUES (
  [GAME_ID],       -- Replace with actual game ID
  '[GAME_TITLE]',  -- Replace with actual title
  '[GAME_TITLE_BG]', -- Replace with Bulgarian title
  '[GAME_SUBTITLE]', -- Replace with actual subtitle
  '[GAME_SUBTITLE_BG]', -- Replace with Bulgarian subtitle
  '[GAME_DESCRIPTION]', -- Replace with actual description
  '[GAME_DESCRIPTION_BG]', -- Replace with Bulgarian description
  '[GAME_SETTING]', -- Replace with actual setting
  '[EXTERNAL_IMAGE_URL]', -- Optional: external URL as fallback
  NULL,            -- image_path: NULL until image is uploaded to Supabase Storage
  '[DIFFICULTY]',  -- 'Easy', 'Medium', or 'Hard'
  '[PLAYERS]',     -- e.g., '6-10', '8', etc.
  '[DURATION]',    -- e.g., '2-3 hours'
  [FEATURED],      -- true or false
  [PRICE],         -- e.g., 29.99
  true,            -- is_active: true for active games
  '[VICTIM]',      -- Optional: victim name
  '[VICTIM_BG]'    -- Optional: Bulgarian victim name
);

-- 2. Insert Game Variation
INSERT INTO "Game_Variations" (
  variation_id, 
  game_id, 
  num_players, 
  variation_title, 
  variation_title_bg, 
  notes, 
  notes_bg
) VALUES (
  [VARIATION_ID],  -- Replace with actual variation ID
  [GAME_ID],       -- Same as game_id above
  [NUM_PLAYERS],   -- Number of players for this variation
  '[VARIATION_TITLE]', -- e.g., '6 Players'
  '[VARIATION_TITLE_BG]', -- e.g., '6 играчи'
  '[VARIATION_NOTES]', -- Optional notes
  '[VARIATION_NOTES_BG]'  -- Optional Bulgarian notes
);

-- 3. Insert Rounds
INSERT INTO "Rounds" (
  round_id, 
  variation_id, 
  round_number, 
  title, 
  title_bg, 
  description, 
  description_bg
) VALUES
  ([ROUND_ID_1], [VARIATION_ID], 1, '[ROUND_1_TITLE]', '[ROUND_1_TITLE_BG]',
    '[ROUND_1_DESCRIPTION]', '[ROUND_1_DESCRIPTION_BG]'),
  ([ROUND_ID_2], [VARIATION_ID], 2, '[ROUND_2_TITLE]', '[ROUND_2_TITLE_BG]',
    '[ROUND_2_DESCRIPTION]', '[ROUND_2_DESCRIPTION_BG]'),
  ([ROUND_ID_3], [VARIATION_ID], 3, '[ROUND_3_TITLE]', '[ROUND_3_TITLE_BG]',
    '[ROUND_3_DESCRIPTION]', '[ROUND_3_DESCRIPTION_BG]');

-- 4. Insert Characters
INSERT INTO "Characters" (
  character_id, 
  variation_id, 
  name, 
  name_bg, 
  description, 
  description_bg, 
  secret, 
  secret_bg
) VALUES
  ([CHAR_ID_1], [VARIATION_ID], '[CHAR_1_NAME]', '[CHAR_1_NAME_BG]',
    '[CHAR_1_DESCRIPTION]', '[CHAR_1_DESCRIPTION_BG]',
    '[CHAR_1_SECRET]', '[CHAR_1_SECRET_BG]'),
  ([CHAR_ID_2], [VARIATION_ID], '[CHAR_2_NAME]', '[CHAR_2_NAME_BG]',
    '[CHAR_2_DESCRIPTION]', '[CHAR_2_DESCRIPTION_BG]',
    '[CHAR_2_SECRET]', '[CHAR_2_SECRET_BG]'),
  -- Add more characters as needed
  ([CHAR_ID_N], [VARIATION_ID], '[CHAR_N_NAME]', '[CHAR_N_NAME_BG]',
    '[CHAR_N_DESCRIPTION]', '[CHAR_N_DESCRIPTION_BG]',
    '[CHAR_N_SECRET]', '[CHAR_N_SECRET_BG]');

-- 5. Insert Clues
INSERT INTO "Clues" (
  clue_id, 
  round_id, 
  clue_number, 
  content, 
  content_bg
) VALUES
  -- Round 1 clues
  ([CLUE_ID_1], [ROUND_ID_1], 1, '[CLUE_1_CONTENT]', '[CLUE_1_CONTENT_BG]'),
  ([CLUE_ID_2], [ROUND_ID_1], 2, '[CLUE_2_CONTENT]', '[CLUE_2_CONTENT_BG]'),
  ([CLUE_ID_3], [ROUND_ID_1], 3, '[CLUE_3_CONTENT]', '[CLUE_3_CONTENT_BG]'),
  ([CLUE_ID_4], [ROUND_ID_1], 4, '[CLUE_4_CONTENT]', '[CLUE_4_CONTENT_BG]'),
  -- Round 2 clues
  ([CLUE_ID_5], [ROUND_ID_2], 1, '[CLUE_5_CONTENT]', '[CLUE_5_CONTENT_BG]'),
  ([CLUE_ID_6], [ROUND_ID_2], 2, '[CLUE_6_CONTENT]', '[CLUE_6_CONTENT_BG]'),
  ([CLUE_ID_7], [ROUND_ID_2], 3, '[CLUE_7_CONTENT]', '[CLUE_7_CONTENT_BG]'),
  ([CLUE_ID_8], [ROUND_ID_2], 4, '[CLUE_8_CONTENT]', '[CLUE_8_CONTENT_BG]'),
  -- Round 3 clues
  ([CLUE_ID_9], [ROUND_ID_3], 1, '[CLUE_9_CONTENT]', '[CLUE_9_CONTENT_BG]'),
  ([CLUE_ID_10], [ROUND_ID_3], 2, '[CLUE_10_CONTENT]', '[CLUE_10_CONTENT_BG]'),
  ([CLUE_ID_11], [ROUND_ID_3], 3, '[CLUE_11_CONTENT]', '[CLUE_11_CONTENT_BG]'),
  ([CLUE_ID_12], [ROUND_ID_3], 4, '[CLUE_12_CONTENT]', '[CLUE_12_CONTENT_BG]');

-- 6. Insert Final Reveal
INSERT INTO "Final_Reveal" (
  reveal_id, 
  variation_id, 
  content, 
  content_bg, 
  murderer, 
  murderer_bg
) VALUES (
  [REVEAL_ID], 
  [VARIATION_ID],
  '[REVEAL_CONTENT]', -- Full explanation of the solution
  '[REVEAL_CONTENT_BG]', -- Bulgarian explanation
  '[MURDERER_NAME]', -- Name of the murderer
  '[MURDERER_NAME_BG]' -- Bulgarian name of the murderer
);

-- Notes:
-- 1. Replace all [PLACEHOLDER] values with actual data
-- 2. Use proper escaping for single quotes in text fields
-- 3. The image_path field should be NULL initially
-- 4. After uploading an image to Supabase Storage, update the image_path field
-- 5. All table names use double quotes for proper Supabase PostgreSQL syntax
-- 6. The image field can contain an external URL as fallback until Supabase Storage is used 