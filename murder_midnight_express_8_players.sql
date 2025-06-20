-- SQL Insert Script: Murder on the Midnight Express - 8 Players Variation
-- This script adds an 8-player variation to the existing Midnight Express game (game_id = 2)

-- 1. Insert Game Variation (8 players)
INSERT INTO "Game_Variations" (
  variation_id, game_id, num_players, variation_title, variation_title_bg, notes, notes_bg
) VALUES (
  9,
  2,
  8,
  '8 Players',
  '8 играчи',
  'Extended version with additional suspects',
  'Разширена версия с допълнителни заподозрени'
);

-- 2. Insert Rounds for 8 players
INSERT INTO "Rounds" (
  round_id, variation_id, round_number, title, title_bg, description, description_bg
) VALUES
  (25, 9, 1, 'Crime Scene', 'Мястото на престъплението',
    'Initial investigation of the cabin',
    'Първоначално разследване на кабината'),
  (26, 9, 2, 'Hidden Motives', 'Скрити мотиви',
    'Uncovering character secrets',
    'Разкриване на тайните на героите'),
  (27, 9, 3, 'Final Threads', 'Последни нишки',
    'Connecting all evidence',
    'Свързване на всички улики'
  );

-- 3. Insert Characters for 8 players
INSERT INTO "Characters" (
  character_id, variation_id, name, name_bg, description, description_bg, secret, secret_bg
) VALUES
  (64, 9, 'Dr. Lisette Marchand', 'Д-р Лизет Маршан',
    'Worldly physician',
    'Опитен лекар',
    'She once attempted to poison another man who escaped justice.',
    'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.'),
  (65, 9, 'Anton Novik', 'Антон Новик',
    'Mysterious chess master',
    'Тайнствен шахматен майстор',
    'He is a fugitive using a false identity.',
    'Той е беглец с фалшива самоличност.'),
  (66, 9, 'Margot Leclair', 'Марго Леклер',
    'Investigative journalist',
    'Разследващ журналист',
    'She is secretly Crowthorne''s illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (67, 9, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (68, 9, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it''s connected.',
    'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.'),
  (69, 9, 'Franz Bauer', 'Франц Бауер',
    'Conductor with a past',
    'Кондуктор с минало',
    'He has been smuggling items across borders.',
    'Той е пренасял контрабандни стоки през граници.'),
  (70, 9, 'Isadora Wren', 'Исадора Урен',
    'Spiritualist medium',
    'Медиум спиритуалист',
    'She plants evidence and fabricates "visions."',
    'Тя подхвърля улики и измисля "видения."'),
  (71, 9, 'Hassan Al-Khatib', 'Хасан Ал-Хатиб',
    'Antique dealer',
    'Търговец на антики',
    'He forged the ceremonial dagger found at the scene.',
    'Той е фалшифицирал церемониалния кинжал, намерен на местопрестъплението.'
  );

-- 4. Insert Clues for 8 players (4 per round, 12 total)
INSERT INTO "Clues" (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (25)
  (95, 25, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (96, 25, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (97, 25, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (98, 25, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (26)
  (99, 26, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито'),
  (100, 26, 2, 'Hassan''s customs tag', 'Митническият етикет на Хасан'),
  (101, 26, 3, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (102, 26, 4, 'Isadora''s "vision" about the murder', 'Видението на Исадора за убийството'),
  -- Round 3 (27)
  (103, 27, 1, 'Blackmail letter traced to Clara''s handwriting', 'Писмото за изнудване е проследено до почерка на Клара'),
  (104, 27, 2, 'Anton''s chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината'),
  (105, 27, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът'),
  (106, 27, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 5. Insert Final Reveal for 8 players
INSERT INTO "Final_Reveal" (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  9, 9,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
); 