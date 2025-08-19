SET session_replication_role = replica;

-- Insert clues
INSERT INTO "public"."Clues" ("clue_id", "round_id", "clue_number", "content", "content_bg", "hidden") VALUES
	(3024, NULL, NULL, 'Zaynep found dead in crew quarters with shattered glass nearby', 'Зайнеп е намерена мъртва в служебното отделение, открито е счупено стъкло наблизо', false),
	(3025, NULL, NULL, 'Toxicology shows combination of sedatives and rare herbal tranquilizer', 'Токсикологията показва комбинация от успокоителни', false),
	(3026, NULL, NULL, 'Zaynep''s keycard is missing', 'Картата за достъп на Зайнеп липсва', false),
	(3027, NULL, NULL, 'Torn journal page: "He thinks I''m scared — I''ve seen worse monsters."', 'Разкъсана страница от дневник: "Той мисли, че се страхувам — виждала съм и по-страшни чудовища."', false),
	(3028, NULL, NULL, 'A to-do list: "Talk to Ayla. Final warning."', 'Списък със задачи: "Да поговоря с Айла. Последно предупреждение."', false),
	(3029, NULL, NULL, 'Security footage glitch: 30-minute blackout reported earlier by Marco', 'Проблем с охранителните кадри: 30-минутно прекъсване, докладвано по-рано от Марко', false),
	(3030, NULL, NULL, 'Felix''s prescription pad has a missing page—no corresponding dose administered on record', 'Рецептурният блок на Феликс има липсваща страница—няма записана съответстваща доза', false),
	(3031, NULL, NULL, 'Ayla''s locker contains the missing keycard and a snapped wine opener', 'Шкафчето на Айла съдържа липсващата карта за достъп и счупена отварачка за вино', false),
	(3032, NULL, NULL, 'Marco''s passport shows conflicting country stamps—Zaynep noted "don''t make me escalate this" in her notes', 'Паспортът на Марко показва противоречиви печати за посещаване на страни—Зайнеп добавя към описаната случка в дневника си "не ме карай да ескалирам това"', false),
	(3033, NULL, NULL, 'Talia''s donation site was accessed from the in-flight Wi-Fi after the time of death', 'Сайтът за дарения на Талия е бил достъпен от бордовия Wi-Fi, малко след настъпване на смъртта', false),
	(3034, NULL, NULL, 'Crew recorder note: "Some passengers think they own the skies... but I won''t be silenced."', 'Бележка от екипажа: "Някои пътници мислят, че притежават небесата... но аз няма да бъда смълчана."', false),
	(3035, NULL, NULL, 'A syringe cap was found under seat 7B — Felix''s assigned seat — but several passengers switched seats during turbulence', 'Капачка от спринцовка е намерена под седалка 7B — назначената седалка на Феликс, но няколко пътници са сменили местата си по време на турбуленцията', false),
	(3036, NULL, NULL, 'Witness saw Marco stash a pouch in a galley bin. Contents not identified', 'Свидетел видя Марко да скрива торбичка в едно от кошчетата. Съдържанието не е идентифицирано', false),
	(3037, NULL, NULL, 'Ayla overheard crying in the lavatory: "I didn''t think she''d actually go through with it."', 'Айла дочу плач в тоалетната: "Не вярвах, че наистина ще го направи."', false),
	(3038, NULL, NULL, 'Deleted footage partially recovered from Talia''s feed shows a flight uniform entering crew quarters — face not visible', 'Частично възстановени са изтритите кадри от фийда на Талия, които показват фигура на човек с униформа, влизащ в помещението на екипажа. Лицето не е видимо', false),
	(3039, NULL, NULL, 'Zaynep''s digital calendar: "Felix – must settle this before it''s too late." But there are unsent messages to both Ayla and Marco', 'Дигиталният календар на Зайнеп: "Феликс – трябва да решим това преди да е станало твърде късно." Намерени са също неизпратени съобщения до Айла и до Марко', false),
	(3040, NULL, NULL, 'Omar''s ID access log shows entry to the electrical systems cabinet around the time the camera went out', 'Картата за достъп на Омар показва влизане в шкафа за електрически системи около времето, когато камерата се е изключила', false),
	(3041, NULL, NULL, 'Diagnostic tool found in Omar''s bag — shows it was recently used to disable camera feeds temporarily', 'Диагностичен инструмент намерен в чантата на Омар — показва, че наскоро е използван за временно изключване на камерата', false),
	(3042, NULL, NULL, 'Ingrid''s bag contains encrypted notes and surveillance photos — one appears to show Zaynep arguing with a man in a lab coat', 'Чантата на Ингрид съдържа криптирани бележки и наблюдениелни снимки — една изглежда показва Зайнеп да се кара с мъж в лабораторна мантия', false),
	(3043, NULL, NULL, 'Flight records show Ingrid used the crew intercom system at the exact time the power flickered — raising questions about coordination or timing', 'Записите на полета показват, че Ингрид използва междукомуникационната система на екипажа точно когато токът премигна — поставяйки въпроси за координация или време', false),
	(3044, NULL, NULL, 'Catering checklist shows an unauthorized drink service made to the crew quarters', 'Чеклистът за кетъринг показва неоторизирана напитка, доставена в помещенията на екипажа', false),
	(3045, NULL, NULL, 'Kitchen camera shows Devon placing a bottle into the staff refrigerator just before the power outage', 'Кухненската камера показва Девън да поставя бутилка в хладилника на персонала точно преди изключването на тока', false),
	(3046, NULL, NULL, 'Passenger manifest shows Hana''s seat as reassigned last-minute without crew input', 'Манифестът на пътниците показва седалката на Хана като преразпределена в последния момент без въвеждане от екипажа', false),
	(3047, NULL, NULL, 'A broken encrypted USB device found in Hana''s carry-on contains logs of internal crew conflicts, including a flagged warning tied to Zaynep', 'Счупено криптирано USB устройство намерено в ръчния багаж на Хана съдържа записи на вътрешни конфликти в екипажа, включително маркирано предупреждение, свързано със Зайнеп', false);

-- Insert clue rounds for 4-player variation (rounds 1, 3, 5 only)
INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(3024, 85, 1), -- Round 1: Crime Scene Investigation
	(3025, 85, 2),
	(3026, 85, 3),
	(3027, 85, 4),
	(3028, 85, 5),
	(3029, 85, 6),
	(3035, 87, 1), -- Round 3: Deeper Investigation
	(3036, 87, 2),
	(3037, 87, 3),
	(3038, 87, 4),
	(3039, 87, 5),
	(3035, 89, 1), -- Round 5: Final Evidence
	(3036, 89, 2),
	(3037, 89, 3),
	(3038, 89, 4),
	(3039, 89, 5);

-- Insert clue rounds for 5-player variation (rounds 1, 3, 5 only)
INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(3024, 90, 1), -- Round 1: Crime Scene Investigation
	(3025, 90, 2),
	(3026, 90, 3),
	(3027, 90, 4),
	(3028, 90, 5),
	(3029, 90, 6),
	(3035, 92, 1), -- Round 3: Deeper Investigation
	(3036, 92, 2),
	(3037, 92, 3),
	(3038, 92, 4),
	(3039, 92, 5),
	(3040, 92, 6),
	(3035, 94, 1), -- Round 5: Final Evidence
	(3036, 94, 2),
	(3037, 94, 3),
	(3038, 94, 4),
	(3039, 94, 5),
	(3041, 94, 6);

-- Insert clue rounds for 6-player variation (rounds 1, 3, 5 only)
INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(3024, 95, 1), -- Round 1: Crime Scene Investigation
	(3025, 95, 2),
	(3026, 95, 3),
	(3027, 95, 4),
	(3028, 95, 5),
	(3029, 95, 6),
	(3035, 97, 1), -- Round 3: Deeper Investigation
	(3036, 97, 2),
	(3037, 97, 3),
	(3038, 97, 4),
	(3039, 97, 5),
	(3040, 97, 6),
	(3042, 97, 7),
	(3035, 99, 1), -- Round 5: Final Evidence
	(3036, 99, 2),
	(3037, 99, 3),
	(3038, 99, 4),
	(3039, 99, 5),
	(3041, 99, 6),
	(3043, 99, 7);

-- Insert clue rounds for 7-player variation (rounds 1, 3, 5 only)
INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(3024, 100, 1), -- Round 1: Crime Scene Investigation
	(3025, 100, 2),
	(3026, 100, 3),
	(3027, 100, 4),
	(3028, 100, 5),
	(3029, 100, 6),
	(3035, 102, 1), -- Round 3: Deeper Investigation
	(3036, 102, 2),
	(3037, 102, 3),
	(3038, 102, 4),
	(3039, 102, 5),
	(3040, 102, 6),
	(3042, 102, 7),
	(3044, 102, 8),
	(3035, 104, 1), -- Round 5: Final Evidence
	(3036, 104, 2),
	(3037, 104, 3),
	(3038, 104, 4),
	(3039, 104, 5),
	(3041, 104, 6),
	(3043, 104, 7),
	(3045, 104, 8);

-- Insert clue rounds for 8-player variation (rounds 1, 3, 5 only)
INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(3024, 105, 1), -- Round 1: Crime Scene Investigation
	(3025, 105, 2),
	(3026, 105, 3),
	(3027, 105, 4),
	(3028, 105, 5),
	(3029, 105, 6),
	(3035, 107, 1), -- Round 3: Deeper Investigation
	(3036, 107, 2),
	(3037, 107, 3),
	(3038, 107, 4),
	(3039, 107, 5),
	(3040, 107, 6),
	(3042, 107, 7),
	(3044, 107, 8),
	(3047, 107, 9),
	(3035, 109, 1), -- Round 5: Final Evidence
	(3036, 109, 2),
	(3037, 109, 3),
	(3038, 109, 4),
	(3039, 109, 5),
	(3041, 109, 6),
	(3043, 109, 7),
	(3045, 109, 8),
	(3047, 109, 9);

RESET ALL; 