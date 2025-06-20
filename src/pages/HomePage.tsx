import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Layers, Users, Clock, Award, Loader2, ShoppingCart } from 'lucide-react';
import { getActiveGames, Game } from '../api/games';
import { useLanguage } from '../context/LanguageContext';
import { useCart } from '../context/CartContext';
import { formatDuration } from '../utils/durationFormatter';
import { formatPrice } from '../utils/currencyFormatter';

const HomePage: React.FC = () => {
  const { t, language } = useLanguage();
  const { addToCart, cartGames } = useCart();
  const navigate = useNavigate();
  const [featuredGame, setFeaturedGame] = useState<Game | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    document.title = t('home.pageTitle');

    const fetchGames = async () => {
      try {
        const games = await getActiveGames();
        // Set the first game as featured or null if no games
        setFeaturedGame(games.length > 0 ? games[0] : null);
      } catch (error) {
        console.error('Error fetching games:', error);
        setFeaturedGame(null);
      } finally {
        setLoading(false);
      }
    };

    fetchGames();
  }, []);

  const handleAddToCart = (game: Game) => {
    addToCart(game.id);
    navigate('/cart'); // Redirect to cart page after adding item
  };

  // Only render price and add to cart button if we have a featured game
  const renderFeaturedGameActions = () => {
    if (!featuredGame) return null;

    const isInCart = cartGames.some(game => game.id === featuredGame.id);

    return (
      <div className="flex items-center space-x-4 pt-4">
        <span className="text-2xl font-bold">
          {formatPrice(featuredGame.price, language)}
        </span>
        <button
          onClick={() => handleAddToCart(featuredGame)}
          className={`btn-primary flex items-center gap-2 ${
            isInCart ? 'bg-secondary-500' : ''
          }`}
          disabled={isInCart}
        >
          <ShoppingCart className="w-5 h-5" />
          {isInCart ? t('shop.inCart') : t('shop.addToCart')}
        </button>
      </div>
    );
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-8 h-8 animate-spin mx-auto mb-4 text-primary-600" />
          <p className="text-lg text-gray-600">
            {language === 'bg' ? 'Зареждане на игри...' : 'Loading games...'}
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="relative min-h-screen flex items-center justify-center overflow-hidden">
        <div className="absolute inset-0 z-0">
          <div 
            className="absolute inset-0 bg-cover bg-center" 
            style={{ 
              backgroundImage: "url('https://images.pexels.com/photos/4153146/pexels-photo-4153146.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')",
              filter: 'brightness(0.4)'
            }}
          ></div>
          <div className="absolute inset-0 bg-gradient-to-b from-secondary-900/70 to-secondary-800/90 mix-blend-multiply"></div>
        </div>
        
        <div className="container-custom relative z-10 mt-20 md:mt-0">
          <motion.div 
            className="max-w-3xl mx-auto text-center text-white"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7 }}
          >
            <h1 className="font-display text-4xl md:text-5xl lg:text-6xl font-bold mb-4 text-white">
              {t('home.hero.title')} <span className="text-accent-400">{t('home.hero.titleHighlight')}</span> {t('home.hero.titleEnd')}
            </h1>
            <p className="text-lg md:text-xl text-secondary-200 mb-8 leading-relaxed">
              {t('home.hero.subtitle')}
            </p>
            <div className="flex flex-col sm:flex-row justify-center gap-4">
              <Link to="/shop" className="btn-accent text-lg">
                {t('home.hero.exploreGames')}
              </Link>
              <a href="#how-it-works" className="btn-outline border-white text-white hover:bg-white/10 text-lg">
                {t('home.hero.howItWorks')}
              </a>
            </div>
          </motion.div>
        </div>

        <div className="absolute bottom-8 left-0 right-0 flex justify-center">
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 1, duration: 1 }}
            className="animate-bounce"
          >
            <a href="#featured" className="text-white">
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
              </svg>
            </a>
          </motion.div>
        </div>
      </section>

      {/* Featured Game */}
      {featuredGame && (
      <section id="featured" className="section bg-secondary-50">
        <div className="container-custom">
            <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{t('home.featured.title')}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
            <p className="text-secondary-600 max-w-2xl mx-auto">
                {t('home.featured.desc')}
            </p>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 items-center">
            <div className="vintage-border">
              <div className="vintage-border-inner">
                  {loading ? (
                    <div className="flex items-center justify-center h-full">
                      <Loader2 className="w-8 h-8 text-primary-600 animate-spin" />
                    </div>
                  ) : error ? (
                    <div className="flex items-center justify-center h-full text-secondary-600">
                      {error}
                    </div>
                  ) : featuredGame ? (
                <motion.img 
                  src={featuredGame.image} 
                      alt={language === 'bg' ? featuredGame.title_bg || featuredGame.title : featuredGame.title}
                  className="w-full h-auto rounded shadow-lg"
                  initial={{ opacity: 0, scale: 0.9 }}
                  whileInView={{ opacity: 1, scale: 1 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5 }}
                />
                  ) : null}
              </div>
            </div>

            <motion.div 
              className="space-y-6"
              initial={{ opacity: 0, x: 20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5 }}
            >
                <span className="inline-block bg-primary-100 text-primary-600 px-3 py-1 text-sm font-medium rounded">{t('home.featured.badge')}</span>
                <h3 className="font-display text-3xl font-bold">
                  {language === 'bg' ? featuredGame?.title_bg || featuredGame?.title : featuredGame?.title}
                </h3>
                <p className="text-lg italic text-primary-600">
                  {language === 'bg' ? featuredGame?.subtitle_bg || featuredGame?.subtitle : featuredGame?.subtitle}
                </p>
                <p className="text-secondary-600">
                  {language === 'bg' ? featuredGame?.description_bg || featuredGame?.description : featuredGame?.description}
                </p>
              
              <div className="grid grid-cols-2 gap-4">
                <div className="flex items-center">
                  <Users className="w-5 h-5 text-primary-600 mr-2" />
                    <span>{language === 'bg' ? featuredGame?.players : featuredGame?.players}</span>
                </div>
                <div className="flex items-center">
                  <Clock className="w-5 h-5 text-primary-600 mr-2" />
                    <span>{formatDuration(featuredGame?.duration || '', language)}</span>
                </div>
                <div className="flex items-center">
                  <Award className="w-5 h-5 text-primary-600 mr-2" />
                    <span>
                      {t('common.difficulty')}{' '}
                      {language === 'bg' ? featuredGame?.difficulty_bg || featuredGame?.difficulty : featuredGame?.difficulty}
                    </span>
                </div>
              </div>
              
                {renderFeaturedGameActions()}
            </motion.div>
          </div>
        </div>
      </section>
      )}

      {/* How It Works */}
      <section id="how-it-works" className="section bg-white">
        <div className="container-custom">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{t('home.howItWorks.title')}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
            <p className="text-secondary-600 max-w-2xl mx-auto">
              {t('home.howItWorks.subtitle')}
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Step 1 */}
            <motion.div 
              className="text-center"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.1 }}
            >
              <div className="w-16 h-16 bg-primary-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg className="w-8 h-8 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-display font-bold mb-2">{t('home.howItWorks.step1.title')}</h3>
              <p className="text-secondary-600">
                {t('home.howItWorks.step1.desc')}
              </p>
            </motion.div>

            {/* Step 2 */}
            <motion.div 
              className="text-center"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.2 }}
            >
              <div className="w-16 h-16 bg-primary-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg className="w-8 h-8 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
              </div>
              <h3 className="text-xl font-display font-bold mb-2">{t('home.howItWorks.step2.title')}</h3>
              <p className="text-secondary-600">
                {t('home.howItWorks.step2.desc')}
              </p>
            </motion.div>

            {/* Step 3 */}
            <motion.div 
              className="text-center"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.3 }}
            >
              <div className="w-16 h-16 bg-primary-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg className="w-8 h-8 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-display font-bold mb-2">{t('home.howItWorks.step3.title')}</h3>
              <p className="text-secondary-600">
                {t('home.howItWorks.step3.desc')}
              </p>
            </motion.div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-16 relative overflow-hidden">
        <div className="absolute inset-0 z-0">
          <div 
            className="absolute inset-0 bg-cover bg-center" 
            style={{ 
              backgroundImage: "url('https://images.pexels.com/photos/301614/pexels-photo-301614.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')",
              filter: 'brightness(0.3)'
            }}
          ></div>
          <div className="absolute inset-0 bg-gradient-to-r from-secondary-800/90 to-secondary-900/70"></div>
        </div>
        
        <div className="container-custom relative z-10">
          <div className="max-w-3xl mx-auto text-center">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4 text-white">
              {t('home.cta.title')}
            </h2>
            <p className="text-lg text-secondary-200 mb-8">
              {t('home.cta.subtitle')}
            </p>
            <Link to="/shop" className="btn-accent text-lg">
              {t('home.cta.button')}
            </Link>
          </div>
        </div>
      </section>

      {/* Testimonials */}
      <section className="section bg-secondary-50">
        <div className="container-custom">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{t('home.testimonials.title')}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Testimonial 1 */}
            <motion.div 
              className="bg-white p-6 rounded-lg shadow-md"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.1 }}
            >
              <div className="flex items-center mb-4">
                <div className="mr-4">
                  <div className="w-12 h-12 bg-primary-200 rounded-full flex items-center justify-center">
                    <span className="font-display font-bold text-primary-700">JM</span>
                  </div>
                </div>
                <div>
                  <h4 className="font-bold">Jennifer M.</h4>
                  <div className="flex text-accent-400">
                    {[...Array(5)].map((_, i) => (
                      <svg key={i} className="w-4 h-4 fill-current" viewBox="0 0 24 24">
                        <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                      </svg>
                    ))}
                  </div>
                </div>
              </div>
              <p className="text-secondary-600">
                "Our book club decided to try something different, and the 'Death at Rosewood Estate' game was perfect! Easy to set up, and everyone got into character. We're already planning our next mystery night!"
              </p>
            </motion.div>

            {/* Testimonial 2 */}
            <motion.div 
              className="bg-white p-6 rounded-lg shadow-md"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.2 }}
            >
              <div className="flex items-center mb-4">
                <div className="mr-4">
                  <div className="w-12 h-12 bg-primary-200 rounded-full flex items-center justify-center">
                    <span className="font-display font-bold text-primary-700">TR</span>
                  </div>
                </div>
                <div>
                  <h4 className="font-bold">Thomas R.</h4>
                  <div className="flex text-accent-400">
                    {[...Array(5)].map((_, i) => (
                      <svg key={i} className="w-4 h-4 fill-current" viewBox="0 0 24 24">
                        <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                      </svg>
                    ))}
                  </div>
                </div>
              </div>
              <p className="text-secondary-600">
                "I hosted 'Betrayal at Blackrock Manor' for my birthday, and it was a hit! The clues were challenging but fair, and the solution surprised everyone. Worth every penny for a memorable evening!"
              </p>
            </motion.div>

            {/* Testimonial 3 */}
            <motion.div 
              className="bg-white p-6 rounded-lg shadow-md"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.3 }}
            >
              <div className="flex items-center mb-4">
                <div className="mr-4">
                  <div className="w-12 h-12 bg-primary-200 rounded-full flex items-center justify-center">
                    <span className="font-display font-bold text-primary-700">AL</span>
                  </div>
                </div>
                <div>
                  <h4 className="font-bold">Amelia L.</h4>
                  <div className="flex text-accent-400">
                    {[...Array(5)].map((_, i) => (
                      <svg key={i} className="w-4 h-4 fill-current" viewBox="0 0 24 24">
                        <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                      </svg>
                    ))}
                  </div>
                </div>
              </div>
              <p className="text-secondary-600">
                "These games have become a monthly tradition with our friends. The storytelling is excellent, and the digital format makes hosting so much easier. 'Murder on the Orient Starlight' was our favorite so far!"
              </p>
            </motion.div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default HomePage;