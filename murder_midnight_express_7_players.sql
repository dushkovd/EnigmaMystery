-- SQL Insert Script: Murder on the Midnight Express - 7 Players Variation
-- This script adds a 7-player variation to the existing Midnight Express game (game_id = 2)

-- 1. Insert Game Variation (7 players)
INSERT INTO "Game_Variations" (
  variation_id, game_id, num_players, variation_title, variation_title_bg, notes, notes_bg
) VALUES (
  8,
  2,
  7,
  '7 Players',
  '7 играчи',
  'Balanced version with key characters',
  'Балансирана версия с ключови герои'
);

-- 2. Insert Rounds for 7 players
INSERT INTO "Rounds" (
  round_id, variation_id, round_number, title, title_bg, description, description_bg
) VALUES
  (22, 8, 1, 'Crime Scene', 'Мястото на престъплението',
    'Initial investigation of the cabin',
    'Първоначално разследване на кабината'),
  (23, 8, 2, 'Hidden Motives', 'Скрити мотиви',
    'Uncovering character secrets',
    'Разкриване на тайните на героите'),
  (24, 8, 3, 'Final Threads', 'Последни нишки',
    'Connecting all evidence',
    'Свързване на всички улики'
  );

-- 3. Insert Characters for 7 players
INSERT INTO "Characters" (
  character_id, variation_id, name, name_bg, description, description_bg, secret, secret_bg
) VALUES
  (57, 8, 'Dr. Lisette Marchand', 'Д-р Лизет Маршан',
    'Worldly physician',
    'Опитен лекар',
    'She once attempted to poison another man who escaped justice.',
    'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.'),
  (58, 8, 'Anton Novik', 'Антон Новик',
    'Mysterious chess master',
    'Тайнствен шахматен майстор',
    'He is a fugitive using a false identity.',
    'Той е беглец с фалшива самоличност.'),
  (59, 8, 'Margot Leclair', 'Марго Леклер',
    'Investigative journalist',
    'Разследващ журналист',
    'She is secretly Crowthorne''s illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (60, 8, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (61, 8, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it''s connected.',
    'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.'),
  (62, 8, 'Franz Bauer', 'Франц Бауер',
    'Conductor with a past',
    'Кондуктор с минало',
    'He has been smuggling items across borders.',
    'Той е пренасял контрабандни стоки през граници.'),
  (63, 8, 'Isadora Wren', 'Исадора Урен',
    'Spiritualist medium',
    'Медиум спиритуалист',
    'She plants evidence and fabricates "visions."',
    'Тя подхвърля улики и измисля "видения."'
  );

-- 4. Insert Clues for 7 players (3-4 per round, 10 total)
INSERT INTO "Clues" (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (22) - Crime Scene
  (85, 22, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (86, 22, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (87, 22, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (88, 22, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (23) - Hidden Motives
  (89, 23, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито'),
  (90, 23, 2, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (91, 23, 3, 'Isadora''s "vision" about the murder', 'Видението на Исадора за убийството'),
  -- Round 3 (24) - Final Threads
  (92, 24, 1, 'Blackmail letter traced to Clara''s handwriting', 'Писмото за изнудване е проследено до почерка на Клара'),
  (93, 24, 2, 'Anton''s chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината'),
  (94, 24, 3, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 5. Insert Final Reveal for 7 players
INSERT INTO "Final_Reveal" (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  8, 8,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
);

-- Summary of what this script adds:
-- - 1 Game Variation (7 players)
-- - 3 Rounds (Crime Scene, Hidden Motives, Final Threads)
-- - 7 Characters with unique secrets and motives
-- - 10 Clues distributed across 3 rounds
-- - 1 Final Reveal explaining the solution
--
-- The murderer is Dr. Lisette Marchand, who poisoned Crowthorne and staged the scene
-- to make it look like a violent murder. Her motive was revenge for unethical medical
-- research that led to her sister's death. 