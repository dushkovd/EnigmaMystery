# Create Migration for Games 3 and 4 Only
# This script creates a proper migration with only data for games 3 and 4

Write-Host "Creating migration for games 3 and 4 only..." -ForegroundColor Green

# Create the migration file
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$migrationFile = "supabase\migrations\${timestamp}_games_3_4_data_only.sql"

$migrationContent = @"
-- Migration for Games 3 and 4 data only
-- This migration inserts ONLY data related to games with IDs 3 and 4

SET session_replication_role = replica;

-- Games data (only games 3 and 4)
INSERT INTO "public"."Games" ("game_id", "title", "description", "setting", "price", "is_active", "subtitle", "image", "difficulty", "players", "duration", "featured", "title_bg", "subtitle_bg", "description_bg", "difficulty_bg", "victim", "victim_bg", "setting_bg", "image_path") VALUES
	(3, 'Murder on the Orient Express', 'The Orient Express, the most luxurious train in Europe, has been stopped by a snowdrift in the middle of the night. When morning comes, the wealthy Bulgarian industrialist Viktor Petrov is found dead in his locked compartment. With the train stranded and no way for the killer to escape, the murderer must be among the passengers. But who had the motive, means, and opportunity to commit this brutal crime?', '1970s luxury train, Sofia → Paris, stranded in snow', 14.99, true, 'A 1970s Luxury Train Mystery', 'null', 'Hard', '6-10', '1-3 hours', true, 'Убийство в Ориент Експрес', 'Мистерия в луксозен влак от 70-те години на 20-ти век', 'Ориент Експрес, най-луксозният влак в Европа, е спрян от снежен занос в средата на нощта. Когато настъпва сутринта, богатият български индустриалец Виктор Петров е намерен мъртъв в заключената си купе. При спрян влак и без възможност убиецът да избяга, той трябва да е сред пътниците. Но кой е имал мотив, средства и възможност да извърши това брутално престъпление?', 'Средна', 'Viktor Petrov', 'Виктор Петров', 'Луксозен влак, пътуващ София-Париж през 1970-те, блокиран заради обилни снеговалежи ', '3/Orient_express.jpg'),
	(4, 'The Last Bachelorette Party', 'What was supposed to be the perfect bachelorette party turned into a night of terror when the hired male dancer, "Diamond" Dave Martinez, was found dead in the VIP lounge. With everyone having secrets and motives, it''s up to the bridal party to uncover who killed the entertainer before the police arrive. Was it jealousy, revenge, or something more sinister?', 'A luxurious penthouse suite in downtown Miami, transformed into the ultimate bachelorette party venue. The night is filled with champagne, dancing, and secrets that some would kill to keep hidden.', 14.99, true, 'A Miami Bachelorette Party Gone Wrong', 'https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Medium', '6-10', '2-3 hours', false, 'Последното моминиско парти', 'Моминиско парти в Маями, което завършва трагично', 'Моминиско парти се превръща в нощ на разпити и подозрения, когато наетият танцьор "Даймънд" Дейв Мартинес е намерен мъртъв във VIP залата. Всички присъстващи на притежават дълбоко пазени тайни, някои от които ще бъдат разкрити в опит да бъде разкрит убиецът, още преди полицията да е пристигнала. Дали става въпрос за ревност, отмъщение или нещо още по-зловещо?', 'Средна', 'Diamond (Dave Martinez)', 'Даймънд (Дейв Мартинес)', 'Луксозен пентхаус в центъра на Маями, превърнат в перфектното място за моминиско парти. Нощта е изпълнена с шампанско, танци и тайни, които някои биха убили, за да запазят скрити.', '4/bachelorette_party.png');

-- Game Variations data (only for games 3 and 4)
INSERT INTO "public"."Game_Variations" ("variation_id", "game_id", "num_players", "variation_title", "notes", "variation_title_bg", "notes_bg") VALUES
	(6, 3, 6, '6 Players', NULL, '6 играчи', NULL),
	(7, 3, 7, '7 Players', NULL, '7 играчи', NULL),
	(8, 3, 8, '8 Players', NULL, '8 играчи', NULL),
	(9, 3, 9, '9 Players', NULL, '9 играчи', NULL),
	(10, 3, 10, '10 Players', NULL, '10 играчи', NULL),
	(11, 4, 6, '6 Players', NULL, '6 играчи', NULL),
	(12, 4, 7, '7 Players', NULL, '7 играчи', NULL),
	(13, 4, 8, '8 Players', NULL, '8 играчи', NULL),
	(14, 4, 9, '9 Players', NULL, '9 играчи', NULL),
	(15, 4, 10, '10 Players', NULL, '10 играчи', NULL);

-- Characters data (only for variations of games 3 and 4)
INSERT INTO "public"."Characters" ("character_id", "variation_id", "name", "description", "secret", "name_bg", "description_bg", "secret_bg", "connection", "connection_bg", "circumstances", "circumstances_bg") VALUES
	(41, 6, 'Dr. Lisette Marchand', 'Worldly physician', 'She once attempted to poison another man who escaped justice.', 'Д-р Лизет Маршан', 'Опитен лекар', 'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.', NULL, NULL, NULL, NULL),
	(42, 6, 'Anton Novik', 'Mysterious chess master', 'He is a fugitive using a false identity.', 'Антон Новик', 'Таинствен шахматен майстор', 'Той е беглец с фалшива самоличност.', NULL, NULL, NULL, NULL),
	(43, 6, 'Margot Leclair', 'Investigative journalist. ', 'She is secretly Crowthorne''s illegitimate daughter.', 'Марго Леклер', 'Разследващ журналист', 'Тя е тайнa незаконна дъщеря на Кроуторн.', NULL, NULL, NULL, NULL),
	(44, 6, 'Julian Everett', 'Incognito railway detective', 'He was hired to kill Crowthorne—but chose not to.', 'Джулиан Евърет', 'Инкогнито железопътен детектив', 'Бил е нает да убие Кроуторн, но е отказал.', NULL, NULL, NULL, NULL),
	(45, 6, 'Clara Von Stein', 'Retired opera diva', 'She once attempted blackmail and fears it''s connected.', 'Клара фон Щайн', 'Пенсионирана оперна дива', 'Тя веднъж е опитала изнудване и се страхува, че може да е свързано.', NULL, NULL, NULL, NULL),
	(46, 6, 'Franz Bauer', 'Conductor with a past', 'He has been smuggling items across borders.', 'Франц Бауер', 'Кондуктор с минало', 'Той е пренасял контрабанда през граници.', NULL, NULL, NULL, NULL),
	(47, 6, 'Isadora Wren', 'Spiritualist medium', 'She plants evidence and fabricates "visions."', 'Изадора Урен', 'Медиум спиритуалист', 'Тя подхвърля улики и измисля "видения."', NULL, NULL, NULL, NULL),
	(48, 6, 'Hassan Al-Khatib', 'Antique dealer', 'He forged the ceremonial dagger found at the scene.', 'Хасан Ал-Хатиб', 'Търговец на антики', 'Той е фалшифицирал церемониалния кинжал, намерен на мястото.', NULL, NULL, NULL, NULL),
	(49, 6, 'Eliot Quayle', 'Radical student', 'He forged a threatening letter planted in the victim''s room.', 'Елиът Куейл', 'Радикален студент', 'Той е фалшифицирал заплашително писмо, оставено в стаята на жертвата.', NULL, NULL, NULL, NULL),
	(50, 6, 'Celeste Duval', 'Socialite heiress', 'She lost everything gambling and is desperate.', 'Селест Дювал', 'Светска наследница', 'Тя е загубила всичко от хазарт и е отчаяна.', NULL, NULL, NULL, NULL);

-- Character Variations data (only for variations of games 3 and 4)
INSERT INTO "public"."Character_Variations" ("character_id", "variation_id") VALUES
	(41, 6), (42, 6), (43, 6), (44, 6), (45, 6), (46, 6), (47, 6), (48, 6), (49, 6), (50, 6);

-- Rounds data (only for variations of games 3 and 4)
INSERT INTO "public"."Rounds" ("round_id", "variation_id", "round_number", "title", "description", "title_bg", "description_bg") VALUES
	(6, 6, 1, 'The Discovery', 'The body is found and initial evidence is gathered.', 'Откритието', 'Тялото е намерено и първоначалните улики са събрани.'),
	(7, 6, 2, 'The Investigation', 'Deeper investigation reveals more clues and motives.', 'Разследването', 'По-задълбочено разследване разкрива повече улики и мотиви.'),
	(8, 6, 3, 'The Revelation', 'The truth comes to light and the killer is revealed.', 'Разкритието', 'Истината излиза наяве и убиецът е разкрит.');

-- Clues data (only for rounds of games 3 and 4)
INSERT INTO "public"."Clues" ("clue_id", "round_id", "clue_number", "content", "content_bg", "hidden") VALUES
	(6, 6, 1, 'The victim was found in a locked compartment with no signs of forced entry.', 'Жертвата е намерена в заключена купе без следи от насилствено проникване.', false),
	(7, 6, 2, 'A ceremonial dagger was found near the body.', 'Церемониален кинжал е намерен близо до тялото.', false),
	(8, 6, 3, 'The train was stranded due to heavy snowfall.', 'Влакът е бил блокиран заради обилни снеговалежи.', false),
	(9, 7, 1, 'Several passengers have suspicious backgrounds.', 'Няколко пътници имат подозрително минало.', false),
	(10, 7, 2, 'The victim had valuable business documents.', 'Жертвата е имала ценни бизнес документи.', false),
	(11, 8, 1, 'The killer used the victim''s own weapon.', 'Убиецът е използвал собственото оръжие на жертвата.', false);

-- Clue Rounds data (only for clues of games 3 and 4)
INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(6, 6, 1), (7, 6, 2), (8, 6, 3), (9, 7, 1), (10, 7, 2), (11, 8, 1);

-- Final Reveal data (only for variations of games 3 and 4)
INSERT INTO "public"."Final_Reveal" ("reveal_id", "variation_id", "content", "murderer", "content_bg", "murderer_bg") VALUES
	(3, 6, 'The investigation reveals that the victim was killed by someone who knew his schedule and had access to his compartment. The ceremonial dagger was a red herring planted to mislead investigators.', 'Dr. Lisette Marchand', 'Разследването разкрива, че жертвата е убита от някой, който е знаел графика й и е имал достъп до купето й. Церемониалният кинжал е бил фалшива улика, оставена за да подведе разследващите.', 'Д-р Лизет Маршан');

-- Reset sequences
SELECT setval('public."Games_game_id_seq"', (SELECT COALESCE(MAX(game_id), 0) FROM "Games"));
SELECT setval('public."Game_Variations_variation_id_seq"', (SELECT COALESCE(MAX(variation_id), 0) FROM "Game_Variations"));
SELECT setval('public."Characters_character_id_seq"', (SELECT COALESCE(MAX(character_id), 0) FROM "Characters"));
SELECT setval('public."Rounds_round_id_seq"', (SELECT COALESCE(MAX(round_id), 0) FROM "Rounds"));
SELECT setval('public."Clues_clue_id_seq"', (SELECT COALESCE(MAX(clue_id), 0) FROM "Clues"));
SELECT setval('public."Final_Reveal_reveal_id_seq"', (SELECT COALESCE(MAX(reveal_id), 0) FROM "Final_Reveal"));

SET session_replication_role = DEFAULT;
"@

$migrationContent | Out-File -FilePath $migrationFile -Encoding UTF8

Write-Host "Created migration file: $migrationFile" -ForegroundColor Green
Write-Host "This migration contains ONLY data for games 3 and 4" -ForegroundColor Cyan
Write-Host "To deploy to production, run: supabase db push" -ForegroundColor Yellow 