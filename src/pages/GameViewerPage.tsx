import React, { useEffect, useState } from 'react';
import { useParams, useNavigate, Navigate } from 'react-router-dom';
import { ChevronLeft, ChevronRight, Home, Loader2 } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { useAuth } from '../context/AuthContext';
import { useLanguage } from '../context/LanguageContext';
import { getGameById, getGameVariations, getGameVariation, GameWithDetails, GameVariation } from '../api/games';
import useGameProgress from '../hooks/useGameProgress';
import IntroductionScreen from '../components/game/IntroductionScreen';
import CharactersScreen from '../components/game/CharactersScreen';
import CluesScreen from '../components/game/CluesScreen';
import SolutionScreen from '../components/game/SolutionScreen';
import PlayerSelectionModal from '../components/game/PlayerSelectionModal';

const GameViewerPage: React.FC = () => {
  const { gameId, screen } = useParams<{ gameId: string, screen?: string }>();
  const { isAuthenticated } = useAuth();
  const { t, language } = useLanguage();
  const navigate = useNavigate();
  const [game, setGame] = useState<GameWithDetails | null>(null);
  const [variations, setVariations] = useState<GameVariation[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedVariationId, setSelectedVariationId] = useState<number | null>(null);
  const [showPlayerSelection, setShowPlayerSelection] = useState(false);

  // Initialize game progress with the actual game state
  const {
    currentScreen,
    goToNextScreen,
    goToPreviousScreen,
    isFirstScreen,
    isLastScreen
  } = useGameProgress(game);

  // Fetch game info and variations only on mount
  useEffect(() => {
    const fetchGameAndVariations = async () => {
      if (!gameId) return;
      try {
        setLoading(true);
        setError(null);
        // Fetch basic game info (no details)
        const gameData = await getGameById(parseInt(gameId));
        setGame(gameData);
        // Fetch variations only
        const variationsData = await getGameVariations(parseInt(gameId));
        setVariations(variationsData);
        if (variationsData?.length) {
          setShowPlayerSelection(true);
        } else {
          setError('No variations found for this game.');
        }
      } catch (err) {
        setError('Failed to load game. Please try again later.');
      } finally {
        setLoading(false);
      }
    };
    fetchGameAndVariations();
  }, [gameId]);

  // Update document title, URL, and scroll to top on screen change
  useEffect(() => {
    if (game) {
      const title = language === 'bg' ? game.title_bg || game.title : game.title;
      document.title = `${title} | Enigma Mysteries`;
      navigate(`/game/${gameId}/${currentScreen}`, { replace: true });
      window.scrollTo(0, 0);
    }
  }, [game, currentScreen, gameId, navigate, language]);

  const handleVariationSelect = async (variationId: number) => {
    setSelectedVariationId(variationId);
    setShowPlayerSelection(false);
    setLoading(true);
    try {
      // Fetch full details for the selected variation
      const variationDetails = await getGameVariation(variationId);
      // Merge the variation details into the game object
      setGame(prev => prev ? { ...prev, variations: [variationDetails] } : null);
    } catch (err) {
      setError('Failed to load selected variation.');
    } finally {
      setLoading(false);
    }
  };

  // Render loading state
  if (loading) {
    return (
      <div className="pt-24 pb-16 min-h-screen bg-secondary-50 flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-8 h-8 text-primary-600 animate-spin mx-auto mb-4" />
          <p className="text-secondary-600">Loading game...</p>
        </div>
      </div>
    );
  }

  // Render error state
  if (error || !game) {
    return (
      <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
        <div className="container-custom">
          <div className="max-w-4xl mx-auto">
            <div className="bg-red-50 border border-red-100 rounded-lg p-4">
              <p className="text-red-600">{error || 'Game not found'}</p>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Get the selected variation
  const selectedVariation = game?.variations?.find(v => v.variation_id === selectedVariationId);

  const getStartingClueNumber = (roundIndex: number) => {
    if (!selectedVariation) return 1;
    let count = 1;
    for (let i = 0; i < roundIndex; i++) {
      count += selectedVariation.rounds[i]?.clues?.length || 0;
    }
    return count;
  };

  // Render game content
  const renderScreen = () => {
    console.log('Selected variation:', selectedVariation, 'Selected variationId:', selectedVariationId);
    console.log('selectedVariation.final_reveal:', selectedVariation?.final_reveal);
    if (!selectedVariation) {
      return (
        <div className="mystery-paper p-6 rounded-lg">
          <div className="text-center text-red-600">
            {t('game.selectPlayersFirst')}
          </div>
        </div>
      );
    }

    switch (currentScreen) {
      case 'introduction':
        return <IntroductionScreen game={game} variationId={selectedVariationId || undefined} />;
      case 'characters':
        return <CharactersScreen characters={selectedVariation.characters} />;
      case 'round1':
        return <CluesScreen round={selectedVariation.rounds[0]} startingClueNumber={getStartingClueNumber(0)} />;
      case 'round2':
        return <CluesScreen round={selectedVariation.rounds[1]} startingClueNumber={getStartingClueNumber(1)} />;
      case 'round3':
        return <CluesScreen round={selectedVariation.rounds[2]} startingClueNumber={getStartingClueNumber(2)} />;
      case 'solution':
        // If final_reveal is an array, use the first element; otherwise, use as is
        const finalReveal = Array.isArray(selectedVariation.final_reveal)
          ? selectedVariation.final_reveal[0]
          : selectedVariation.final_reveal;
        return <SolutionScreen solution={finalReveal} />;
      default:
        return <IntroductionScreen game={game} variationId={selectedVariationId || undefined} />;
    }
  };

  // Redirect if not authenticated
  if (!isAuthenticated) {
    return <Navigate to="/checkout" />;
  }

  const gameSteps = ['introduction', 'characters', 'round1', 'round2', 'round3', 'solution'];
  const currentStepIndex = gameSteps.indexOf(currentScreen || 'introduction');
  const totalSteps = gameSteps.length;
  const progressPercentage = ((currentStepIndex + 1) / totalSteps) * 100;

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom">
        <div className="max-w-4xl mx-auto">
          <div className="mb-6 flex items-center justify-between">
            <h1 className="text-2xl md:text-3xl font-display font-bold">
              {language === 'bg' ? game.title_bg || game.title : game.title}
            </h1>
            <Link to="/my-products" className="btn-outline py-2 px-3 text-sm">
              <Home className="w-4 h-4 mr-1" />
              {t('game.backToMyGames')}
            </Link>
          </div>
          
          {/* New Progress Bar UI */}
          <div className="mb-8">
            <div className="bg-white rounded-lg shadow-md p-4">
              <div className="flex justify-between items-center mb-2">
                <h2 className="text-lg font-medium text-secondary-700 capitalize">
                  {currentScreen?.replace(/([A-Z])/g, ' $1') || 'Introduction'}
                </h2>
                <span className="text-sm font-medium text-primary-600">
                  Step {currentStepIndex + 1} of {totalSteps}
                </span>
              </div>
              <div className="w-full bg-secondary-200 rounded-full h-2.5">
                <div 
                  className="bg-primary-600 h-2.5 rounded-full transition-all duration-500" 
                  style={{ width: `${progressPercentage}%` }}
                ></div>
              </div>
            </div>
          </div>
          
          {/* Game Screen Content */}
          <div className="vintage-border">
            <div className="vintage-border-inner">
              <AnimatePresence mode="wait">
                <motion.div
                  key={currentScreen}
                  initial={{ opacity: 0, x: 10 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: -10 }}
                  transition={{ duration: 0.3 }}
                >
                  {renderScreen()}
                </motion.div>
              </AnimatePresence>
            </div>
          </div>
          
          {/* Navigation */}
          <div className="mt-8 flex justify-between">
            <button
              onClick={goToPreviousScreen}
              disabled={isFirstScreen}
              className={`btn ${isFirstScreen ? 'bg-secondary-200 cursor-not-allowed text-secondary-400' : 'btn-outline'}`}
            >
              <ChevronLeft className="w-4 h-4 mr-1" />
              {t('game.previous')}
            </button>
            
            <button
              onClick={goToNextScreen}
              disabled={isLastScreen}
              className={`btn ${isLastScreen ? 'bg-secondary-200 cursor-not-allowed text-secondary-400' : 'btn-primary'}`}
            >
              {isLastScreen ? t('game.solutionRevealed') : t('game.next')}
              {!isLastScreen && <ChevronRight className="w-4 h-4 ml-1" />}
            </button>
          </div>
        </div>
      </div>

      {/* Player Selection Modal */}
      <PlayerSelectionModal
        game={{ ...game, variations: variations as any }}
        isOpen={showPlayerSelection}
        onClose={() => setShowPlayerSelection(false)}
        onSelect={handleVariationSelect}
      />
    </div>
  );
};

const Link = ({ to, children, className }: { to: string, children: React.ReactNode, className?: string }) => {
  const navigate = useNavigate();
  return (
    <button 
      onClick={() => navigate(to)} 
      className={className}
    >
      {children}
    </button>
  );
};

export default GameViewerPage;