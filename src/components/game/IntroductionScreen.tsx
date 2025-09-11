import React from 'react';
// Animations removed for performance
import { GameWithDetails } from '../../api/games';
import { useLanguage } from '../../context/LanguageContext';
import { formatDuration } from '../../utils/durationFormatter';

interface IntroductionScreenProps {
  game: GameWithDetails;
  variationId?: number;
}

const IntroductionScreen: React.FC<IntroductionScreenProps> = ({ game, variationId }) => {
  const { t, language } = useLanguage();
  const variation = variationId 
    ? game.variations.find(v => v.variation_id === variationId)
    : game.variations[0];
  
  const title = language === 'bg' ? game.title_bg || game.title : game.title;
  const setting = language === 'bg' ? game.description_bg || game.description : game.description;
  const duration = formatDuration(game.duration || '', language);
  
  if (!variation) {
    return (
      <div className="mystery-paper p-6 rounded-lg">
        <div className="text-center text-red-600">
          {t('game.selectPlayersFirst')}
        </div>
      </div>
    );
  }
  
  const victim = language === 'bg' ? game.victim_bg || game.victim : game.victim;
  const location = language === 'bg' ? game.setting_bg || game.setting : game.setting;
  const numPlayers = variation.num_players;
  
  return (
    <div className="mystery-paper p-6 rounded-lg">
      <div>
        <h2 className="text-2xl font-display font-bold text-center mb-6">
          {t('game.scenario')} "{title}"
        </h2>
        
        <div className="mb-8">
          <h3 className="text-xl font-display font-semibold mb-3">{t('game.setting')}</h3>
          <p className="text-secondary-700 leading-relaxed">
            {setting}
          </p>
        </div>
        
        <div className="mb-4">
          <h3 className="text-xl font-display font-semibold mb-3 flex items-center">
            <span className="text-2xl mr-2">💀</span> {t('game.crime')}
          </h3>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="bg-white p-4 rounded shadow-sm">
              <div className="font-medium mb-1">{t('game.victim')}</div>
              <div>{victim || t('game.noVictimInfo')}</div>
            </div>
            
            <div className="bg-white p-4 rounded shadow-sm">
              <div className="font-medium mb-1">{language === 'bg' ? 'Локация' : 'Location'}</div>
              <div>{location || t('game.locationNotSpecified')}</div>
            </div>
            
            <div className="bg-white p-4 rounded shadow-sm">
              <div className="font-medium mb-1">{language === 'bg' ? 'Брой играчи' : 'Number of players'}</div>
              <div>{numPlayers || t('game.playersNotSpecified')}</div>
            </div>
            
            <div className="bg-white p-4 rounded shadow-sm">
              <div className="font-medium mb-1">{t('game.time')}</div>
              <div>{duration || t('game.durationNotSpecified')}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default IntroductionScreen;