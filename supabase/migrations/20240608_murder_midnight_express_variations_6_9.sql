-- Migration: Add Murder on the Midnight Express variations for 6-9 players
-- Based on the existing 10-player version, adapted for smaller groups

-- 1. Insert Game Variation (6 players)
INSERT INTO public.Game_Variations (
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
INSERT INTO public.Rounds (
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
INSERT INTO public.Characters (
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
INSERT INTO public.Clues (clue_id, round_id, clue_number, content, content_bg) VALUES
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
INSERT INTO public.Final_Reveal (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  7, 7,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister's death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
);

-- 6. Insert Game Variation (7 players)
INSERT INTO public.Game_Variations (
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

-- 7. Insert Rounds for 7 players
INSERT INTO public.Rounds (
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

-- 8. Insert Characters for 7 players
INSERT INTO public.Characters (
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
    'She is secretly Crowthorne's illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (60, 8, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (61, 8, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it's connected.',
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

-- 9. Insert Clues for 7 players (3-4 per round, 10 total)
INSERT INTO public.Clues (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (22)
  (85, 22, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (86, 22, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (87, 22, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (88, 22, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (23)
  (89, 23, 1, 'Dr. Marchand's past revealed', 'Миналото на д-р Маршан е разкрито'),
  (90, 23, 2, 'Clara's debt ledger found in Crowthorne's luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (91, 23, 3, 'Isadora's "vision" about the murder', 'Видението на Исадора за убийството'),
  -- Round 3 (24)
  (92, 24, 1, 'Blackmail letter traced to Clara's handwriting', 'Писмото за изнудване е проследено до почерка на Клара'),
  (93, 24, 2, 'Anton's chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината'),
  (94, 24, 3, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 10. Insert Final Reveal for 7 players
INSERT INTO public.Final_Reveal (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  8, 8,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister's death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
);

-- 11. Insert Game Variation (8 players)
INSERT INTO public.Game_Variations (
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

-- 12. Insert Rounds for 8 players
INSERT INTO public.Rounds (
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

-- 13. Insert Characters for 8 players
INSERT INTO public.Characters (
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
    'She is secretly Crowthorne's illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (67, 9, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (68, 9, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it's connected.',
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

-- 14. Insert Clues for 8 players (4 per round, 12 total)
INSERT INTO public.Clues (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (25)
  (95, 25, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (96, 25, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (97, 25, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (98, 25, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (26)
  (99, 26, 1, 'Dr. Marchand's past revealed', 'Миналото на д-р Маршан е разкрито'),
  (100, 26, 2, 'Hassan's customs tag', 'Митническият етикет на Хасан'),
  (101, 26, 3, 'Clara's debt ledger found in Crowthorne's luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (102, 26, 4, 'Isadora's "vision" about the murder', 'Видението на Исадора за убийството'),
  -- Round 3 (27)
  (103, 27, 1, 'Blackmail letter traced to Clara's handwriting', 'Писмото за изнудване е проследено до почерка на Клара'),
  (104, 27, 2, 'Anton's chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината'),
  (105, 27, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът'),
  (106, 27, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 15. Insert Final Reveal for 8 players
INSERT INTO public.Final_Reveal (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  9, 9,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister's death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
);

-- 16. Insert Game Variation (9 players)
INSERT INTO public.Game_Variations (
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

-- 17. Insert Rounds for 9 players
INSERT INTO public.Rounds (
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

-- 18. Insert Characters for 9 players
INSERT INTO public.Characters (
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
    'She is secretly Crowthorne's illegitimate daughter.',
    'Тя е тайнa незаконна дъщеря на Кроуторн.'),
  (75, 10, 'Julian Everett', 'Джулиан Евърет',
    'Incognito railway detective',
    'Инкогнито железопътен детектив',
    'He was hired to kill Crowthorne—but chose not to.',
    'Бил е нает да убие Кроуторн, но е отказал.'),
  (76, 10, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it's connected.',
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
    'He forged a threatening letter planted in the victim's room.',
    'Той е фалшифицирал заплашително писмо, оставено в стаята на жертвата.'
  );

-- 19. Insert Clues for 9 players (4 per round, 12 total)
INSERT INTO public.Clues (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (28)
  (107, 28, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (108, 28, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (109, 28, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (110, 28, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (29)
  (111, 29, 1, 'Dr. Marchand's past revealed', 'Миналото на д-р Маршан е разкрито'),
  (112, 29, 2, 'Hassan's customs tag', 'Митническият етикет на Хасан'),
  (113, 29, 3, 'Eliot's political leaflet', 'Политическата листовка на Елиът'),
  (114, 29, 4, 'Isadora's "vision" about the murder', 'Видението на Исадора за убийството'),
  -- Round 3 (30)
  (115, 30, 1, 'Blackmail letter traced to Eliot's typewriter', 'Писмото за изнудване е проследено до пишещата машина на Елиът'),
  (116, 30, 2, 'Clara's debt ledger found in Crowthorne's luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (117, 30, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът'),
  (118, 30, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 20. Insert Final Reveal for 9 players
INSERT INTO public.Final_Reveal (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  10, 10,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister's death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
); 