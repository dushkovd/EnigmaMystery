import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X } from 'lucide-react';
import { Character } from '../../api/games';
import { useLanguage } from '../../context/LanguageContext';

interface CharactersScreenProps {
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
  const getConnection = (character: Character) => language === 'bg' ? character.connection_bg || character.connection : character.connection;
  const getCircumstances = (character: Character) => language === 'bg' ? character.circumstances_bg || character.circumstances : character.circumstances;

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
              className="bg-white rounded-lg shadow-xl max-w-lg w-full p-6 relative max-h-[90vh] overflow-y-auto"
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              <button
                onClick={onClose}
                className="absolute top-4 right-4 text-secondary-400 hover:text-secondary-600 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="mb-6">
                <h3 className="text-xl font-display font-bold text-secondary-800 mb-2">
                  {getName(character)}
                </h3>
                <div className="w-12 h-1 bg-primary-600 mb-4"></div>
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
                  <p className="text-xs text-red-600 mt-2 italic">
                    {language === 'bg' ? '⚠️ Не споделяйте с другите!' : '⚠️ Do not share with others!'}
                  </p>
                </div>
                
                {/* Public Information Section */}
                <div>
                  <h4 className="font-medium text-secondary-700 mb-2 flex items-center">
                    <span className="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                    {language === 'bg' ? 'Публична информация' : 'Public Information'}
                  </h4>
                  <div className="space-y-3">
                    {/* Connection Section */}
                    <div>
                      <h5 className="font-medium text-secondary-600 mb-1">
                        {t('game.connection')}
                      </h5>
                      <p className="text-secondary-600 leading-relaxed bg-green-50 p-3 rounded-lg border-l-4 border-green-500">
                        {getConnection(character)}
                      </p>
                    </div>
                    
                    {/* Circumstances Section */}
                    <div>
                      <h5 className="font-medium text-secondary-600 mb-1">
                        {t('game.circumstances')}
                      </h5>
                      <p className="text-secondary-600 leading-relaxed bg-green-50 p-3 rounded-lg border-l-4 border-green-500">
                        {getCircumstances(character)}
                      </p>
                    </div>
                  </div>
                  <p className="text-xs text-green-600 mt-2 italic">
                    {language === 'bg' ? '✅ Може да се сподели с другите' : '✅ Can be shared with others'}
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
            </motion.div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};

const CharactersScreen: React.FC<CharactersScreenProps> = ({ characters }) => {
  const [selectedCharacter, setSelectedCharacter] = useState<Character | null>(null);
  const [revealed, setRevealed] = useState<{ [id: string]: boolean }>({});
  const { t, language } = useLanguage();

  const openSecretModal = (character: Character) => {
    setSelectedCharacter(character);
    setRevealed(prev => ({ ...prev, [character.character_id]: true }));
  };

  const closeSecretModal = () => {
    setSelectedCharacter(null);
  };

  const getName = (character: Character) => language === 'bg' ? character.name_bg || character.name : character.name;
  const getDescription = (character: Character) => language === 'bg' ? character.description_bg || character.description : character.description;
  const getSecret = (character: Character) => language === 'bg' ? character.secret_bg || character.secret : character.secret;

  return (
    <>
      <div className="mystery-paper p-6 rounded-lg">
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h2 className="text-2xl font-display font-bold text-center mb-6">{t('game.characters')}</h2>
          
          <p className="text-secondary-700 mb-6 italic">
            {t('game.charactersDesc')}
          </p>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {characters.map((character, index) => (
              <motion.div
                key={character.character_id}
                className="bg-white p-4 rounded shadow-sm"
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3, delay: index * 0.05 }}
              >
                <div className="font-display font-medium text-lg mb-2">{getName(character)}</div>
                <p className="text-secondary-600 text-sm mb-4">{getDescription(character)}</p>
                <div className="flex justify-center">
                  {revealed[character.character_id] ? (
                    <button className="bg-green-500 text-white py-2 px-4 text-sm rounded cursor-default" disabled>
                      {t('game.secretRevealed')}
                    </button>
                  ) : (
                    <button
                      onClick={() => openSecretModal(character)}
                      className="btn-primary py-2 px-4 text-sm"
                    >
                      {t('game.revealSecret')}
                    </button>
                  )}
                </div>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>

      {/* Secret Modal */}
      <SecretModal
        character={selectedCharacter!}
        isOpen={!!selectedCharacter}
        onClose={closeSecretModal}
      />
    </>
  );
};

export default CharactersScreen;