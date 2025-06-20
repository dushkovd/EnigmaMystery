-- SQL Insert Script: Murder on the Midnight Express - 9 Players Variation
-- This script adds a 9-player variation to the existing Midnight Express game (game_id = 2)

-- 1. Insert Game Variation (9 players)
INSERT INTO "Game_Variations" (
  variation_id, game_id, num_players, variation_title, variation_title_bg, notes, notes_bg
) VALUES (
  10,
  2,
  9,
  '9 Players',
  '9 играчи',
  'Nearly complete version with most characters',
  'Почти пълна версия с повечето герои'
);

-- 2. Insert Rounds for 9 players
INSERT INTO "Rounds" (
  round_id, variation_id, round_number, title, title_bg, description, description_bg
) VALUES
  (28, 10, 1, 'Crime Scene', 'Мястото на престъплението',
    'Initial investigation of the cabin',
    'Първоначално разследване на кабината'),
  (29, 10, 2, 'Hidden Motives', 'Скрити мотиви',
    'Uncovering character secrets',
    'Разкриване на тайните на героите'),
  (30, 10, 3, 'Final Threads', 'Последни нишки',
    'Connecting all evidence',
    'Свързване на всички улики'
  );

-- 3. Insert Characters for 9 players
INSERT INTO "Characters" (
  character_id, variation_id, name, name_bg, description, description_bg, secret, secret_bg
) VALUES
  (72, 10, 'Dr. Lisette Marchand', 'Д-р Лизет Маршан',
    'Worldly physician',
    'Опитен лекар',
    'She once attempted to poison another man who escaped justice.',
    'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.'),
  (73, 10, 'Anton Novik', 'Антон Новик',
    'Mysterious chess master',
    'Тайнствен шахматен майстор',
    'He is a fugitive using a false identity.',
    'Той е беглец с фалшива самоличност.'),
  (74, 10, 'Margot Leclair', 'Марго Леклер',
    'Investigative journalist',
    'Разследващ журналист',
    'She is secretly Crowthorne''s illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (75, 10, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (76, 10, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it''s connected.',
    'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.'),
  (77, 10, 'Franz Bauer', 'Франц Бауер',
    'Conductor with a past',
    'Кондуктор с минало',
    'He has been smuggling items across borders.',
    'Той е пренасял контрабандни стоки през граници.'),
  (78, 10, 'Isadora Wren', 'Исадора Урен',
    'Spiritualist medium',
    'Медиум спиритуалист',
    'She plants evidence and fabricates "visions."',
    'Тя подхвърля улики и измисля "видения."'),
  (79, 10, 'Hassan Al-Khatib', 'Хасан Ал-Хатиб',
    'Antique dealer',
    'Търговец на антики',
    'He forged the ceremonial dagger found at the scene.',
    'Той е фалшифицирал церемониалния кинжал, намерен на местопрестъплението.'),
  (80, 10, 'Eliot Quayle', 'Елиът Куейл',
    'Radical student',
    'Радикален студент',
    'He forged a threatening letter planted in the victim''s room.',
    'Той е фалшифицирал заплашително писмо, оставено в стаята на жертвата.'
  );

-- 4. Insert Clues for 9 players (4 per round, 12 total)
INSERT INTO "Clues" (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (28)
  (107, 28, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (108, 28, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (109, 28, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (110, 28, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (29)
  (111, 29, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито'),
  (112, 29, 2, 'Hassan''s customs tag', 'Митническият етикет на Хасан'),
  (113, 29, 3, 'Eliot''s political leaflet', 'Политическата листовка на Елиът'),
  (114, 29, 4, 'Isadora''s "vision" about the murder', 'Видението на Исадора за убийството'),
  -- Round 3 (30)
  (115, 30, 1, 'Blackmail letter traced to Eliot''s typewriter', 'Писмото за изнудване е проследено до пишещата машина на Елиът'),
  (116, 30, 2, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (117, 30, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът'),
  (118, 30, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 5. Insert Final Reveal for 9 players
INSERT INTO "Final_Reveal" (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  10, 10,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
); 