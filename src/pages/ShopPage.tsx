import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import GameCard from '../components/ui/GameCard';
import { getActiveGames, Game } from '../api/games';
import { useLanguage } from '../context/LanguageContext';

const ShopPage: React.FC = () => {
  const [games, setGames] = useState<Game[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { t, language } = useLanguage();

  useEffect(() => {
    document.title = `${t('nav.shop')} | Enigma Mysteries`;
    
    const fetchGames = async () => {
      try {
        setLoading(true);
        const activeGames = await getActiveGames();
        setGames(activeGames);
      } catch (err) {
        setError('Failed to load games. Please try again later.');
        console.error('Error fetching games:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchGames();
  }, []);

  return (
    <>
      {/* Hero Section */}
      <section className="relative pt-32 pb-16 md:py-32 bg-secondary-800">
        <div className="absolute inset-0 z-0">
          <div 
            className="absolute inset-0 bg-cover bg-center opacity-20" 
            style={{ 
              backgroundImage: "url('https://images.pexels.com/photos/3772173/pexels-photo-3772173.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')"
            }}
          ></div>
        </div>
        
        <div className="container-custom relative z-10">
          <motion.div 
            className="max-w-2xl"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <h1 className="font-display text-3xl md:text-4xl lg:text-5xl font-bold text-white mb-4">
              {t('shop.hero.title')}
            </h1>
            <p className="text-secondary-200 text-lg">
              {t('shop.hero.subtitle')}
            </p>
          </motion.div>
        </div>
      </section>

      {/* Games Grid */}
      <section className="section bg-secondary-50">
        <div className="container-custom">
          <div className="mb-10">
            <div className="flex items-center justify-between">
              <h2 className="text-2xl font-display font-bold">{t('shop.availableGames')}</h2>
              {!loading && (
              <div className="text-sm text-secondary-600">
                {t('shop.showingAll')} {games.length} {t('shop.games')}
              </div>
              )}
            </div>
            <div className="w-16 h-1 bg-primary-600 mt-2 mb-2"></div>
          </div>

          {loading ? (
            <div className="flex justify-center items-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
          ) : error ? (
            <div className="text-center py-12">
              <p className="text-red-600">{t('common.error')}</p>
              <button 
                onClick={() => window.location.reload()} 
                className="mt-4 px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 transition-colors"
              >
                {t('common.tryAgain') || 'Try Again'}
              </button>
            </div>
          ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {games.map((game, index) => (
              <motion.div
                  key={game.game_id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.4, delay: index * 0.1 }}
              >
                <GameCard game={game} />
              </motion.div>
            ))}
          </div>
          )}
        </div>
      </section>

      {/* FAQ Section */}
      <section className="section bg-white">
        <div className="container-custom">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{t('shop.faq.title')}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
          </div>

          <div className="max-w-3xl mx-auto">
            <div className="space-y-6">
              <div className="bg-secondary-50 p-6 rounded-lg">
                <h3 className="text-xl font-display font-bold mb-2">{t('shop.faq.players.question')}</h3>
                <p className="text-secondary-600">
                  {t('shop.faq.players.answer')}
                </p>
              </div>
              
              <div className="bg-secondary-50 p-6 rounded-lg">
                <h3 className="text-xl font-display font-bold mb-2">{t('shop.faq.duration.question')}</h3>
                <p className="text-secondary-600">
                  {t('shop.faq.duration.answer')}
                </p>
              </div>
              
              <div className="bg-secondary-50 p-6 rounded-lg">
                <h3 className="text-xl font-display font-bold mb-2">{t('shop.faq.replay.question')}</h3>
                <p className="text-secondary-600">
                  {t('shop.faq.replay.answer')}
                </p>
              </div>
              
              <div className="bg-secondary-50 p-6 rounded-lg">
                <h3 className="text-xl font-display font-bold mb-2">{t('shop.faq.print.question')}</h3>
                <p className="text-secondary-600">
                  {t('shop.faq.print.answer')}
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default ShopPage;