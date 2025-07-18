import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Users, Clock, Award, ShoppingCart, ChevronLeft, ChevronRight, Loader2 } from 'lucide-react';
import { Game, Character as GameCharacter, getLargestGameVariation } from '../../api/games';
import { useLanguage } from '../../context/LanguageContext';
import { useCart } from '../../context/CartContext';
import { formatPrice } from '../../utils/currencyFormatter';
import { formatDuration } from '../../utils/durationFormatter';
import { getGameImages } from '../../utils/imageStorage';

interface GamePreviewModalProps {
  game: Game | null;
  isOpen: boolean;
  onClose: () => void;
  onAddToCart: (gameId: number) => void;
}

const GamePreviewModal: React.FC<GamePreviewModalProps> = ({
  game,
  isOpen,
  onClose,
  onAddToCart
}) => {
  const { t, language } = useLanguage();
  const { items } = useCart();
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [characters, setCharacters] = useState<GameCharacter[]>([]);
  const [gameImages, setGameImages] = useState<string[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchGameData = async () => {
      if (isOpen && game) {
        setLoading(true);
        try {
          // Fetch characters from the largest variation
          const largestVariation = await getLargestGameVariation(game.game_id);
          if (largestVariation?.characters) {
            setCharacters(largestVariation.characters);
          }

          // Fetch all images from the game's folder
          const images = await getGameImages(game.game_id);
          if (images.length > 0) {
            setGameImages(images);
          } else {
            // Fallback to main game image if no additional images found
            setGameImages([game.image].filter(Boolean));
          }
        } catch (error) {
          console.error('Error fetching game preview data:', error);
          // Fallback to main game image
          setGameImages([game.image].filter(Boolean));
        } finally {
          setLoading(false);
          setCurrentImageIndex(0);
        }
      }
    };

    fetchGameData();
  }, [isOpen, game]);

  const handleAddToCart = () => {
    if (game) {
      onAddToCart(game.game_id);
      onClose();
    }
  };

  const nextImage = () => {
    setCurrentImageIndex((prev) => (prev + 1) % gameImages.length);
  };

  const prevImage = () => {
    setCurrentImageIndex((prev) => (prev - 1 + gameImages.length) % gameImages.length);
  };

  const isInCart = game ? items.some(item => item.gameId === game.id) : false;

  if (!game || !isOpen) return null;

  const title = language === 'bg' ? game.title_bg || game.title : game.title;
  const subtitle = language === 'bg' ? game.subtitle_bg || game.subtitle : game.subtitle;
  const description = language === 'bg' ? game.description_bg || game.description : game.description;
  const difficulty = language === 'bg' ? game.difficulty_bg || game.difficulty : game.difficulty;

  return (
    <AnimatePresence>
      <motion.div
        className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        onClick={onClose}
      >
        <motion.div
          className="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto"
          initial={{ opacity: 0, scale: 0.9, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.9, y: 20 }}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Header */}
          <div className="sticky top-0 bg-white border-b border-secondary-200 p-6 rounded-t-lg">
            <div className="flex justify-between items-start">
              <div className="flex-1">
                <h2 className="text-2xl font-display font-bold text-secondary-800 mb-2">{title}</h2>
                <p className="text-primary-600 italic">{subtitle}</p>
              </div>
              <button
                onClick={onClose}
                className="text-secondary-400 hover:text-secondary-600 transition-colors ml-4"
              >
                <X className="w-6 h-6" />
              </button>
            </div>
          </div>

          <div className="p-6">
            {loading ? (
              <div className="flex items-center justify-center py-12">
                <div className="text-center">
                  <Loader2 className="w-8 h-8 animate-spin mx-auto mb-4 text-primary-600" />
                  <p className="text-lg text-secondary-600">
                    {language === 'bg' ? 'Зареждане на преглед...' : 'Loading preview...'}
                  </p>
                </div>
              </div>
            ) : (
              <>
                {/* Game Images Carousel */}
                <div className="mb-8">
                  <div className="relative h-64 md:h-80 rounded-lg overflow-hidden">
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
              <div className="flex items-center p-3 bg-secondary-50 rounded-lg">
                <Users className="w-5 h-5 text-primary-600 mr-3" />
                <div>
                  <div className="text-sm text-secondary-600">{t('common.players')}</div>
                  <div className="font-medium">{game.players}</div>
                </div>
              </div>
              <div className="flex items-center p-3 bg-secondary-50 rounded-lg">
                <Clock className="w-5 h-5 text-primary-600 mr-3" />
                <div>
                  <div className="text-sm text-secondary-600">{t('common.duration')}</div>
                  <div className="font-medium">{formatDuration(game.duration, language)}</div>
                </div>
              </div>
              <div className="flex items-center p-3 bg-secondary-50 rounded-lg">
                <Award className="w-5 h-5 text-primary-600 mr-3" />
                <div>
                  <div className="text-sm text-secondary-600">{t('common.difficulty')}</div>
                  <div className="font-medium">{difficulty}</div>
                </div>
              </div>
            </div>

            {/* Game Description */}
            <div className="mb-8">
              <h3 className="text-xl font-display font-bold mb-4">{t('common.description')}</h3>
              <p className="text-secondary-700 leading-relaxed">{description}</p>
            </div>

            {/* Characters Section */}
            <div className="mb-8">
              <h3 className="text-xl font-display font-bold mb-4">{t('game.characters')}</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
            <div className="flex items-center justify-between pt-6 border-t border-secondary-200">
              <div className="text-2xl font-bold text-secondary-800">
                {formatPrice(game.price, language)}
              </div>
              <div className="flex items-center space-x-3">
                {isInCart ? (
                  <button className="btn-primary flex items-center gap-2" disabled>
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
              </>
            )}
          </div>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
};

export default GamePreviewModal; 