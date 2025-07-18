import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Users, Clock, Award, ShoppingCart, ChevronLeft, ChevronRight, Loader2 } from 'lucide-react';
import { Game, Character as GameCharacter, getLargestGameVariation, getActiveGames } from '../api/games';
import { useLanguage } from '../context/LanguageContext';
import { useCart } from '../context/CartContext';
import { formatPrice } from '../utils/currencyFormatter';
import { formatDuration } from '../utils/durationFormatter';
import { getGameImages } from '../utils/imageStorage';

const GamePreviewPage: React.FC = () => {
  const { gameId } = useParams<{ gameId: string }>();
  const navigate = useNavigate();
  const { t, language } = useLanguage();
  const { addToCart, items } = useCart();
  const [game, setGame] = useState<Game | null>(null);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [characters, setCharacters] = useState<GameCharacter[]>([]);
  const [gameImages, setGameImages] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchGameData = async () => {
      if (!gameId) return;
      
      setLoading(true);
      try {
        // Fetch basic game info
        const games = await getActiveGames();
        const gameData = games.find(g => g.game_id.toString() === gameId);
        if (!gameData) {
          throw new Error('Game not found');
        }
        setGame(gameData);

        // Fetch characters from the largest variation
        const largestVariation = await getLargestGameVariation(parseInt(gameId));
        if (largestVariation?.characters) {
          setCharacters(largestVariation.characters);
        }

        // Fetch all images from the game's folder
        const images = await getGameImages(parseInt(gameId));
        if (images.length > 0) {
          setGameImages(images);
        } else {
          // Fallback to main game image if no additional images found
          setGameImages([gameData.image].filter(Boolean));
        }
      } catch (error) {
        console.error('Error fetching game preview data:', error);
        navigate('/shop');
      } finally {
        setLoading(false);
        setCurrentImageIndex(0);
      }
    };

    fetchGameData();
  }, [gameId, navigate]);

  const handleAddToCart = () => {
    if (game) {
      addToCart(game.game_id.toString());
      navigate('/cart');
    }
  };

  const nextImage = () => {
    setCurrentImageIndex((prev) => (prev + 1) % gameImages.length);
  };

  const prevImage = () => {
    setCurrentImageIndex((prev) => (prev - 1 + gameImages.length) % gameImages.length);
  };

  const isInCart = game ? items.some(item => item.gameId === game.id) : false;

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-8 h-8 animate-spin mx-auto mb-4 text-primary-600" />
          <p className="text-lg text-secondary-600">
            {language === 'bg' ? 'Зареждане на преглед...' : 'Loading preview...'}
          </p>
        </div>
      </div>
    );
  }

  if (!game) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <p className="text-lg text-red-600">
            {language === 'bg' ? 'Играта не е намерена' : 'Game not found'}
          </p>
          <button 
            onClick={() => navigate('/shop')}
            className="mt-4 btn-primary"
          >
            {language === 'bg' ? 'Назад към магазина' : 'Back to Shop'}
          </button>
        </div>
      </div>
    );
  }

  const title = language === 'bg' ? game.title_bg || game.title : game.title;
  const subtitle = language === 'bg' ? game.subtitle_bg || game.subtitle : game.subtitle;
  const description = language === 'bg' ? game.description_bg || game.description : game.description;
  const difficulty = language === 'bg' ? game.difficulty_bg || game.difficulty : game.difficulty;

  return (
    <div className="min-h-screen bg-secondary-50 pt-24">


      <div className="container-custom py-8">
        <div className="max-w-6xl mx-auto">
          {/* Game Header */}
          <div className="mb-8">
            <h2 className="text-3xl md:text-4xl font-display font-bold text-secondary-800 mb-2">{title}</h2>
            <p className="text-xl text-primary-600 italic">{subtitle}</p>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
            {/* Left Column - Images */}
            <div>
              {/* Game Images Carousel */}
              <div className="mb-8">
                <div className="relative h-80 md:h-96 rounded-lg overflow-hidden shadow-lg">
                  <img
                    src={gameImages[currentImageIndex]}
                    alt={`${title} - Image ${currentImageIndex + 1}`}
                    className="w-full h-full object-cover"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
                  
                  {/* Navigation Arrows */}
                  {gameImages.length > 1 && (
                    <>
                      <button
                        onClick={prevImage}
                        className="absolute left-4 top-1/2 transform -translate-y-1/2 bg-white/80 hover:bg-white text-secondary-800 p-2 rounded-full transition-colors"
                      >
                        <ChevronLeft className="w-5 h-5" />
                      </button>
                      <button
                        onClick={nextImage}
                        className="absolute right-4 top-1/2 transform -translate-y-1/2 bg-white/80 hover:bg-white text-secondary-800 p-2 rounded-full transition-colors"
                      >
                        <ChevronRight className="w-5 h-5" />
                      </button>
                    </>
                  )}

                  {/* Image Indicators */}
                  {gameImages.length > 1 && (
                    <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2">
                      {gameImages.map((_, index) => (
                        <button
                          key={index}
                          onClick={() => setCurrentImageIndex(index)}
                          className={`w-2 h-2 rounded-full transition-colors ${
                            index === currentImageIndex ? 'bg-white' : 'bg-white/50'
                          }`}
                        />
                      ))}
                    </div>
                  )}
                </div>
              </div>

              {/* Game Info Grid */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
                <div className="flex items-center p-4 bg-white rounded-lg shadow-sm">
                  <Users className="w-5 h-5 text-primary-600 mr-3" />
                  <div>
                    <div className="text-sm text-secondary-600">{t('common.players')}</div>
                    <div className="font-medium">{game.players}</div>
                  </div>
                </div>
                <div className="flex items-center p-4 bg-white rounded-lg shadow-sm">
                  <Clock className="w-5 h-5 text-primary-600 mr-3" />
                  <div>
                    <div className="text-sm text-secondary-600">{t('common.duration')}</div>
                    <div className="font-medium">{formatDuration(game.duration, language)}</div>
                  </div>
                </div>
                <div className="flex items-center p-4 bg-white rounded-lg shadow-sm">
                  <Award className="w-5 h-5 text-primary-600 mr-3" />
                  <div>
                    <div className="text-sm text-secondary-600">{t('common.difficulty')}</div>
                    <div className="font-medium">{difficulty}</div>
                  </div>
                </div>
              </div>
            </div>

            {/* Right Column - Content */}
            <div>
              {/* Game Description */}
              <div className="bg-white p-6 rounded-lg shadow-sm mb-8">
                <h3 className="text-xl font-display font-bold mb-4">
                  {language === 'bg' ? 'Контекст' : 'Context'}
                </h3>
                <p className="text-secondary-700 leading-relaxed">{description}</p>
              </div>

              {/* Characters Section */}
              <div className="bg-white p-6 rounded-lg shadow-sm mb-8">
                <h3 className="text-xl font-display font-bold mb-4">{t('game.characters')}</h3>
                <div className="grid grid-cols-1 gap-4">
                  {characters.map((character) => (
                    <div key={character.character_id} className="bg-secondary-50 p-4 rounded-lg">
                      <h4 className="font-display font-medium text-lg mb-2">
                        {language === 'bg' ? character.name_bg : character.name}
                      </h4>
                      <p className="text-secondary-600 text-sm">
                        {language === 'bg' ? character.description_bg : character.description}
                      </p>
                    </div>
                  ))}
                </div>
              </div>

              {/* Action Buttons */}
              <div className="bg-white p-6 rounded-lg shadow-sm">
                <div className="flex items-center justify-between flex-wrap gap-4">
                  <div className="text-3xl font-bold text-secondary-800">
                    {formatPrice(game.price, language)}
                  </div>
                  <div className="flex items-center space-x-3 flex-shrink-0">
                    {isInCart ? (
                      <button 
                        onClick={() => navigate('/cart')}
                        className="btn-primary flex items-center gap-2"
                      >
                        <ShoppingCart className="w-4 h-4" />
                        {t('shop.inCart')}
                      </button>
                    ) : (
                      <button onClick={handleAddToCart} className="btn-primary flex items-center gap-2">
                        <ShoppingCart className="w-4 h-4" />
                        {t('shop.addToCart')}
                      </button>
                    )}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default GamePreviewPage; 