import { supabase } from '../supabaseClient';
import { getGameImageUrl } from '../utils/imageStorage';

export interface Game {
  game_id: number;
  id: string;  // For backward compatibility with existing components
  title: string;
  subtitle: string;
  description: string;
  setting: string;
  price: number;
  is_active: boolean;
  image: string;
  difficulty: 'Easy' | 'Medium' | 'Hard';
  players: string;
  duration: string;
  featured?: boolean;
  victim?: string;
  // Bulgarian fields
  title_bg?: string;
  subtitle_bg?: string;
  description_bg?: string;
  setting_bg?: string;
  difficulty_bg?: string;
  victim_bg?: string;
}

export interface GameVariation {
  variation_id: number;
  game_id: number;
  num_players: number;
  variation_title: string;
  notes: string;
  // Bulgarian fields
  variation_title_bg?: string;
  notes_bg?: string;
}

export interface Character {
  character_id: number;
  variation_id: number;
  name: string;
  description: string;
  secret: string;
  // Bulgarian fields
  name_bg?: string;
  description_bg?: string;
  secret_bg?: string;
}

export interface Round {
  round_id: number;
  variation_id: number;
  round_number: number;
  title: string;
  description: string;
  // Bulgarian fields
  title_bg?: string;
  description_bg?: string;
}

export interface Clue {
  clue_id: number;
  round_id: number;
  clue_number: number;
  content: string;
  // Bulgarian fields
  content_bg?: string;
}

export interface FinalReveal {
  reveal_id: number;
  variation_id: number;
  content: string;
  murderer?: string;
  // Bulgarian fields
  content_bg?: string;
  murderer_bg?: string;
}

export interface GameWithDetails extends Game {
  variations: (GameVariation & {
    characters: Character[];
    rounds: (Round & {
      clues: Clue[];
    })[];
    final_reveal: FinalReveal;
  })[];
}

// Helper function to transform game data
const transformGameData = (game: any): Game => {
  // Get the image URL - prioritize image_path from Supabase Storage
  let imageUrl = game.image || 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  
  if (game.image_path) {
    const storageUrl = getGameImageUrl(game.image_path);
    if (storageUrl) {
      imageUrl = storageUrl;
      console.log(`Using Supabase Storage image for game ${game.game_id}:`, storageUrl);
    } else {
      console.log(`Failed to generate storage URL for game ${game.game_id}, image_path:`, game.image_path);
    }
  } else {
    console.log(`No image_path for game ${game.game_id}, using fallback:`, game.image);
  }

  return {
    game_id: game.game_id,
    id: game.game_id.toString(),
    title: game.title,
    subtitle: game.subtitle || '',
    description: game.description || '',
    setting: game.setting || '',
    price: game.price,
    is_active: game.is_active ?? true,
    image: imageUrl,
    difficulty: game.difficulty || 'Medium',
    players: game.players || '6-10',
    duration: game.duration || '2-3 hours',
    featured: game.featured ?? false,
    victim: game.victim,
    // Bulgarian fields
    title_bg: game.title_bg,
    subtitle_bg: game.subtitle_bg,
    description_bg: game.description_bg,
    setting_bg: game.setting_bg,
    difficulty_bg: game.difficulty_bg,
    victim_bg: game.victim_bg,
  };
};

// Fetch all active games
export const getActiveGames = async (): Promise<Game[]> => {
  const { data, error } = await supabase
    .from('Games')
    .select('*')
    .eq('is_active', true);

  if (error) throw error;
  return data.map(transformGameData);
};

// Fetch a single game with all its variations and details
export const getGameById = async (gameId: number): Promise<GameWithDetails | null> => {
  console.log('Fetching game by ID:', gameId);
  
  // First get the basic game info
  const { data: game, error: gameError } = await supabase
    .from('Games')
    .select('*')
    .eq('game_id', gameId)
    .single();

  if (gameError) {
    console.error('Error fetching game:', gameError);
    throw gameError;
  }
  if (!game) {
    console.log('No game found with ID:', gameId);
    return null;
  }
  console.log('Basic game data:', game);

  // Get all variations for this game
  console.log('Fetching variations for game_id:', gameId);
  const { data: variations, error: variationsError } = await supabase
    .from('Game_Variations')
    .select(`
      variation_id,
      game_id,
      num_players,
      variation_title,
      notes
    `)
    .eq('game_id', gameId);

  if (variationsError) {
    console.error('Error fetching variations:', variationsError);
    throw variationsError;
  }
  console.log('Raw variations data:', variations);
  console.log('Variations query:', {
    table: 'Game_Variations',
    game_id: gameId,
    error: variationsError
  });

  if (!variations || variations.length === 0) {
    console.log('No variations found for game:', gameId);
    // Let's check if the table exists and has data
    const { data: tableCheck, error: tableError } = await supabase
      .from('Game_Variations')
      .select('*')
      .limit(1);
    
    console.log('Table check:', { tableCheck, tableError });
    
    return {
      ...transformGameData(game),
      variations: []
    };
  }

  // For each variation, get its characters, rounds, clues, and final reveal
  const variationsWithDetails = await Promise.all(
    variations.map(async (variation) => {
      console.log('Processing variation:', variation.variation_id);
      
      // Get characters
      const { data: characters, error: charactersError } = await supabase
        .from('Characters')
        .select('*')
        .eq('variation_id', variation.variation_id);

      if (charactersError) {
        console.error('Error fetching characters:', charactersError);
        throw charactersError;
      }
      console.log('Characters for variation:', variation.variation_id, characters);

      // Get rounds
      const { data: rounds, error: roundsError } = await supabase
        .from('Rounds')
        .select('*')
        .eq('variation_id', variation.variation_id)
        .order('round_number');

      if (roundsError) {
        console.error('Error fetching rounds:', roundsError);
        throw roundsError;
      }
      console.log('Rounds for variation:', variation.variation_id, rounds);

      // Get clues for each round
      const roundsWithClues = await Promise.all(
        rounds.map(async (round) => {
          const { data: clues, error: cluesError } = await supabase
            .from('Clues')
            .select('*')
            .eq('round_id', round.round_id)
            .order('clue_number');

          if (cluesError) {
            console.error('Error fetching clues:', cluesError);
            throw cluesError;
          }
          console.log('Clues for round:', round.round_id, clues);
          return { ...round, clues };
        })
      );

      // Get final reveal
      const { data: finalReveal, error: finalRevealError } = await supabase
        .from('Final_Reveal')
        .select('*')
        .eq('variation_id', variation.variation_id)
        .single();

      if (finalRevealError) {
        console.error('Error fetching final reveal:', finalRevealError);
        throw finalRevealError;
      }
      console.log('Final reveal for variation:', variation.variation_id, finalReveal);

      return {
        ...variation,
        characters,
        rounds: roundsWithClues,
        final_reveal: finalReveal
      };
    })
  );

  console.log('Final variations with details:', variationsWithDetails);

  return {
    ...transformGameData(game),
    variations: variationsWithDetails
  };
};

// Fetch a specific variation of a game
export const getGameVariation = async (variationId: number) => {
  const { data, error } = await supabase
    .from('Game_Variations')
    .select(`
      *,
      game:Games(*),
      characters:Characters(*),
      rounds:Rounds(
        *,
        clues:Clues(*)
      ),
      final_reveal:Final_Reveal(*)
    `)
    .eq('variation_id', variationId)
    .single();

  if (error) throw error;
  
  // Transform the game data
  return {
    ...data,
    game: transformGameData(data.game)
  };
};

// Fetch user's purchased games
export const getUserGames = async (userId: string): Promise<Game[]> => {
  const { data: orderItems, error } = await supabase
    .from('Order_Items')
    .select(`
      game_id,
      price,
      Orders!inner (
        status
      ),
      Games!inner (
        game_id,
        title,
        subtitle,
        description,
        setting,
        image,
        image_path,
        price,
        difficulty,
        difficulty_bg,
        players,
        duration,
        featured,
        victim,
        title_bg,
        subtitle_bg,
        description_bg,
        setting_bg,
        victim_bg
      )
    `)
    .eq('Orders.user_id', userId)
    .eq('Orders.status', 'completed');

  if (error) {
    console.error('Error fetching user games:', error);
    throw error;
  }

  const transformedGames = orderItems
    .filter(item => item.Games)
    .map(item => transformGameData(item.Games));
  return transformedGames;
};

// Fetch only the variations for a game (lightweight)
export const getGameVariations = async (gameId: number) => {
  const { data, error } = await supabase
    .from('Game_Variations')
    .select(`
      variation_id,
      game_id,
      num_players,
      variation_title,
      notes
    `)
    .eq('game_id', gameId);
  if (error) throw error;
  return data;
}; 