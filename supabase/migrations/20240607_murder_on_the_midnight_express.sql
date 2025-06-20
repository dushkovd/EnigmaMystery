-- Migration: Add Murder on the Midnight Express (10-player version)
-- Game, Variation, Rounds, Characters, Clues, Final Reveal

-- 1. Insert Game
INSERT INTO "Games" (
  game_id, title, title_bg, subtitle, subtitle_bg, description, description_bg, setting, image, image_path, difficulty, players, duration, featured, price, is_active
) VALUES (
  2,
  'Murder on the Midnight Express',
  'Убийство в Полунощния Експрес',
  'A 1930s Train Mystery',
  'Мистерия във влак от 1930-те',
  'A powerful aristocrat, Lord Crowthorne, has disappeared. Blood is found in his private cabin, a ceremonial dagger on the floor, and the window open to the icy plains. It appears he was murdered and thrown from the train. Or was he? The goal: uncover what really happened, who is behind it, and why.',
  'Влиятелен аристократ, лорд Кроуторн, е изчезнал. Кръв е открита в личната му кабина, церемониален кинжал на пода и прозорецът е отворен към ледените полета. Изглежда, че е убит и изхвърлен от влака. Или не? Целта: разкрийте какво наистина се е случило, кой стои зад това и защо.',
  '1930s luxury train, Paris → Istanbul',
  'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg',
  NULL, -- image_path will be set when image is uploaded to Supabase Storage
  'Medium',
  '10',
  '2-3 hours',
  true,
  39.99,
  true
);

-- 2. Insert Game Variation (10 players)
INSERT INTO "Game_Variations" (
  variation_id, game_id, num_players, variation_title, variation_title_bg, notes, notes_bg
) VALUES (
  6,
  2,
  10,
  '10 Players',
  '10 играчи',
  '-',
  '-'
);

-- 3. Insert Rounds
INSERT INTO "Rounds" (
  round_id, variation_id, round_number, title, title_bg, description, description_bg
) VALUES
  (16, 6, 1, 'Crime Scene', 'Мястото на престъплението',
    'Initial investigation of the cabin',
    'Първоначално разследване на кабината'),
  (17, 6, 2, 'Hidden Motives', 'Скрити мотиви',
    'Uncovering character secrets',
    'Разкриване на тайните на героите'),
  (18, 6, 3, 'Final Threads', 'Последни нишки',
    'Connecting all evidence',
    'Свързване на всички улики'
  );

-- 4. Insert Characters for 10 players
INSERT INTO "Characters" (
  character_id, variation_id, name, name_bg, description, description_bg, secret, secret_bg
) VALUES
  (40, 6, 'Dr. Lisette Marchand', 'Д-р Лизет Маршан',
    'Medical researcher',
    'Медицински изследовател',
    'She killed Crowthorne with poison and staged the scene.',
    'Тя убива Кроуторн с отрова и инсценира сцената.'),
  (41, 6, 'Lord Sebastian Crowthorne', 'Лорд Себастиан Кроуторн',
    'Victim - Aristocrat',
    'Жертва - Аристократ',
    'He was poisoned, not stabbed. The dagger was planted.',
    'Той е отровен, не е избоден. Кинжалът е подхвърлен.'),
  (42, 6, 'Inspector Henri Dubois', 'Инспектор Анри Дюбоа',
    'French detective',
    'Френски детектив',
    'He has a personal vendetta against Crowthorne.',
    'Той има лична вендета срещу Кроуторн.'),
  (43, 6, 'Madame Colette Dubois', 'Мадам Колет Дюбоа',
    'Inspector\'s wife',
    'Съпруга на инспектора',
    'She knows about her husband\'s vendetta.',
    'Тя знае за вендетата на съпруга си.'),
  (44, 6, 'Countess Isabella Rossi', 'Графиня Изабела Роси',
    'Italian noblewoman',
    'Италианска благородничка',
    'She was blackmailed by Crowthorne.',
    'Тя е изнудвана от Кроуторн.'),
  (45, 6, 'Clara Von Stein', 'Клара фон Щайн',
    'Retired opera diva',
    'Пенсионирана оперна дива',
    'She once attempted blackmail and fears it\'s connected.',
    'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.'),
  (46, 6, 'Franz Bauer', 'Франц Бауер',
    'Conductor with a past',
    'Кондуктор с минало',
    'He has been smuggling items across borders.',
    'Той е пренасял контрабандни стоки през граници.'),
  (47, 6, 'Isadora Wren', 'Исадора Урен',
    'Spiritualist medium',
    'Медиум спиритуалист',
    'She plants evidence and fabricates "visions."',
    'Тя подхвърля улики и измисля "видения."'),
  (48, 6, 'Hassan Al-Khatib', 'Хасан Ал-Хатиб',
    'Antique dealer',
    'Търговец на антики',
    'He forged the ceremonial dagger found at the scene.',
    'Той е фалшифицирал церемониалния кинжал, намерен на местопрестъплението.'),
  (49, 6, 'Eliot Quayle', 'Елиът Куейл',
    'Radical student',
    'Радикален студент',
    'He forged a threatening letter planted in the victim\'s room.',
    'Той е фалшифицирал заплашително писмо, оставено в стаята на жертвата.'),
  (50, 6, 'Celeste Duval', 'Селест Дювал',
    'Socialite heiress',
    'Светска наследница',
    'She lost everything gambling and is desperate.',
    'Тя е загубила всичко от хазарт и е отчаяна.'
  );

-- 5. Insert Clues for each round (4 per round, 12 total)
INSERT INTO "Clues" (clue_id, round_id, clue_number, content, content_bg) VALUES
  -- Round 1 (16)
  (64, 16, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло'),
  (65, 16, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем'),
  (66, 16, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора'),
  (67, 16, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината'),
  -- Round 2 (17)
  (68, 17, 1, 'Dr. Marchand\'s past revealed', 'Миналото на д-р Маршан е разкрито'),
  (69, 17, 2, 'Hassan\'s customs tag', 'Митническият етикет на Хасан'),
  (70, 17, 3, 'Celeste\'s ruined financial papers', 'Унищожените финансови документи на Селест'),
  (71, 17, 4, 'Eliot\'s political leaflet', 'Политическата листовка на Елиът'),
  -- Round 3 (18)
  (72, 18, 1, 'Blackmail letter traced to Eliot\'s typewriter', 'Писмото за изнудване е проследено до пишещата машина на Елиът'),
  (73, 18, 2, 'Clara\'s debt ledger found in Crowthorne\'s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн'),
  (74, 18, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът'),
  (75, 18, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград');

-- 6. Insert Final Reveal
INSERT INTO "Final_Reveal" (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES (
  6, 6,
  'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister\'s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.',
  'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.',
  'Dr. Lisette Marchand',
  'Д-р Лизет Маршан'
); 