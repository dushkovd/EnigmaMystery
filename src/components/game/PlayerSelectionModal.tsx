import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X } from 'lucide-react';
import { GameWithDetails } from '../../api/games';
import { useLanguage } from '../../context/LanguageContext';

interface PlayerSelectionModalProps {
  game: GameWithDetails;
  isOpen: boolean;
  onClose: () => void;
  onSelect: (variationId: number) => void;
}

const PlayerSelectionModal: React.FC<PlayerSelectionModalProps> = ({
  game,
  isOpen,
  onClose,
  onSelect
}) => {
  const { t, language } = useLanguage();

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      {/* Backdrop */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="absolute inset-0 bg-black bg-opacity-50"
        onClick={onClose}
      />

      {/* Modal */}
      <motion.div
        initial={{ opacity: 0, scale: 0.95 }}
        animate={{ opacity: 1, scale: 1 }}
        exit={{ opacity: 0, scale: 0.95 }}
        className="relative bg-white rounded-lg shadow-xl max-w-md w-full mx-4 p-6"
      >
        <button
          onClick={onClose}
          className="absolute top-4 right-4 text-secondary-400 hover:text-secondary-600"
        >
          <X className="w-5 h-5" />
        </button>

        <h2 className="text-2xl font-display font-bold mb-4">
          {t('game.selectPlayers')}
        </h2>

        <p className="text-secondary-600 mb-6">
          {t('game.selectPlayersDesc')}
        </p>

        <div className="space-y-3">
          {game.variations
            .sort((a, b) => a.num_players - b.num_players)
            .map((variation) => (
            <button
              key={variation.variation_id}
              onClick={() => onSelect(variation.variation_id)}
              className="w-full p-4 bg-secondary-50 hover:bg-secondary-100 rounded-lg text-left transition-colors"
            >
              <div className="font-display font-medium">
                {variation.num_players} {t('game.players')}
              </div>
              <div className="text-sm text-secondary-600">
                {language === 'bg' ? variation.variation_title_bg || variation.variation_title : variation.variation_title}
              </div>
            </button>
          ))}
        </div>
      </motion.div>
    </div>
  );
};

export default PlayerSelectionModal; 