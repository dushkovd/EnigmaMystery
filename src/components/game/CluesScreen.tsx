import React from 'react';
// Animations removed for performance
import { Round, Clue } from '../../api/games';
import { useLanguage } from '../../context/LanguageContext';

interface CluesScreenProps {
  round: Round & { clues: Clue[] };
  startingClueNumber?: number;
}

const CluesScreen: React.FC<CluesScreenProps> = ({ round, startingClueNumber = 1 }) => {
  const { t, language } = useLanguage();
  
  const roundTitle = language === 'bg' ? round.title_bg || round.title : round.title;
  const roundDescription = language === 'bg' ? round.description_bg || round.description : round.description;

  return (
    <div className="mystery-paper p-6 rounded-lg">
      <div>
        <h2 className="text-2xl font-display font-bold text-center mb-6">
          <span className="mr-2">🔍</span>
          {t('game.round')} {roundTitle}
        </h2>
        
        <p className="text-secondary-700 mb-6 italic text-center">
          {roundDescription}
        </p>
        
        <div className="space-y-4">
          {round.clues.map((clue, index) => (
            <div
              key={clue.clue_id}
              className="clue-card"
            >
              <div className="flex">
                <div className="flex-shrink-0 mr-3">
                  <div className="w-8 h-8 bg-primary-100 text-primary-600 rounded-full flex items-center justify-center font-medium">
                    {startingClueNumber + index}
                  </div>
                </div>
                <div>
                  <p className="text-secondary-800">{language === 'bg' ? clue.content_bg || clue.content : clue.content}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default CluesScreen;