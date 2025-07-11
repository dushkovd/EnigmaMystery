-- Core content tables (shared across variations)
Characters (
  character_id (PK),
  name, name_bg, description, description_bg, 
  secret, secret_bg, connection, connection_bg, 
  circumstances, circumstances_bg
)

Clues (
  clue_id (PK),
  content, content_bg
)

-- Junction tables for variations
Character_Variations (
  character_id (FK),
  variation_id (FK),
  PRIMARY KEY (character_id, variation_id)
)

Clue_Rounds (
  clue_id (FK),
  round_id (FK),
  clue_number,
  PRIMARY KEY (clue_id, round_id)
) 