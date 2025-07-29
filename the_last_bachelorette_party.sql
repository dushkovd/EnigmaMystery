-- The Last Bachelorette Party - Murder Mystery Game
-- SQL Insert Script for Supabase Database using Junction Tables
-- Game ID: 4, Variations: 16-20, Characters: 1003-1012, Clues: 3000-3099

-- Insert the main game
INSERT INTO "public"."Games" ("game_id", "title", "description", "setting", "price", "is_active", "subtitle", "image", "difficulty", "players", "duration", "featured", "title_bg", "subtitle_bg", "description_bg", "difficulty_bg", "victim", "victim_bg", "setting_bg", "image_path") VALUES
(4, 'The Last Bachelorette Party', 'What was supposed to be the perfect bachelorette party turned into a night of terror when the hired male dancer, "Diamond" Dave Martinez, was found dead in the VIP lounge. With everyone having secrets and motives, it''s up to the bridal party to uncover who killed the entertainer before the police arrive. Was it jealousy, revenge, or something more sinister?', 'A luxurious penthouse suite in downtown Miami, transformed into the ultimate bachelorette party venue. The night is filled with champagne, dancing, and secrets that some would kill to keep hidden.', 14.99, true, 'A Miami Bachelorette Party Gone Wrong', 'https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Medium', '6-10', '2-3 hours', false, 'Последното моминско парти', 'Моминско парти в Маями, което се проваля безвъзвратно', 'Това, което трябваше да бъде перфектното парти за ергенки, се превърна в нощ на ужас, когато наетият мъжки танцьор "Диамант" Дейв Мартинес е намерен мъртъв във VIP залата. С всички да имат тайни и мотиви, на булчинския екип предстои да разкрие кой е убил артиста, преди полицията да пристигне. Беше ли ревност, отмъщение или нещо по-зловещо?', 'Средна', 'Diamond Dave Martinez', 'Диамант Дейв Мартинес', 'Луксозен пентхаус в центъра на Маями, превърнат в ултимативното място за парти за ергенки. Нощта е изпълнена с шампанско, танци и тайни, които някои биха убили, за да запазят скрити.', '4/Bachelorette_party.jpeg');

-- Insert game variations for 6-10 players
INSERT INTO "public"."Game_Variations" ("variation_id", "game_id", "num_players", "variation_title", "notes", "variation_title_bg", "notes_bg") VALUES
(16, 4, 6, '6-Player Version', '-', 'версия за 6 играчи', '-'),
(17, 4, 7, '7-Player Version', '-', 'версия за 7 играчи', '-'),
(18, 4, 8, '8-Player Version', '-', 'версия за 8 играчи', '-'),
(19, 4, 9, '9-Player Version', '-', 'версия за 9 играчи', '-'),
(20, 4, 10, '10-Player Version', '-', 'версия за 10 играчи', '-');

-- Insert unique characters (no duplication - each character appears only once)
INSERT INTO "public"."Characters" ("character_id", "name", "description", "secret", "name_bg", "description_bg", "secret_bg", "connection", "connection_bg", "circumstances", "circumstances_bg") VALUES
(1003, 'Jessica "Jess" Rodriguez', 'The Maid of Honor', 'Had a one-night stand with Dave and feared he would expose her', 'Джесика "Джес" Родригез', 'Главната девойка', 'Имала е еднократна връзка с Дейв и се страхуваше, че ще я разкрие', 'She is the wife of the best man of the wedding (best friend of the groom)', 'Тя е жената на кума на сватбата (най-добрият приятел на младоженеца)', 'Was seen entering the VIP lounge around 10:50 PM', 'Видяна е да влиза във VIP залата около 22:50'),
(1004, 'Sarah Mitchell', 'The Bride-to-Be', 'She secretly hired Dave for private performances and was being blackmailed by him', 'Сара Митчъл', 'Бъдещата булка', 'Тя тайно е наела Дейв за частни представления и той я изнудваше', 'Was questioning whether she should call off the wedding due to financial pressure', 'Обмисляше дали да отмени сватбата поради финансови затруднения', 'Found Dave''s body at 11:30 PM and immediately called security', 'Намерила е тялото на Дейв в 23:30 и веднага е извикала охраната'),
(1005, 'Amanda Chen', 'The Best Friend', 'She was secretly pregnant and considering an abortion', 'Аманда Чен', 'Най-добрата приятелка', 'Тя тайно е бременна и обмисля аборт', 'Dave knew about her secret and was threatening to tell everyone', 'Дейв знаеше за тайната ѝ и я заплашваше да каже на всички', 'Has been acting strangely all night', 'Държи се странно цялата нощ'),
(1006, 'Rachel Thompson', 'The Sister', 'She was secretly in debt and had borrowed money from Dave', 'Рейчъл Томпсън', 'Сестрата', 'Тя тайно е в дълг и е заела пари от Дейв', 'Was being blackmailed by Dave about her gambling addiction', 'Дейв я изнудваше за пристрастяването ѝ към хазарта', 'Was seen arguing with Dave earlier in the evening', 'Видяна е да се кара с Дейв по-рано през вечерта'),
(1007, 'Maya Patel', 'The Cousin', 'She was secretly dating Dave and thought they were exclusive', 'Мая Пател', 'Братовчедката', 'Тя тайно се среща с Дейв и мислеше, че са изключителни', 'Saw Dave making out with a woman during the party and became furious', 'Видя Дейв да се целува с жена по време на партито и се разяри', 'Was seen following both Sarah and Dave throughout the evening', 'Видяна е да следва и Сара, и Дейв през цялата вечер'),
(1008, 'Sophie Williams', 'The College Roommate', 'She was secretly a private investigator hired by the groom''s family', 'Софи Уилямс', 'Студентската съквартирантка', 'Тя тайно е частен детектив, нает от семейството на младоженеца', 'Has been seen reading a notebook with Dave''s name on one of the pages', 'Видяна е да чете тетрадка с името на Дейв на една от страниците', 'Was taking photos of Dave throughout the evening', 'Правише снимки на Дейв през цялата вечер'),
(1009, 'Isabella "Bella" Martinez', 'The Wedding Planner', 'She was secretly Dave''s sister and knew about his criminal activities', 'Изабела "Бела" Мартинес', 'Организаторката на сватбата', 'Тя тайно е сестрата на Дейв и знаеше за престъпните му дейности', 'Was trying to stop Dave from doing unlawful things during the party', 'Опитваше се да спре Дейв да прави незаконни неща по време на партито', 'Has been making mysterious phone calls all evening', 'Прави тайнствени телефонни обаждания цялата вечер'),
(1010, 'Victoria "Vicky" Anderson', 'Friend from School', 'She was Dave''s ex-girlfriend and still obsessed with him', 'Виктория "Вики" Андерсън', 'Приятелка от училище', 'Тя е бившата приятелка на Дейв и все още е обсебена от него', 'Was stalking Dave and jealous of his relationships with other women', 'Преследваше Дейв и ревнуваше от връзките му с други жени', 'Was seen lurking around the venue earlier', 'Видяна е да се крие около мястото по-рано'),
(1011, 'Nicole "Nikki" Foster', 'The Party Planner', 'She was secretly working with the police to bust Dave''s drug operation', 'Никол "Ники" Фостър', 'Организаторката на партито', 'Тя тайно работи с полицията за да разкрие наркотичната операция на Дейв', 'She was recommended by Sophie, as she''s been the organizer of her bachelorette party', 'Тя е препоръчана от Софи, тъй като е била организаторка на партито за ергенки', 'Was the only one not wearing a swimsuit', 'Беше единствената, която не носеше бански костюм'),
(1012, 'Ashley "Ash" Johnson', 'The Security Guard', 'She was secretly Dave''s business partner in his illegal activities', 'Ашли "Аш" Джонсън', 'Охранителката', 'Тя тайно е бизнес партньорка на Дейв в незаконните му дейности', 'Was trying to cover up video evidence of illegal activities during the party', 'Опитваше се да прикрие видео доказателства за незаконни дейности по време на партито', 'Has been monitoring the security cameras all evening', 'Наблюдаваше охранителните камери цялата вечер');

-- Link characters to variations using junction table (much more efficient!)
INSERT INTO "Character_Variations" (character_id, variation_id) VALUES
  -- 6 Players: Core characters only
  (1003, 16), (1004, 16), (1005, 16), (1006, 16), (1007, 16), (1008, 16),
  
  -- 7 Players: Core + Bella
  (1003, 17), (1004, 17), (1005, 17), (1006, 17), (1007, 17), (1008, 17), (1009, 17),
  
  -- 8 Players: Core + Bella + Vicky
  (1003, 18), (1004, 18), (1005, 18), (1006, 18), (1007, 18), (1008, 18), (1009, 18), (1010, 18),
  
  -- 9 Players: Core + Bella + Vicky + Nikki
  (1003, 19), (1004, 19), (1005, 19), (1006, 19), (1007, 19), (1008, 19), (1009, 19), (1010, 19), (1011, 19),
  
  -- 10 Players: All characters
  (1003, 20), (1004, 20), (1005, 20), (1006, 20), (1007, 20), (1008, 20), (1009, 20), (1010, 20), (1011, 20), (1012, 20);

-- Insert unique clues with specific evidence pointing to suspects (balanced to maintain probability rankings)
INSERT INTO "Clues" (clue_id, content, content_bg) VALUES
  -- Core clues (used in all variations) - focused on physical evidence and timeline
  (3000, 'Dave Martinez found dead in VIP lounge with blunt force trauma to the head', 'Дейв Мартинес е намерен мъртъв във VIP залата с тупа травма на главата'),
  (3001, 'Murder weapon - champagne bottle with fingerprints from multiple people', 'Оръжие на убийството - бутилка шампанско с пръстови отпечатъци от множество хора'),
  (3002, 'Party started at 8 PM, Dave arrived at 9 PM, body found at 11:30 PM', 'Партито започна в 20:00, Дейв пристигна в 21:00, тялото е намерено в 23:30'),
  (3004, 'Dave''s phone found with threatening messages from multiple numbers', 'Телефонът на Дейв е намерен с заплашителни съобщения от множество номера'),
  (3005, 'VIP lounge door was locked from inside, window was found open', 'Вратата на VIP залата беше заключена отвътре, прозорецът беше намерен отворен'),
  (3006, 'Medical examiner confirms death between 11:00-11:30 PM', 'Съдебно-медицинският експерт потвърждава смъртта между 23:00-23:30'),
  (3007, 'Dave had traces of sedative in his system, likely administered 1-2 hours before death', 'Дейв имаше следи от успокоително в организма, вероятно приложено 1-2 часа преди смъртта'),
  (3008, 'Several empty champagne bottles found in VIP lounge', 'Няколко празни бутилки шампанско намерени във VIP залата'),
  (3009, 'Dave''s wallet found empty, but he was paid $2000 for the performance', 'Портфейлът на Дейв е намерен празен, но беше платен $2000 за представлението'),
  (3010, 'Sarah was seen arguing with Dave in the hallway at 10:45 PM, just before the music started', 'Сара беше видяна да се кара с Дейв в коридора в 22:45, точно преди музиката да започне'),
  (3011, 'Amanda was seen giving Dave a drink around 9:30 PM, when the sedative was likely administered', 'Аманда беше видяна да дава на Дейв напитка около 21:30, когато вероятно е приложено успокоителното'),
  (3012, 'Jess was overheard saying "I can''t let him ruin everything" to someone on the phone', 'Джес беше дочута да казва "Не мога да позволя да развали всичко" на някого по телефона'),
  (3013, 'Dave''s car keys found in the pool area, but his car is still in the parking lot', 'Ключовете на колата на Дейв са намерени в зоната на басейна, но колата му все още е на паркинга'),
  (3014, 'Security log shows Dave entered the building at 9:05 PM through the service entrance', 'Охранителният дневник показва, че Дейв е влязъл в сградата в 21:05 през служебния вход'),
  (3015, 'Dave''s performance contract shows he was supposed to leave by 11:00 PM', 'Договорът за представление на Дейв показва, че трябваше да напусне до 23:00'),
  
  -- Character-specific clues (1 per additional character for 7,8,9,10 player variations)
  -- Bella Martinez clue (7 players)
  (3017, 'Bella was overheard saying "I need to protect him" to someone on the phone', 'Бела беше дочута да казва "Трябва да го защитя" на някого по телефона'),
  
  -- Vicky Anderson clue (8 players)
  (3019, 'Vicky was seen following Dave when he arrived at the party', 'Вики беше видяна да следва Дейв, когато пристигна на партито'),
  
  -- Nikki Foster clue (9 players)
  (3021, 'Nikki was overheard saying "The operation is compromised" to someone', 'Ники беше дочута да казва "Операцията е компрометирана" на някого'),
  
  -- Ash Johnson clue (10 players)
  (3023, 'Ash was the only person who knew the VIP lounge security code that evening', 'Аш беше единствената, която знаеше кода за сигурност на VIP залата тази вечер');

-- Create rounds for each variation (5 rounds per variation = 25 rounds total)
INSERT INTO "Rounds" (round_id, variation_id, round_number, round_title, round_title_bg) VALUES
  -- 6 Players (variation 16)
  (60, 16, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението'),
  (61, 16, 2, 'Secret Revelation', 'Разкриване на тайни'),
  (62, 16, 3, 'Evidence Analysis', 'Анализ на доказателствата'),
  (63, 16, 4, 'Secret Revelation', 'Разкриване на тайни'),
  (64, 16, 5, 'Final Set of Clues', 'Финални улики'),
  
  -- 7 Players (variation 17)
  (65, 17, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението'),
  (66, 17, 2, 'Secret Revelation', 'Разкриване на тайни'),
  (67, 17, 3, 'Evidence Analysis', 'Анализ на доказателствата'),
  (68, 17, 4, 'Secret Revelation', 'Разкриване на тайни'),
  (69, 17, 5, 'Final Set of Clues', 'Финални улики'),
  
  -- 8 Players (variation 18)
  (70, 18, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението'),
  (71, 18, 2, 'Secret Revelation', 'Разкриване на тайни'),
  (72, 18, 3, 'Evidence Analysis', 'Анализ на доказателствата'),
  (73, 18, 4, 'Secret Revelation', 'Разкриване на тайни'),
  (74, 18, 5, 'Final Set of Clues', 'Финални улики'),
  
  -- 9 Players (variation 19)
  (75, 19, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението'),
  (76, 19, 2, 'Secret Revelation', 'Разкриване на тайни'),
  (77, 19, 3, 'Evidence Analysis', 'Анализ на доказателствата'),
  (78, 19, 4, 'Secret Revelation', 'Разкриване на тайни'),
  (79, 19, 5, 'Final Set of Clues', 'Финални улики'),
  
  -- 10 Players (variation 20)
  (80, 20, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението'),
  (81, 20, 2, 'Secret Revelation', 'Разкриване на тайни'),
  (82, 20, 3, 'Evidence Analysis', 'Анализ на доказателствата'),
  (83, 20, 4, 'Secret Revelation', 'Разкриване на тайни'),
  (84, 20, 5, 'Final Set of Clues', 'Финални улики');

-- Link clues to rounds using junction table (much more efficient!)
-- Only rounds 1, 3, and 5 get clues (rounds 2 and 4 are for secret revelation)
INSERT INTO "Clue_Rounds" (clue_id, round_id, clue_number) VALUES
  -- Round 1: Crime Scene Investigation (clues 3000-3002, 3004-3005) - ALL variations
  (3000, 60, 1), (3001, 60, 2), (3002, 60, 3), (3004, 60, 4), (3005, 60, 5),
  (3000, 65, 1), (3001, 65, 2), (3002, 65, 3), (3004, 65, 4), (3005, 65, 5),
  (3000, 70, 1), (3001, 70, 2), (3002, 70, 3), (3004, 70, 4), (3005, 70, 5),
  (3000, 75, 1), (3001, 75, 2), (3002, 75, 3), (3004, 75, 4), (3005, 75, 5),
  (3000, 80, 1), (3001, 80, 2), (3002, 80, 3), (3004, 80, 4), (3005, 80, 5),
  
  -- Round 3: Evidence Analysis (clues 3006-3010) + Character-specific clues (1 per additional character)
  -- 6 Players: Core clues only (3006-3010)
  (3006, 62, 1), (3007, 62, 2), (3008, 62, 3), (3009, 62, 4), (3010, 62, 5),
  
  -- 7 Players: Core clues (3006-3010) + Bella clue (3017)
  (3006, 67, 1), (3007, 67, 2), (3008, 67, 3), (3009, 67, 4), (3010, 67, 5), (3017, 67, 6),
  
  -- 8 Players: Core clues (3006-3010) + Bella clue (3017)
  (3006, 72, 1), (3007, 72, 2), (3008, 72, 3), (3009, 72, 4), (3010, 72, 5), (3017, 72, 6),
  
  -- 9 Players: Core clues (3006-3010) + Bella clue (3017)
  (3006, 77, 1), (3007, 77, 2), (3008, 77, 3), (3009, 77, 4), (3010, 77, 5), (3017, 77, 6),
  
  -- 10 Players: Core clues (3006-3010) + Bella clue (3017) + Ash clue (3023)
  (3006, 82, 1), (3007, 82, 2), (3008, 82, 3), (3009, 82, 4), (3010, 82, 5), (3017, 82, 6), (3023, 82, 7),
  
  -- Round 5: Final Evidence (clues 3011-3015) + Character-specific clues (1 per additional character)
  -- 6 Players: Core clues only (3011-3015)
  (3011, 64, 1), (3012, 64, 2), (3013, 64, 3), (3014, 64, 4), (3015, 64, 5),
  
  -- 7 Players: Core clues only (3011-3015)
  (3011, 69, 1), (3012, 69, 2), (3013, 69, 3), (3014, 69, 4), (3015, 69, 5),
  
  -- 8 Players: Core clues (3011-3015) + Vicky clue (3019)
  (3011, 74, 1), (3012, 74, 2), (3013, 74, 3), (3014, 74, 4), (3015, 74, 5), (3019, 74, 6),
  
  -- 9 Players: Core clues (3011-3015) + Vicky clue (3019) + Nikki clue (3021)
  (3011, 79, 1), (3012, 79, 2), (3013, 79, 3), (3014, 79, 4), (3015, 79, 5), (3019, 79, 6), (3021, 79, 7),
  
  -- 10 Players: Core clues (3011-3015) + Vicky clue (3019) + Nikki clue (3021)
  (3011, 84, 1), (3012, 84, 2), (3013, 84, 3), (3014, 84, 4), (3015, 84, 5), (3019, 84, 6), (3021, 84, 7);

-- Insert Final Reveal for all variations
INSERT INTO "Final_Reveal" (reveal_id, variation_id, content, content_bg, murderer, murderer_bg) VALUES
(13, 16, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Sarah Mitchell', 'Сара Митчъл'),
  (14, 17, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Sarah Mitchell', 'Сара Митчъл'),
  (15, 18, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Sarah Mitchell', 'Сара Митчъл'),
  (16, 19, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Sarah Mitchell', 'Сара Митчъл'),
  (17, 20, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Sarah Mitchell', 'Сара Митчъл');

-- Update sequences to reflect the new IDs
SELECT setval('"public"."Games_game_id_seq"', 4, true);
SELECT setval('"public"."Game_Variations_variation_id_seq"', 20, true);
SELECT setval('"public"."Characters_character_id_seq"', 1012, true);
SELECT setval('"public"."Clues_clue_id_seq"', 3023, true);
SELECT setval('"public"."Rounds_round_id_seq"', 84, true);
SELECT setval('"public"."Final_Reveal_reveal_id_seq"', 17, true);

-- End of The Last Bachelorette Party SQL Insert Script (Junction Table Version) 