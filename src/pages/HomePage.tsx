import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Users, Clock, Award, Loader2, ShoppingCart } from 'lucide-react';
import { Game } from '../api/games';
import { useLanguage } from '../context/LanguageContext';
import { useCart } from '../context/CartContext';
import { useGames } from '../context/GameContext';
import { formatDuration } from '../utils/durationFormatter';
import { formatPrice, getEffectivePrice, hasDiscount, getDiscountPercentage } from '../utils/currencyFormatter';

const HomePage: React.FC = () => {
  const { t, language } = useLanguage();
  const { addToCart, cartGames } = useCart();
  const navigate = useNavigate();
  const { games, loading, error } = useGames();
  const [featuredGame, setFeaturedGame] = useState<Game | null>(null);

  useEffect(() => {
    document.title = t('home.pageTitle');
    if (!loading && games.length > 0) {
      const featured = games.find(game => game.featured) || games[0];
      setFeaturedGame(featured);
    }
  }, [games, loading, t]);

  const handleAddToCart = (game: Game) => {
    addToCart(game.id);
    navigate('/cart'); // Redirect to cart page after adding item
  };

  // Only render price and add to cart button if we have a featured game
  const renderFeaturedGameActions = () => {
    if (!featuredGame) return null;

    const isInCart = cartGames.some(game => game.id === featuredGame.id);

    return (
      <div className="flex items-center justify-between pt-4">
        <span className="text-2xl font-bold">
          {hasDiscount(featuredGame) ? (
            <div className="flex flex-col">
              <span>{formatPrice(getEffectivePrice(featuredGame), language)}</span>
              <div className="flex items-center gap-2">
                <span className="text-sm text-gray-500 line-through">
                  {formatPrice(featuredGame.price, language)}
                </span>
                <span className="text-xs bg-red-100 text-red-600 px-2 py-1 rounded-full font-medium">
                  -{getDiscountPercentage(featuredGame)}%
                </span>
              </div>
            </div>
          ) : (
            formatPrice(featuredGame.price, language)
          )}
        </span>
        {isInCart ? (
          <button
            onClick={() => navigate('/cart')}
            className="btn-primary flex items-center gap-2"
          >
            <ShoppingCart className="w-5 h-5" />
            {t('shop.inCart')}
          </button>
        ) : (
          <button
            onClick={() => handleAddToCart(featuredGame)}
            className="btn-primary flex items-center gap-2"
          >
            <ShoppingCart className="w-5 h-5" />
            {t('shop.addToCart')}
          </button>
        )}
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
          {/* Try both approaches: img tag and CSS background */}
          <img 
            src="/hero-background.png"
            alt="Hero background"
            className="absolute inset-0 w-full h-full object-cover"
            style={{ filter: 'brightness(1.5)' }}
          />
          <div className="absolute inset-0 bg-gradient-to-b from-secondary-900/40 to-secondary-800/60 mix-blend-multiply"></div>
        </div>
        
        <div className="container-custom relative z-10 mt-20 md:mt-0">
          <motion.div 
            className="max-w-3xl mx-auto text-center text-white"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7 }}
          >
                                      <h1 className="font-display text-4xl md:text-5xl lg:text-6xl font-bold mb-4 text-white" style={{ textShadow: '0 0 40px rgba(0,0,0,0.9), 0 0 80px rgba(0,0,0,0.8), 0 0 120px rgba(0,0,0,0.7)' }}>
               {t('home.hero.title')} <span className="text-accent-400" style={{ textShadow: '0 0 40px rgba(0,0,0,0.9), 0 0 80px rgba(0,0,0,0.8), 0 0 120px rgba(0,0,0,0.7)' }}>{t('home.hero.titleHighlight')}</span> {t('home.hero.titleEnd')}
              </h1>
                                      <p className="text-lg md:text-xl text-secondary-200 mb-8 leading-relaxed" style={{ textShadow: '0 0 30px rgba(0,0,0,0.9), 0 0 60px rgba(0,0,0,0.8), 0 0 90px rgba(0,0,0,0.7)' }}>
               {t('home.hero.subtitle')}
              </p>
            <div className="flex flex-col sm:flex-row justify-center gap-4">
              <Link to="/shop" className="btn-accent text-lg" state={{ preventScroll: true }}>
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

      {/* Key Features Section */}
      <section className="py-16 bg-secondary-50">
        <div className="container-custom">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4 text-primary-800">
              {language === 'bg' ? 'Какво Представлява?' : 'What It\'s All About?'}
            </h2>
            <div className="w-24 h-1 bg-accent-500 mx-auto mb-6"></div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                         {/* Feature 1: One Device Controls Everything */}
             <motion.div 
               className="text-center p-8 rounded-2xl shadow-lg border border-accent-200 hover:shadow-xl transition-shadow duration-300 relative overflow-hidden"
               initial={{ opacity: 0, y: 20 }}
               whileInView={{ opacity: 1, y: 0 }}
               viewport={{ once: true }}
               transition={{ duration: 0.5, delay: 0.1 }}
             >
               {/* Background Image */}
               <div className="absolute inset-0 z-0">
                 <img 
                   src="/one_phone.png"
                   alt="Feature background"
                   className="w-full h-full object-cover"
                   style={{ filter: 'brightness(0.3)' }}
                 />
                 <div className="absolute inset-0 bg-white/20"></div>
               </div>
               
               {/* Content */}
               <div className="relative z-10">
                                   <div className="w-20 h-20 bg-accent-100 rounded-2xl flex items-center justify-center mx-auto mb-6">
                    <svg className="w-10 h-10 text-accent-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                    </svg>
                  </div>
                                    <h3 className="text-3xl font-display font-bold mb-3 text-accent-400">
                     {language === 'bg' ? 'Едно устройство' : 'One Device'}
                   </h3>
                  <p className="text-white leading-relaxed">
                    {language === 'bg' ? 'Използвайте един телефон, таблет или компютър, който да ви навигира през цялата игра.' : 'Use any phone, tablet, or computer to guide the entire game. No printing, no setup hassle - just start and play.'}
                  </p>
               </div>
             </motion.div>

                         {/* Feature 2: Perfect for Groups */}
             <motion.div 
               className="text-center p-8 rounded-2xl shadow-lg border border-accent-200 hover:shadow-xl transition-shadow duration-300 relative overflow-hidden"
               initial={{ opacity: 0, y: 20 }}
               whileInView={{ opacity: 1, y: 0 }}
               viewport={{ once: true }}
               transition={{ duration: 0.5, delay: 0.2 }}
             >
               {/* Background Image */}
               <div className="absolute inset-0 z-0">
                 <img 
                   src="/groups.png"
                   alt="Feature background"
                   className="w-full h-full object-cover"
                   style={{ filter: 'brightness(0.3)' }}
                 />
                 <div className="absolute inset-0 bg-white/20"></div>
               </div>
               
               {/* Content */}
               <div className="relative z-10">
                                   <div className="w-20 h-20 bg-accent-100 rounded-2xl flex items-center justify-center mx-auto mb-6">
                    <svg className="w-10 h-10 text-accent-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                  </div>
                                    <h3 className="text-3xl font-display font-bold mb-3 text-accent-400">
                     {language === 'bg' ? '4 - 10 играчи' : '4 to 10 people'}
                   </h3>
                  <p className="text-white leading-relaxed">
                    {language === 'bg' ? 'Различни вариации на игрите за компании от 4 до 10 души, събрани на живо.' : 'Designed for 4-10 players gathering in person. Each player gets a unique character with secrets and motives.'}
                  </p>
               </div>
             </motion.div>

                         {/* Feature 3: 2 Hours of Entertainment */}
             <motion.div 
               className="text-center p-8 rounded-2xl shadow-lg border border-accent-200 hover:shadow-xl transition-shadow duration-300 relative overflow-hidden"
               initial={{ opacity: 0, y: 20 }}
               whileInView={{ opacity: 1, y: 0 }}
               viewport={{ once: true }}
               transition={{ duration: 0.5, delay: 0.3 }}
             >
               {/* Background Image */}
               <div className="absolute inset-0 z-0">
                 <img 
                   src="/fun.png"
                   alt="Feature background"
                   className="w-full h-full object-cover"
                   style={{ filter: 'brightness(0.3)' }}
                 />
                 <div className="absolute inset-0 bg-white/20"></div>
               </div>
               
               {/* Content */}
               <div className="relative z-10">
                                   <div className="w-20 h-20 bg-accent-100 rounded-2xl flex items-center justify-center mx-auto mb-6">
                    <svg className="w-10 h-10 text-accent-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                                    <h3 className="text-3xl font-display font-bold mb-3 text-accent-400">
                     {language === 'bg' ? 'Два часа забавление' : '2 Hours of Entertainment'}
                   </h3>
                  <p className="text-white leading-relaxed">
                    {language === 'bg' ? 'Всяка игра осигурява между 1 и 3 часа забавление в решаване на мистерии.' : 'Each game provides between 1 to 3 hours of immersive mystery-solving fun, perfect for dinner parties or game nights.'}
                  </p>
               </div>
             </motion.div>
          </div>
        </div>
      </section>

      {/* Featured Game */}
      {featuredGame && (
      <section id="featured" className="section bg-secondary-50">
        <div className="container-custom">
            <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{t('home.featured.title')}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 lg:gap-8 items-center">
            <Link to={`/preview/${featuredGame.game_id}`} className="vintage-border block">
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
                  className="w-full h-auto max-h-[450px] object-cover rounded shadow-lg cursor-pointer transition-transform duration-300 hover:scale-105"
                  initial={{ opacity: 0, scale: 0.9 }}
                  whileInView={{ opacity: 1, scale: 1 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5 }}
                />
                  ) : null}
              </div>
            </Link>

            <motion.div 
              className="space-y-4"
              initial={{ opacity: 0, x: 20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5 }}
            >
                <Link to={`/preview/${featuredGame.game_id}`} className="block">
                  <h3 className="font-display text-3xl font-bold hover:text-primary-600 transition-colors cursor-pointer">
                    {language === 'bg' ? featuredGame?.title_bg || featuredGame?.title : featuredGame?.title}
                  </h3>
                </Link>
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
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
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
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
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

      {/* Advantages Section */}
      <section className="section bg-white">
        <div className="container-custom">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{t('home.advantages.title')}</h2>
            <div className="w-24 h-1 bg-accent-500 mx-auto mb-6"></div>
            <p className="text-secondary-600 max-w-2xl mx-auto">
              {t('home.advantages.subtitle')}
            </p>
          </div>

          <div className="space-y-8">
            {/* Advantage 1: No Passive Roles */}
            <motion.div 
              className="flex flex-col lg:flex-row items-center gap-8 p-8 bg-accent-50 rounded-2xl border border-accent-200"
              initial={{ opacity: 0, x: -20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: 0.1 }}
            >
              <div className="flex-shrink-0">
                <div className="w-20 h-20 bg-accent-500 rounded-2xl flex items-center justify-center shadow-lg">
                  <svg className="w-10 h-10 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                  </svg>
                </div>
              </div>
              <div className="text-center lg:text-left">
                <h3 className="text-2xl font-display font-bold mb-3 text-black">{t('home.advantages.noPassive.title')}</h3>
                <p className="text-secondary-700 text-lg leading-relaxed">
                  {t('home.advantages.noPassive.desc')}
                </p>
              </div>
            </motion.div>

            {/* Advantage 2: Amnesiac Murderer */}
            <motion.div 
              className="flex flex-col lg:flex-row items-center gap-8 p-8 bg-accent-50 rounded-2xl border border-accent-200"
              initial={{ opacity: 0, x: 20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: 0.2 }}
            >
              <div className="flex-shrink-0">
                <div className="w-20 h-20 bg-accent-500 rounded-2xl flex items-center justify-center shadow-lg">
                  <svg className="w-10 h-10 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
              </div>
              <div className="text-center lg:text-left">
                <h3 className="text-2xl font-display font-bold mb-3 text-black">{t('home.advantages.amnesia.title')}</h3>
                <p className="text-secondary-700 text-lg leading-relaxed">
                  {t('home.advantages.amnesia.desc')}
                </p>
              </div>
            </motion.div>

            {/* Advantage 3: Digital Convenience */}
            <motion.div 
              className="flex flex-col lg:flex-row items-center gap-8 p-8 bg-accent-50 rounded-2xl border border-accent-200"
              initial={{ opacity: 0, x: -20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: 0.3 }}
            >
              <div className="flex-shrink-0">
                <div className="w-20 h-20 bg-accent-500 rounded-2xl flex items-center justify-center shadow-lg">
                  <svg className="w-10 h-10 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                  </svg>
                </div>
              </div>
              <div className="text-center lg:text-left">
                <h3 className="text-2xl font-display font-bold mb-3 text-black">{t('home.advantages.digital.title')}</h3>
                <p className="text-secondary-700 text-lg leading-relaxed">
                  {t('home.advantages.digital.desc')}
                </p>
              </div>
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

          {language === 'bg' ? (
            /* Bulgarian Reviews */
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {/* Bulgarian Testimonial 1 */}
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
                      <span className="font-display font-bold text-primary-700">МП</span>
                    </div>
                  </div>
                  <div>
                    <h4 className="font-bold">Мария</h4>
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
                  "С приятелите ми решихме да изпробваме мистерията от Ориент Експрес, която не ни разочарова! Доста се вживяхме в играта, доста поспорихме и накрая почти познахме убиеца..."
                </p>
              </motion.div>

              {/* Bulgarian Testimonial 2 */}
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
                      <span className="font-display font-bold text-primary-700">ТР</span>
                    </div>
                  </div>
                  <div>
                    <h4 className="font-bold">Тодор</h4>
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
                  "Хареса ми, че не беше нужно да губим време в сетъпване и четене на правила, а всичко беше готово и директно започнахме играта."
                </p>
              </motion.div>

              {/* Bulgarian Testimonial 3 */}
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
                      <span className="font-display font-bold text-primary-700">АЛ</span>
                    </div>
                  </div>
                  <div>
                    <h4 className="font-bold">Наско</h4>
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
                  "Като за по няма и 5 лв на човек, останахме прилично доволни от двучасовото занимание!"
                </p>
              </motion.div>
            </div>
          ) : (
            /* English Reviews */
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {/* English Testimonial 1 */}
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

              {/* English Testimonial 2 */}
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
                  "I hosted 'Murder on the Midnight Express' for my birthday, and it was a hit! The clues were challenging but fair, and the solution surprised everyone. Worth every penny for a memorable evening!"
                </p>
              </motion.div>

              {/* English Testimonial 3 */}
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
                  "These games have become a monthly tradition with our friends. The storytelling is excellent, and the digital format makes hosting so much easier. 'Death at Rosewood Estate' was our favorite so far!"
                </p>
              </motion.div>
            </div>
          )}
        </div>
      </section>
    </div>
  );
};

export default HomePage;