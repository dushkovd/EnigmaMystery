import { useState, useEffect } from 'react';
import { GameWithDetails } from '../api/games';

type GameScreen = 'introduction' | 'characters' | 'round1' | 'round2' | 'round3' | 'solution';

interface GameProgress {
  currentScreen: GameScreen;
  goToNextScreen: () => void;
  goToPreviousScreen: () => void;
  goToScreen: (screen: GameScreen) => void;
  isFirstScreen: boolean;
  isLastScreen: boolean;
}

export default function useGameProgress(game: GameWithDetails): GameProgress {
  const [currentScreen, setCurrentScreen] = useState<GameScreen>('introduction');
  const [isFirstScreen, setIsFirstScreen] = useState(true);
  const [isLastScreen, setIsLastScreen] = useState(false);

  const screens: GameScreen[] = ['introduction', 'characters', 'round1', 'round2', 'round3', 'solution'];

  // Reset to introduction when game changes
  useEffect(() => {
    setCurrentScreen('introduction');
  }, [game.game_id]);

  useEffect(() => {
    const currentIndex = screens.indexOf(currentScreen);
    setIsFirstScreen(currentIndex === 0);
    setIsLastScreen(currentIndex === screens.length - 1);
  }, [currentScreen]);

  const goToNextScreen = () => {
    const currentIndex = screens.indexOf(currentScreen);
    if (currentIndex < screens.length - 1) {
      setCurrentScreen(screens[currentIndex + 1]);
    }
  };

  const goToPreviousScreen = () => {
    const currentIndex = screens.indexOf(currentScreen);
    if (currentIndex > 0) {
      setCurrentScreen(screens[currentIndex - 1]);
    }
  };

  const goToScreen = (screen: GameScreen) => {
    if (screens.includes(screen)) {
      setCurrentScreen(screen);
    }
  };

  return {
    currentScreen,
    goToNextScreen,
    goToPreviousScreen,
    goToScreen,
    isFirstScreen,
    isLastScreen
  };
}