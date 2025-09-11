import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useLanguage } from '../../context/LanguageContext';
import { Character } from '../../api/games';

interface SecretRevealScreenProps {
  round: any;
  characters: Character[];
}

interface SecretModalProps {
  character: Character;
  isOpen: boolean;
  onClose: () => void;
}

const SecretModal: React.FC<SecretModalProps> = ({ character, isOpen, onClose }) => {
  const { t, language } = useLanguage();
  
  const getName = (character: Character) => language === 'bg' ? character.name_bg || character.name : character.name;
  const getSecret = (character: Character) => language === 'bg' ? character.secret_bg || character.secret : character.secret;

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          {/* Backdrop */}
          <motion.div
            className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
          >
            {/* Modal */}
            <motion.div
              className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              <div className="p-6">
                <div className="flex justify-between items-center mb-6">
                  <h3 className="text-xl font-display font-bold text-secondary-800">
                    {getName(character)}
                  </h3>
                  <button
                    onClick={onClose}
                    className="text-secondary-400 hover:text-secondary-600 transition-colors"
                  >
                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </div>
                
                <div className="space-y-6">
                  {/* Secret Section */}
                  <div>
                    <h4 className="font-medium text-secondary-700 mb-2 flex items-center">
                      <span className="w-2 h-2 bg-red-500 rounded-full mr-2"></span>
                      {t('game.secret')}
                    </h4>
                    <p className="text-secondary-600 leading-relaxed bg-red-50 p-3 rounded-lg border-l-4 border-red-500">
                      {getSecret(character)}
                    </p>
                  </div>
                </div>
                
                <div className="text-center mt-6">
                  <button
                    onClick={onClose}
                    className="btn-primary px-6 py-2"
                  >
                    {t('common.close')}
                  </button>
                </div>
              </div>
            </motion.div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};

const SecretRevealScreen: React.FC<SecretRevealScreenProps> = ({ round, characters }) => {
  const [selectedCharacter, setSelectedCharacter] = useState<Character | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [hasRevealedSecret, setHasRevealedSecret] = useState(false);
  const { t, language } = useLanguage();
  
  const title = language === 'bg' ? round.title_bg || round.title : round.title;
  const description = language === 'bg' ? round.description_bg || round.description : round.description;

  const getName = (character: Character) => language === 'bg' ? character.name_bg || character.name : character.name;
  const getDescription = (character: Character) => language === 'bg' ? character.description_bg || character.description : character.description;

  const handleCharacterSelect = (character: Character) => {
    if (hasRevealedSecret) return; // Prevent multiple selections
    
    setSelectedCharacter(character);
    setIsModalOpen(true);
    setHasRevealedSecret(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setSelectedCharacter(null);
  };

  return (
    <>
      <div className="mystery-paper p-6 rounded-lg">
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h2 className="text-2xl font-display font-bold text-center mb-6">{title}</h2>
          <p className="text-secondary-700 mb-8 italic text-center">{description}</p>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {characters.map((character, index) => {
              const isSelected = selectedCharacter?.character_id === character.character_id;
              const isDisabled = hasRevealedSecret && !isSelected;
              
              return (
                <motion.div
                  key={character.character_id}
                  className={`bg-white p-4 rounded shadow-sm border-2 transition-all duration-200 ${
                    isSelected 
                      ? 'border-green-500 bg-green-50' 
                      : isDisabled 
                        ? 'border-gray-200 bg-gray-50 cursor-not-allowed opacity-60' 
                        : 'border-transparent hover:border-primary-300 cursor-pointer'
                  }`}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.3, delay: index * 0.05 }}
                  onClick={() => !isDisabled && handleCharacterSelect(character)}
                >
                  <div className={`font-display font-medium text-lg mb-2 ${
                    isSelected ? 'text-green-700' : 'text-primary-700'
                  }`}>
                    {getName(character)}
                  </div>
                  <p className="text-secondary-600 text-sm mb-4">
                    {getDescription(character)}
                  </p>
                  <div className="flex justify-center">
                    {isSelected ? (
                      <button className="bg-green-500 text-white py-2 px-4 text-sm rounded cursor-default" disabled>
                        {t('game.secretRevealed')}
                      </button>
                    ) : isDisabled ? (
                      <button className="bg-gray-300 text-gray-500 py-2 px-4 text-sm rounded cursor-not-allowed" disabled>
                        {t('game.secretRevealed')}
                      </button>
                    ) : (
                      <button className="btn-primary py-2 px-4 text-sm">
                        {t('game.revealSecret')}
                      </button>
                    )}
                  </div>
                </motion.div>
              );
            })}
          </div>
        </motion.div>
      </div>

      {/* Secret Modal */}
      {selectedCharacter && (
        <SecretModal
          character={selectedCharacter}
          isOpen={isModalOpen}
          onClose={closeModal}
        />
      )}
    </>
  );
};

export default SecretRevealScreen; 