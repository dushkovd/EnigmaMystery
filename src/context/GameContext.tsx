import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Game, getActiveGames } from '../api/games';

interface GameContextType {
  games: Game[];
  loading: boolean;
  error: string | null;
  getGameById: (id: string) => Game | undefined;
}

const GameContext = createContext<GameContextType | undefined>(undefined);

export const useGames = () => {
  const context = useContext(GameContext);
  if (!context) {
    throw new Error('useGames must be used within a GameProvider');
  }
  return context;
};

interface GameProviderProps {
  children: ReactNode;
}

export const GameProvider: React.FC<GameProviderProps> = ({ children }) => {
  const [games, setGames] = useState<Game[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchGames = async () => {
      try {
        setLoading(true);
        const activeGames = await getActiveGames();
        setGames(activeGames);
      } catch (err) {
        setError('Failed to load games.');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchGames();
  }, []);

  const getGameById = (id: string) => {
    return games.find(game => game.id === id);
  };

  const value = { games, loading, error, getGameById };

  return (
    <GameContext.Provider value={value}>
      {children}
    </GameContext.Provider>
  );
}; 