import React, { useState } from 'react';
// Animations removed for performance
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
    <>
      {isOpen && (
        <>
          {/* Backdrop */}
          <div
            className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
            onClick={onClose}
          >
            {/* Modal */}
            <div
              className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
              onClick={(e) => e.stopPropagation()}
            >
              <div className="p-6">
                <h3 className="text-2xl font-display font-bold mb-4">
                  {getName(character)}
                </h3>
                <div className="bg-red-50 border-l-4 border-red-500 p-4 rounded">
                  <p className="text-secondary-700 leading-relaxed">
                    {getSecret(character)}
                  </p>
                </div>
                <div className="text-right mt-6">
                  <button className="btn-primary" onClick={onClose}>{t('common.close')}</button>
                </div>
              </div>
            </div>
          </div>
        </>
      )}
    </>
  );
};

const SecretRevealScreen: React.FC<SecretRevealScreenProps> = ({ round, characters }) => {
  const { t, language } = useLanguage();
  const [selectedCharacter, setSelectedCharacter] = useState<Character | null>(null);

  const getName = (character: Character) => language === 'bg' ? character.name_bg || character.name : character.name;

  return (
    <div className="mystery-paper p-6 rounded-lg">
      <h2 className="text-2xl font-display font-bold text-center mb-6">{t('game.secretReveal')}</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {characters.map((character) => (
          <div key={character.character_id} className="bg-white p-4 rounded shadow-sm flex items-center justify-between">
            <div className="font-medium">{getName(character)}</div>
            <button className="btn-primary" onClick={() => setSelectedCharacter(character)}>
              {t('game.viewSecret')}
            </button>
          </div>
        ))}
      </div>

      <SecretModal character={selectedCharacter!} isOpen={!!selectedCharacter} onClose={() => setSelectedCharacter(null)} />
    </div>
  );
};

export default SecretRevealScreen; 