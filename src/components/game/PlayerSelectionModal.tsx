import React from 'react';
// Animations removed for performance
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
      <div
        className="absolute inset-0 bg-black bg-opacity-50"
        onClick={onClose}
      />

      {/* Modal */}
      <div className="relative bg-white rounded-lg shadow-xl max-w-md w-full mx-4 p-6">
        <button className="absolute top-3 right-3 text-secondary-400 hover:text-secondary-600" onClick={onClose}>
          <X className="w-5 h-5" />
        </button>

        <h3 className="text-xl font-display font-bold mb-4">
          {t('game.selectPlayers')}
        </h3>

        <div className="space-y-3">
          {game.variations.map(variation => (
            <button
              key={variation.variation_id}
              className="w-full p-3 text-left rounded border hover:bg-secondary-50"
              onClick={() => onSelect(variation.variation_id)}
            >
              {variation.num_players} {t('game.players')}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};

export default PlayerSelectionModal; 