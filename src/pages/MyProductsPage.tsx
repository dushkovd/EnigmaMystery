import React, { useEffect, useState } from 'react';
import { Navigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { BookOpen, Loader2 } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { getUserGames } from '../api/games';
import GameCard from '../components/ui/GameCard';
import type { Game } from '../api/games';
import { useLanguage } from '../context/LanguageContext';

const MyProductsPage: React.FC = () => {
  const { isAuthenticated, user } = useAuth();
  const [purchasedGames, setPurchasedGames] = useState<Game[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { t } = useLanguage();

  useEffect(() => {
    document.title = 'My Games | Enigma Mysteries';
    
    const fetchPurchasedGames = async () => {
      if (!user) return;
      
      try {
        setLoading(true);
        setError(null);
        const userGames = await getUserGames(user.id);
        console.log('User games in MyProductsPage:', userGames);
        setPurchasedGames(userGames);
      } catch (err) {
        console.error('Error fetching purchased games:', err);
        setError('Failed to load your games. Please try again later.');
      } finally {
        setLoading(false);
      }
    };

    fetchPurchasedGames();
  }, [user]);

  // Redirect to shop if not authenticated
  if (!isAuthenticated) {
    return <Navigate to="/checkout" />;
  }

  return (
    <div className="pt-24 pb-16">
      <div className="container-custom">
        <div className="max-w-4xl mx-auto">
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.4 }}
          >
            <div className="flex items-center justify-between mb-8">
              <h1 className="page-title">{t('myProducts.title')}</h1>
            </div>

            {loading ? (
              <div className="flex flex-col items-center justify-center py-12">
                <Loader2 className="w-8 h-8 text-primary-600 animate-spin mb-4" />
                <p className="text-secondary-600">{t('myProducts.loading')}</p>
              </div>
            ) : error ? (
              <div className="bg-red-50 border border-red-100 rounded-lg p-4 mb-8">
                <p className="text-red-600">{t('myProducts.loadError')}</p>
              </div>
            ) : purchasedGames.length > 0 ? (
              <>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {purchasedGames.map((game, index) => (
                    <motion.div
                      key={`${game.id}-${index}`}
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ duration: 0.4, delay: index * 0.1 }}
                    >
                      <GameCard game={game} purchased={true} />
                    </motion.div>
                  ))}
                </div>
              </>
            ) : (
              <div className="text-center py-12">
                <div className="mb-4">
                  <BookOpen className="w-12 h-12 text-secondary-400 mx-auto" />
                </div>
                <h3 className="text-xl font-display font-bold mb-2">{t('myProducts.noGames')}</h3>
                <p className="text-secondary-600 mb-6">
                  {t('myProducts.noGamesDesc')}
                </p>
                <a href="/shop" className="btn-primary">
                  {t('myProducts.browseGames')}
                </a>
              </div>
            )}
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export default MyProductsPage;