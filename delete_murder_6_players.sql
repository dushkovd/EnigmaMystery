-- Delete script to remove Murder on the Midnight Express 6-player variation
-- Delete in reverse order to avoid foreign key constraint violations

-- 1. Delete Final Reveal for 6 players
DELETE FROM "Final_Reveal" WHERE reveal_id = 7;

-- 2. Delete Clues for 6 players
DELETE FROM "Clues" WHERE round_id IN (19, 20, 21);

-- 3. Delete Characters for 6 players
DELETE FROM "Characters" WHERE variation_id = 7;

-- 4. Delete Rounds for 6 players
DELETE FROM "Rounds" WHERE variation_id = 7;

-- 5. Delete Game Variation (6 players)
DELETE FROM "Game_Variations" WHERE variation_id = 7; 