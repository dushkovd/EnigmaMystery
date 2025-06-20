import React from 'react';
import { motion } from 'framer-motion';
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
      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <h2 className="text-2xl font-display font-bold text-center mb-6">
          <span className="mr-2">🔍</span>
          {t('game.round')} {roundTitle}
        </h2>
        
        <p className="text-secondary-700 mb-6 italic text-center">
          {roundDescription}
        </p>
        
        <div className="space-y-4">
          {round.clues.map((clue, index) => (
            <motion.div
              key={clue.clue_id}
              className="clue-card"
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.3, delay: index * 0.1 }}
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
            </motion.div>
          ))}
        </div>
      </motion.div>
    </div>
  );
};

export default CluesScreen;