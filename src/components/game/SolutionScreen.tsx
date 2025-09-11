import React, { useState } from 'react';
// Animations removed for performance
import { AlertCircle } from 'lucide-react';
import { FinalReveal } from '../../api/games';
import { useLanguage } from '../../context/LanguageContext';

interface SolutionProps {
  solution: FinalReveal;
}

const SolutionScreen: React.FC<SolutionProps> = ({ solution }) => {
  const [revealed, setRevealed] = useState(false);
  const { t, language } = useLanguage();
  
  return (
    <div className="mystery-paper p-6 rounded-lg">
      <div>
        <h2 className="text-2xl font-display font-bold text-center mb-6">
          <span className="mr-2">🧩</span>
          {t('game.solution')}
        </h2>

        {!revealed ? (
          <div className="text-center">
            <div className="mb-6 p-4 bg-warning-50 border border-warning-200 rounded-md inline-block mx-auto">
              <div className="flex items-center">
                <AlertCircle className="w-5 h-5 text-warning-500 mr-2" />
                <p className="text-warning-700">
                  {t('game.solutionWarning')}
                </p>
              </div>
            </div>
            
            <p className="text-secondary-600 mb-8">
              {t('game.solutionWarningDesc')}
            </p>
            
            <button 
              onClick={() => setRevealed(true)}
              className="btn-primary"
            >
              {t('game.revealSolution')}
            </button>
          </div>
        ) : (
          <div>
            <div className="bg-primary-50 border-2 border-primary-100 p-4 rounded-md mb-6">
              <h3 className="font-display text-xl font-bold text-primary-700 mb-2">
                {t('game.murderer')}
              </h3>
              <p className="text-primary-800 font-bold text-lg">{language === 'bg' ? solution.murderer_bg || solution.murderer : solution.murderer}</p>
            </div>

            <div className="bg-green-50 border-2 border-green-100 p-4 rounded-md mb-6">
              <h3 className="font-display text-xl font-bold text-green-700 mb-2">
                {t('game.motive')}
              </h3>
              <p className="text-green-800">{language === 'bg' ? solution.motive_bg || solution.motive : solution.motive}</p>
            </div>

            <div className="bg-blue-50 border-2 border-blue-100 p-4 rounded-md">
              <h3 className="font-display text-xl font-bold text-blue-700 mb-2">
                {t('game.weapon')}
              </h3>
              <p className="text-blue-800">{language === 'bg' ? solution.weapon_bg || solution.weapon : solution.weapon}</p>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default SolutionScreen;