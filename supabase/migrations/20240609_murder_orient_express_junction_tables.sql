-- Migration: Add Murder on the Orient Express using junction table structure
-- This ensures efficient data storage and balanced clue distribution

-- 1. Insert Game
INSERT INTO "Games" (
  game_id, title, title_bg, subtitle, subtitle_bg, description, description_bg, setting, image, image_path, difficulty, players, duration, featured, price, is_active, victim, victim_bg
) VALUES (
  3,
  'Murder on the Orient Express',
  'Убийство в Ориент Експрес',
  'A 1970s Luxury Train Mystery',
  'Мистерия в луксозен влак от 70-те години на 20-ти век',
  'The Orient Express, the most luxurious train in Europe, has been stopped by a snowdrift in the middle of the night. When morning comes, the wealthy Bulgarian industrialist Viktor Petrov is found dead in his locked compartment, stabbed twelve times. With the train stranded and no way for the killer to escape, the murderer must be among the passengers. But who had the motive, means, and opportunity to commit this brutal crime?',
  'Ориент Експрес, най-луксозният влак в Европа, е спрян от снежен занос в средата на нощта. Когато настъпва сутринта, богатият български индустриалец Виктор Петров е намерен мъртъв в заключеното си купе, намушкан дванадесет пъти. При спрян влак и без възможност убиецът да избяга, той трябва да е сред пътниците. Но кой е имал мотив, средства и възможност да извърши това брутално престъпление?',
  '1920s luxury train, Sofia → Paris, stranded in snow',
  'null',
  NULL,
  'Hard',
  '6-10',
  '1-3 hours',
  true,
  44.99,
  true,
  'Viktor Petrov',
  'Виктор Петров'
);

-- 2. Insert Game Variations (6-10 players)
INSERT INTO "Game_Variations" (
  variation_id, game_id, num_players, variation_title, variation_title_bg, notes, notes_bg
) VALUES
  (11, 3, 6, '6 Players', '6 играчи', 'Core mystery with essential characters', 'Основна мистерия с основни герои'),
  (12, 3, 7, '7 Players', '7 играчи', '-', '-'),
  (13, 3, 8, '8 Players', '8 играчи', '-', '-'),
  (14, 3, 9, '9 Players', '9 играчи', '-', '-'),
  (15, 3, 10, '10 Players', '10 играчи', '-', '-');

-- 3. Insert Rounds for all variations (5 rounds each)
INSERT INTO "Rounds" (
  round_id, variation_id, round_number, title, title_bg, description, description_bg
) VALUES
  -- 6 Players (rounds 31-35)
  (31, 11, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character’s secret you want to reveal in the next round. ', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
  (32, 11, 2, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (33, 11, 3, 'Deeper Investigation', 'По-задълбочено разследване', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
  (34, 11, 4, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (35, 11, 5, 'Final Evidence', 'Финални улики', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
  
  -- 7 Players (rounds 36-40)
  (36, 12, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
  (37, 12, 2, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (38, 12, 3, 'Deeper Investigation', 'По-задълбочено разследване', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
  (39, 12, 4, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (40, 12, 5, 'Final Evidence', 'Финални улики', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
  
  -- 8 Players (rounds 41-45)
  (41, 13, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
  (42, 13, 2, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (43, 13, 3, 'Deeper Investigation', 'По-задълбочено разследване', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
  (44, 13, 4, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (45, 13, 5, 'Final Evidence', 'Финални улики', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
  
  -- 9 Players (rounds 46-50)
  (46, 14, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
  (47, 14, 2, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (48, 14, 3, 'Deeper Investigation', 'По-задълбочено разследване', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
  (49, 14, 4, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (50, 14, 5, 'Final Evidence', 'Финални улики', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
  
  -- 10 Players (rounds 51-55)
  (51, 15, 1, 'Crime Scene Investigation', 'Разследване на местопрестъплението', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
  (52, 15, 2, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (53, 15, 3, 'Deeper Investigation', 'По-задълбочено разследване', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
  (54, 15, 4, 'Secret Revelation', 'Разкриване на тайна', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
  (55, 15, 5, 'Final Evidence', 'Финални улики', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. ');

-- 4. Insert unique characters (shared across variations)
INSERT INTO "Characters" (
  character_id, name, name_bg, description, description_bg, secret, secret_bg, connection, connection_bg, circumstances, circumstances_bg
) VALUES
  -- Core characters (used in all variations)
  (100, 'Elena Markova', 'Елена Маркова', 'Former fiancée of Viktor', 'Бивша годеница на Виктор', 'She almost commited a suicide after being blackmailed by Viktor over a family scandal', 'Тя прави неуспешен опит за самоубийство заради Виктор, който я изнудва за семееен скандал', 'Viktor broke off their engagement after discovering her family''s criminal past', 'Виктор развали годежа им след като откри престъпното минало на семейството ѝ', 'Traveling to Paris for a new life', 'Пътува за Париж в търсене на нов живот'),
  (101, 'Nikolai Ivanov', 'Николай Иванов', 'Business partner of Viktor', 'Бизнес партньор на Виктор', 'He was embezzling money from Viktor''s company', 'Той е присвоявал пари от компанията на Виктор', 'Viktor recently discovered Nikolai''s embezzlement and was planning to report him', 'Виктор наскоро откри присвояването на Николай и планираше да го докладва', 'Claims to be on a business trip to Paris', 'Твърди, че е на бизнес пътуване до Париж'),
  (102, 'Maria Petrova', 'Мария Петрова', 'Estranged daughter of Viktor', 'Отчуждена дъщеря на Виктор', 'She threatened Viktor in a letter found by the police', 'Тя е заплашила Виктор в писмо, намерено от полицията', 'Viktor disinherited her partially after she refused to marry his business associate', 'Виктор я лиши частично от наследство след като тя отказа да се омъжи за неговия бизнес партньор', 'Traveling under a false name to Paris', 'Пътува под фалшиво име за Париж'),
  (103, 'Georgi Stoyanov', 'Георги Стоянов', 'Former bodyguard of Viktor', 'Бивш телохранител на Виктор', 'He was paid by an unknown person to "watch" Viktor', 'Той е получил пари от неизвестен човек за да "наблюдава" Виктор', 'Viktor fired him after he failed to prevent an assassination attempt on his son', 'Виктор го уволни след като не успя да предотврати опит за убийство на неговият син', 'Claims to be traveling to Paris to find new work', 'Твърди, че пътува за Париж да намери нова работа'),
  (104, 'Sofia Dimitrova', 'София Димитрова', 'Famous opera singer, Viktor''s former lover', 'Известна оперна певица, бивша любовница на Виктор', 'She is addicted to laudanum and fears her addiction will be exposed', 'Тя е пристрастена към лауданум и се страхува, че пристрастността ѝ ще бъде разкрита', 'Viktor abandoned her when she became pregnant and refused to acknowledge the child', 'Виктор я изостави, когато забременя и отказа да признае детето', 'On tour, but her ticket was paid for by Viktor', 'На турне, но билетът ѝ е платен от Виктор'),
  (105, 'Petar Kolev', 'Петър Колев', 'Train conductor', 'Кондуктор на влака', 'He has a duplicate key to all compartments', 'Той има резервен ключ за всички купета', 'Viktor bribed him to ensure privacy and security during his journey', 'Виктор го подкупи да осигури поверителност и сигурност по време на пътуването си', 'Working the train', 'Работи във влака'),
  
  -- Additional characters (one per extra variation)
  (106, 'Irina Vasileva', 'Ирина Василева', 'Personal assistant of Viktor', 'Лична асистентка на Виктор', 'She has been stealing money from Viktor''s accounts for months', 'Тя краде пари от сметките на Виктор от месеци', 'Viktor was planning to fire her and replace her with his daughter Maria', 'Виктор планираше да я уволни и да я замени с дъщеря си Мария', 'Claims to be seeking work in Paris', 'Твърди, че търси работа в Париж'),
  (107, 'Mihail Todorov', 'Михаил Тодоров', 'Rival industrialist', 'Конкуриращ индустриалец', 'He bribed someone on the train for information about Viktor', 'Той е подкупил някой във влака за информация за Виктор', 'Viktor was about to expose Mihail''s illegal business practices in court', 'Виктор беше на път да разкрие незаконните бизнес практики на Михаил в съда', 'Claims to be traveling for business to Paris', 'Твърди, че пътува за бизнес за Париж'),
  (108, 'Vesela Georgieva', 'Весела Георгиева', 'Investigative journalist', 'Разследващ журналист', 'She fabricated some of the evidence in her investigation to make it more sensational', 'Тя е фалшифицирала част от доказателствата в разследването си, за да го направи по-сензационно', 'Viktor was blackmailing her to prevent publication of her investigation into his factory accidents', 'Виктор я изнудваше, за да предотврати публикуването на разследването ѝ за инцидентите във фабриката му', 'Traveling incognito to Paris', 'Пътува инкогнито за Париж'),
  (109, 'Stefan Dimitrov', 'Стефан Димитров', 'Estranged husband of Sofia', 'Отчужден съпруг на София', 'He was seen arguing with Viktor the night of the murder', 'Той е видян да се кара с Виктор в нощта на убийството', 'Viktor was trying to convince Sofia to leave Stefan and return to him', 'Виктор се опитваше да убеди София да напусне Стефан и да се върне при него', 'Claims to be following Sofia to Paris', 'Твърди, че следва София за Париж');

-- 5. Link characters to variations using junction table
INSERT INTO "Character_Variations" (character_id, variation_id) VALUES
  -- 6 Players: Core characters only
  (100, 11), (101, 11), (102, 11), (103, 11), (104, 11), (105, 11),
  
  -- 7 Players: Core + Irina
  (100, 12), (101, 12), (102, 12), (103, 12), (104, 12), (105, 12), (106, 12),
  
  -- 8 Players: Core + Irina + Mihail
  (100, 13), (101, 13), (102, 13), (103, 13), (104, 13), (105, 13), (106, 13), (107, 13),
  
  -- 9 Players: Core + Irina + Mihail + Vesela
  (100, 14), (101, 14), (102, 14), (103, 14), (104, 14), (105, 14), (106, 14), (107, 14), (108, 14),
  
  -- 10 Players: All characters
  (100, 15), (101, 15), (102, 15), (103, 15), (104, 15), (105, 15), (106, 15), (107, 15), (108, 15), (109, 15);

-- 6. Insert unique clues (shared across variations)
INSERT INTO "Clues" (clue_id, content, content_bg) VALUES
  -- Core clues (used in all variations)
  (200, 'Victim found stabbed 12 times in locked compartment', 'Жертвата е намерена с 12 прободни рани в заключено купе'),
  (201, 'Murder weapon - ceremonial dagger with initials "E.M." engraved', 'Оръжие на убийството - церемониален кинжал с избродирани инициали "Е.М."'),
  (202, 'Train stopped for 2 hours due to snowdrift (12:30 AM - 2:30 AM)', 'Влакът е спрян за 2 часа поради снежен занос (12:30 - 2:30 сутринта)'),
  (203, 'Torn-up letter found in wastebasket, pieces missing', 'Разкъсано писмо намерено в кошчето, липсват парчета'),
  (204, 'Compartment key found under victim''s body', 'Ключът на купето е намерен под тялото на жертвата'),
  (205, 'Conductor saw someone in corridor at 1:45 AM wearing dark coat', 'Кондукторът видя някой в коридора в 1:45 сутринта, носещ тъмно палто'),
  (206, 'Missing pieces of torn letter reveal it''s signed "Maria" and mentions "father"', 'Липсващите парчета от разкъсаното писмо разкриват, че е подписано "Мария" и споменава "татко"'),
  (207, 'Viktor''s will was recently changed, cutting out Nikolai Ivanov completely', 'Завещанието на Виктор беше наскоро променено, като Николай Иванов е напълно изключен'),
  (208, 'Viktor had traces of sedative in his system, likely administered 1-2 hours before death', 'Виктор имаше следи от успокоително в организма, вероятно приложено 1-2 часа преди смъртта'),
  (210, 'Georgi claims he was in dining car, but dining car was closed after midnight', 'Георги твърди, че е бил в ресторант вагона, но ресторант вагонът беше затворен след полунощ'),
  (211, 'Secret compartment in Viktor''s luggage contains blackmail photos of several passengers', 'Тайно отделение в багажа на Виктор съдържа снимки за изнудване на няколко пътници'),
  (212, 'Multiple fingerprints on dagger: victim''s, Elena''s, Maria''s, and one unidentified', 'Множество пръстови отпечатъци по кинжала: на жертвата, на Елена, на Мария и един неидентифициран'),
  (213, 'Medical examiner confirms death between 1:30-2:00 AM based on body temperature', 'Съдебно-медицинският експерт потвърждава смъртта между 1:30-2:00 сутринта въз основа на телесната температура'),
  (214, 'Small amount of blood found on corridor carpet outside Viktor''s compartment', 'Малко количество кръв намерено на килима в коридора извън купето на Виктор'),
  (215, 'Second letter found in Viktor''s pocket mentions "exposing the truth about the factory accident"', 'Второ писмо намерено в джоба на Виктор споменава за "разкриване на истината за фабричния инцидент"'),
  (216, 'Compartment door was locked from inside, and window was found slightly open with fresh snow on windowsill', 'Вратата на купето беше заключена отвътре, а прозорецът беше намерен леко отворен със свеж сняг на перваза'),
  (220, 'Sofia was seen leaving her compartment at 1:00 AM, returning at 1:30 AM', 'София беше видяна да напуска купето си в 1:00 сутринта, връщайки се в 1:30 сутринта'),
  (221, 'Georgi was seen near Viktor''s compartment at 1:20 AM, but claims he was checking security', 'Георги беше видян близо до купето на Виктор в 1:20 сутринта, но твърди, че е проверявал сигурността'),
  (222, 'Elena was seen crying in her compartment at 1:10 AM, but refused to explain why', 'Елена беше видяна да плаче в купето си в 1:10 сутринта, но отказва да обясни защо'),
  
  -- Additional clues for new characters (exactly 2 per character)
  (230, 'Gold earring matching Irina''s found near victim''s compartment', 'Златната гривна на Ирина, намерена близо до купето на жертвата'),
  (231, 'Witness saw Irina leaving Viktor''s compartment late at night, clutching a document', 'Свидетел видя Ирина да напуска купето на Виктор късно през нощта, държейки документ'),
  (232, 'Business card of Mihail Todorov found in victim''s pocket', 'Визитка на Михаил Тодоров намерена в джоба на жертвата'),
  (233, 'Conductor overheard Mihail asking about Viktor''s travel plans', 'Кондукторът дочу Михаил да се интересува от пътуването на Виктор'),
  (234, 'Press credentials found in Vesela''s compartment under false name', 'Журналистически акредитации намерени в купето на Весела под фалшиво име'),
  (235, 'Vesela was seen taking photographs of other passengers secretly', 'Весела беше видяна да прави тайни снимки на други пътници'),
  (236, 'Stefan''s ticket shows he boarded at last minute, same station as Sofia', 'Билетът на Стефан показва, че се е качил в последния момент, от същата гара като София'),
  (237, 'Stefan was seen arguing with Viktor in dining car before midnight', 'Стефан беше видян да се кара с Виктор в ресторант вагона преди полунощ');

-- 7. Link clues to rounds using junction table
-- Core clues linked to ALL variations (6-10 players)
INSERT INTO "Clue_Rounds" (clue_id, round_id, clue_number) VALUES
  -- Round 1: Crime Scene Investigation (clues 200-205) - ALL variations
  (200, 31, 1), (201, 31, 2), (202, 31, 3), (203, 31, 4), (204, 31, 5), (205, 31, 6),
  (200, 36, 1), (201, 36, 2), (202, 36, 3), (203, 36, 4), (204, 36, 5), (205, 36, 6),
  (200, 41, 1), (201, 41, 2), (202, 41, 3), (203, 41, 4), (204, 41, 5), (205, 41, 6),
  (200, 46, 1), (201, 46, 2), (202, 46, 3), (203, 46, 4), (204, 46, 5), (205, 46, 6),
  (200, 51, 1), (201, 51, 2), (202, 51, 3), (203, 51, 4), (204, 51, 5), (205, 51, 6),
  
  -- Round 3: Deeper Investigation (clues 206-212) - ALL variations
  (206, 33, 1), (207, 33, 2), (208, 33, 3), (210, 33, 4), (211, 33, 5), (212, 33, 6),
  (206, 38, 1), (207, 38, 2), (208, 38, 3), (210, 38, 4), (211, 38, 5), (212, 38, 6),
  (206, 43, 1), (207, 43, 2), (208, 43, 3), (210, 43, 4), (211, 43, 5), (212, 43, 6),
  (206, 48, 1), (207, 48, 2), (208, 48, 3), (210, 48, 4), (211, 48, 5), (212, 48, 6),
  (206, 53, 1), (207, 53, 2), (208, 53, 3), (210, 53, 4), (211, 53, 5), (212, 53, 6),
  
  -- Round 5: Final Evidence (clues 213-222) - ALL variations
  (213, 35, 1), (214, 35, 2), (215, 35, 3), (216, 35, 4), (220, 35, 5), (221, 35, 6), (222, 35, 7),
  (213, 40, 1), (214, 40, 2), (215, 40, 3), (216, 40, 4), (220, 40, 5), (221, 40, 6), (222, 40, 7),
  (213, 45, 1), (214, 45, 2), (215, 45, 3), (216, 45, 4), (220, 45, 5), (221, 45, 6), (222, 45, 7),
  (213, 50, 1), (214, 50, 2), (215, 50, 3), (216, 50, 4), (220, 50, 5), (221, 50, 6), (222, 50, 7),
  (213, 55, 1), (214, 55, 2), (215, 55, 3), (216, 55, 4), (220, 55, 5), (221, 55, 6), (222, 55, 7),
  
  -- Additional clues for new characters (exactly 2 per character)
  -- 7 Players: Irina clues (230, 231)
  (230, 36, 8), (231, 38, 8),
  
  -- 8 Players: Mihail clues (232, 233)
  (232, 41, 8), (233, 43, 8),
  
  -- 9 Players: Vesela clues (234, 235)
  (234, 46, 8), (235, 48, 8),
  
  -- 10 Players: Stefan clues (236, 237)
  (236, 51, 8), (237, 53, 8);

-- 8. Insert Final Reveal for all variations
INSERT INTO "Final_Reveal" (
  reveal_id, variation_id, content, content_bg, murderer, murderer_bg
) VALUES
  (9, 11, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира.', 'Maria Petrova', 'Мария Петрова'),
  (10, 12, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Maria Petrova', 'Мария Петрова'),
  (11, 13, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Maria Petrova', 'Мария Петрова'),
  (12, 14, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Maria Petrova', 'Мария Петрова'),
  (13, 15, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Maria Petrova', 'Мария Петрова'); 