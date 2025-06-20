-- Migration: Add Murder on the Midnight Express 6-player variation
-- Based on the existing 10-player version, adapted for 6 players

-- 1. Insert Game Variation (6 players)
INSERT INTO "Game_Variations" (
  variation_id, game_id, num_players, variation_title, variation_title_bg, notes, notes_bg
) VALUES (
  7,
  2,
  6,
  '6 Players',
  '6 играчи',
  'Compact version with core characters only',
  'Компактна версия само с основните герои'
);

-- 2. Insert Rounds for 6 players
INSERT INTO "Rounds" (
  round_id, variation_id, round_number, title, title_bg, description, description_bg
) VALUES
  (19, 7, 1, 'Crime Scene', 'Мястото на престъплението',
    'Initial investigation of the cabin',
    'Първоначално разследване на кабината'),
  (20, 7, 2, 'Hidden Motives', 'Скрити мотиви',
    'Uncovering character secrets',
    'Разкриване на тайните на героите'),
  (21, 7, 3, 'Final Threads', 'Последни нишки',
    'Connecting all evidence',
    'Свързване на всички улики'
  );

-- 3. Insert Characters for 6 players (core characters only)
INSERT INTO "Characters" (
  character_id, variation_id, name, name_bg, description, description_bg, secret, secret_bg
) VALUES
  (51, 7, 'Dr. Lisette Marchand', 'Д-р Лизет Маршан',
    'Worldly physician',
    'Опитен лекар',
    'She once attempted to poison another man who escaped justice.',
    'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.'),
  (52, 7, 'Anton Novik', 'Антон Новик',
    'Mysterious chess master',
    'Тайнствен шахматен майстор',
    'He is a fugitive using a false identity.',
    'Той е беглец с фалшива самоличност.'),
  (53, 7, 'Margot Leclair', 'Марго Леклер',
    'Investigative journalist',
    'Разследващ журналист',
    'She is secretly Crowthorne's illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (54, 7, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (55, 7, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it's connected.',
    'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.'),
  (56, 7, 'Franz Bauer', 'Франц Бауер',
    'Conductor with a past',
    'Кондуктор с минало',
    'He has been smuggling items across borders.',
    'Той е пренасял контрабандни стоки през граници.'
  );

-- 4. Insert Clues for 6 players (3 per round, 9 total)
INSERT INTO "Clues" (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (19)
  (76, 19, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (77, 19, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (78, 19, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  -- Round 2 (20)
  (79, 20, 1, 'Dr. Marchand's past revealed', 'Миналото на д-р Маршан е разкрито'),
  (80, 20, 2, 'Clara's debt ledger found in Crowthorne's luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (81, 20, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът'),
  -- Round 3 (21)
  (82, 21, 1, 'Blackmail letter traced to Clara's handwriting', 'Писмото за изнудване е проследено до почерка на Клара'),
  (83, 21, 2, 'Anton's chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината'),
  (84, 21, 3, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 5. Insert Final Reveal for 6 players
INSERT INTO "Final_Reveal" (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  7, 7,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister's death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
); 