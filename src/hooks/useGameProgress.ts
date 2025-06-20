import { useState, useEffect, useCallback } from 'react';
import { GameWithDetails } from '../api/games';

const useGameProgress = (game: GameWithDetails | null) => {
  const [gameScreens, setGameScreens] = useState<string[]>(['introduction']);
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    if (game && game.variations && game.variations.length > 0 && game.variations[0].rounds) {
      const screens = ['introduction', 'characters'];
      const rounds = game.variations[0].rounds.map((_, i) => `round${i + 1}`);
      screens.push(...rounds);
      screens.push('solution');
      setGameScreens(screens);
    } else {
      setGameScreens(['introduction']);
    }
    // Reset index when game changes to avoid being out of bounds
    setCurrentIndex(0);
  }, [game]);

  const goToNextScreen = useCallback(() => {
    setCurrentIndex(prevIndex => Math.min(prevIndex + 1, gameScreens.length - 1));
  }, [gameScreens.length]);

  const goToPreviousScreen = useCallback(() => {
    setCurrentIndex(prevIndex => Math.max(prevIndex - 1, 0));
  }, []);

  const currentScreen = gameScreens[currentIndex] || 'introduction';
  const isFirstScreen = currentIndex === 0;
  const isLastScreen = currentIndex === gameScreens.length - 1;

  return {
    currentScreen,
    goToNextScreen,
    goToPreviousScreen,
    isFirstScreen,
    isLastScreen,
  };
};

export default useGameProgress;