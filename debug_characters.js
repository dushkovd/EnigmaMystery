// Debug script to check character data and RLS policies
// Run this in your browser console on the staging environment

console.log('=== CHARACTER DEBUG SCRIPT ===');

// Check if we can access the tables
async function debugCharacters() {
  try {
    // 1. Check if we can access Games table
    console.log('1. Testing Games table access...');
    const { data: games, error: gamesError } = await supabase
      .from('Games')
      .select('game_id, title, is_active')
      .limit(3);
    
    console.log('Games:', games);
    console.log('Games error:', gamesError);

    // 2. Check if we can access Game_Variations table
    console.log('\n2. Testing Game_Variations table access...');
    const { data: variations, error: variationsError } = await supabase
      .from('Game_Variations')
      .select('variation_id, game_id, num_players')
      .limit(3);
    
    console.log('Variations:', variations);
    console.log('Variations error:', variationsError);

    // 3. Check if we can access Character_Variations table
    console.log('\n3. Testing Character_Variations table access...');
    const { data: characterVariations, error: cvError } = await supabase
      .from('Character_Variations')
      .select('character_id, variation_id')
      .limit(5);
    
    console.log('Character Variations:', characterVariations);
    console.log('Character Variations error:', cvError);

    // 4. Check if we can access Characters table
    console.log('\n4. Testing Characters table access...');
    const { data: characters, error: charactersError } = await supabase
      .from('Characters')
      .select('character_id, name, name_bg')
      .limit(5);
    
    console.log('Characters:', characters);
    console.log('Characters error:', charactersError);

    // 5. Test the full query that the app uses
    console.log('\n5. Testing full character query for game 1...');
    const { data: fullQuery, error: fullError } = await supabase
      .from('Character_Variations')
      .select(`
        character_id,
        Characters (
          character_id,
          name,
          name_bg,
          description,
          description_bg
        )
      `)
      .eq('variation_id', 1)
      .limit(5);
    
    console.log('Full query result:', fullQuery);
    console.log('Full query error:', fullError);

    // 6. Check if game 1 is active
    console.log('\n6. Checking if game 1 is active...');
    const { data: game1, error: game1Error } = await supabase
      .from('Games')
      .select('game_id, title, is_active')
      .eq('game_id', 1)
      .single();
    
    console.log('Game 1:', game1);
    console.log('Game 1 error:', game1Error);

  } catch (error) {
    console.error('Debug script error:', error);
  }
}

// Run the debug function
debugCharacters(); 