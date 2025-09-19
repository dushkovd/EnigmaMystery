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
  const [currentGameIndex, setCurrentGameIndex] = useState(0);
  const [howItWorksSlide, setHowItWorksSlide] = useState(0);

  // Static hero background image
  const heroImage = { src: '/hero-background.webp', fallback: '/hero-background.png' };

  useEffect(() => {
    document.title = t('home.pageTitle');
    if (!loading && games.length > 0) {
      const featured = games.find(game => game.featured) || games[0];
      setFeaturedGame(featured);
      setCurrentGameIndex(0);
    }
  }, [games, loading, t]);

  // Removed auto-rotate hero carousel

  // Auto-rotate How it works images
  const howItWorksImages = [
    '/game rules.webp',
    '/Characters.webp',
    '/Clues.webp',
    '/secret reveal.webp',
    '/Solution.webp',
    '/choose number of players.webp'
  ];

  // Manual navigation only for How it works images (auto-rotate disabled)

  const handleAddToCart = (game: Game) => {
    addToCart(game.id);
    navigate('/cart'); // Redirect to cart page after adding item
  };

  // Render price and cart actions for a given game
  const renderGameActions = (game: Game | null) => {
    if (!game) return null;
    const isInCart = cartGames.some(cartItem => cartItem.id === game.id);
    return (
      <div className="flex items-center justify-between pt-4">
        <span className="text-2xl font-bold">
          {hasDiscount(game) ? (
            <div className="flex flex-col">
              <span>{formatPrice(getEffectivePrice(game), language)}</span>
              <div className="flex items-center gap-2">
                <span className="text-sm text-gray-500 line-through">
                  {formatPrice(game.price, language)}
                </span>
                <span className="text-xs bg-red-100 text-red-600 px-2 py-1 rounded-full font-medium">
                  -{getDiscountPercentage(game)}%
                </span>
              </div>
            </div>
          ) : (
            formatPrice(game.price, language)
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
            onClick={() => handleAddToCart(game)}
            className="btn-primary flex items-center gap-2"
          >
            <ShoppingCart className="w-5 h-5" />
            {language === 'bg' ? 'Купи сега' : 'Buy Now'}
          </button>
        )}
      </div>
    );
  };

  const showPrevGame = () => {
    if (games.length === 0) return;
    setCurrentGameIndex((prev) => (prev - 1 + games.length) % games.length);
  };

  const showNextGame = () => {
    if (games.length === 0) return;
    setCurrentGameIndex((prev) => (prev + 1) % games.length);
  };

  // Handle swipe/drag gestures (mobile-friendly)
  const handleGameDragEnd = (_: unknown, info: { offset: { x: number }, velocity: { x: number } }) => {
    const swipeThreshold = 50; // pixels
    const velocityThreshold = 500; // px/s
    const offsetX = info?.offset?.x ?? 0;
    const velocityX = info?.velocity?.x ?? 0;

    if (offsetX <= -swipeThreshold || velocityX <= -velocityThreshold) {
      showNextGame();
      return;
    }
    if (offsetX >= swipeThreshold || velocityX >= velocityThreshold) {
      showPrevGame();
    }
  };

  // Swipe handling for How it works images
  const handleHowItWorksDragEnd = (_: unknown, info: { offset: { x: number }, velocity: { x: number } }) => {
    const swipeThreshold = 50;
    const velocityThreshold = 500;
    const offsetX = info?.offset?.x ?? 0;
    const velocityX = info?.velocity?.x ?? 0;

    if (offsetX <= -swipeThreshold || velocityX <= -velocityThreshold) {
      setHowItWorksSlide((prev) => (prev + 1) % howItWorksImages.length);
      return;
    }
    if (offsetX >= swipeThreshold || velocityX >= velocityThreshold) {
      setHowItWorksSlide((prev) => (prev - 1 + howItWorksImages.length) % howItWorksImages.length);
    }
  };

  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="relative min-h-screen flex items-center justify-center overflow-hidden">
        {/* Hero Background */}
        <div className="absolute inset-0 z-0">
          <div className="absolute inset-0">
          <picture>
              <source srcSet={heroImage.src} type="image/webp" />
            <img 
                src={heroImage.fallback}
              alt="Hero background"
              className="absolute inset-0 w-full h-full object-cover"
                style={{ filter: 'brightness(0.7)' }}
              loading="eager"
              fetchPriority="high"
            />
          </picture>
          </div>
          <div className="absolute inset-0 bg-gradient-to-b from-secondary-900/30 to-secondary-800/50"></div>
        </div>
        
        <div className="container-custom relative z-10 pt-20 sm:pt-24 md:pt-28 lg:pt-32 xl:pt-36">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 items-start lg:items-center">
            {/* Left Column - Hero Content */}
          <motion.div 
              className="text-center lg:text-left text-white px-4"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.7 }}
          >

              {/* Main Headline */}
              <h1 className="font-display text-4xl md:text-5xl lg:text-6xl font-bold mb-4 text-white leading-tight" 
                  style={{ textShadow: '0 0 40px rgba(0,0,0,0.9), 0 0 80px rgba(0,0,0,0.8), 0 0 120px rgba(0,0,0,0.7)' }}>
                <span className="text-yellow-400" 
                  style={{ textShadow: '0 0 40px rgba(0,0,0,0.9), 0 0 80px rgba(0,0,0,0.8), 0 0 120px rgba(0,0,0,0.7)' }}>
                  {language === 'bg' ? 'Мистериозни убийства' : 'Murder Mystery'}
                </span>{language === 'bg' ? '' : ' Games'}
              </h1>

              {/* Subtitle */}
              <p className="text-lg md:text-xl text-white/90 mb-4 leading-relaxed" 
                 style={{ textShadow: '0 0 30px rgba(0,0,0,0.9), 0 0 60px rgba(0,0,0,0.8), 0 0 90px rgba(0,0,0,0.7)' }}>
                {language === 'bg' 
                  ? 'Перфектната игра за събиране с приятели! Онлайн управлявана - достъпна веднага след покупка!'
                  : 'Perfect for friends gatherings! Online naviagtion, play immediately after purchase!'
                }
              </p>

              {/* Key Features Row */}
              <motion.div 
                className="flex flex-row justify-center lg:justify-start items-center gap-4 sm:gap-6 mb-4"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4, duration: 0.5 }}
              >
                {/* One Device */}
                <div className="flex items-center gap-1 sm:gap-2">
                  <svg className="w-4 h-4 sm:w-5 sm:h-5 text-primary-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                  </svg>
                  <span className="text-white font-medium text-sm sm:text-base">
                    {language === 'bg' ? 'Едно устройство' : 'One Device'}
                  </span>
                </div>

                {/* 4-10 Players */}
                <div className="flex items-center gap-1 sm:gap-2">
                  <Users className="w-4 h-4 sm:w-5 sm:h-5 text-primary-400 flex-shrink-0" />
                  <span className="text-white font-medium text-sm sm:text-base">
                    {language === 'bg' ? '4-10 играчи' : '4-10 Players'}
                  </span>
                </div>

                {/* 2 Hours Fun */}
                <div className="flex items-center gap-1 sm:gap-2">
                  <Clock className="w-4 h-4 sm:w-5 sm:h-5 text-primary-400 flex-shrink-0" />
                  <span className="text-white font-medium text-sm sm:text-base">
                    {language === 'bg' ? '2 часа забавление' : '2 Hours Fun'}
                  </span>
                </div>
              </motion.div>

            </motion.div>

            {/* Right Column - Featured Game Card */}
            {featuredGame && (
              <motion.div 
                className="flex justify-center lg:justify-end lg:mt-8"
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.3, duration: 0.7 }}
              >
                <div className="bg-white rounded-2xl shadow-2xl p-4 max-w-sm w-full mx-4 lg:mx-0">
                  {/* Featured Badge */}
                  <div className="bg-primary-600 text-white text-xs font-bold px-3 py-1 rounded-full inline-block mb-3">
                    {language === 'bg' ? 'ПРЕДЛОЖЕНА ИГРА' : 'FEATURED GAME'}
                  </div>

                  {/* Game Image */}
                  <div className="relative mb-3">
                    <Link to={`/preview/${featuredGame.game_id}`} className="block">
                      <img 
                        src={featuredGame.image} 
                        alt={language === 'bg' ? featuredGame.title_bg || featuredGame.title : featuredGame.title}
                        className="w-full h-48 object-cover rounded-lg shadow-lg cursor-pointer transition-transform duration-300 hover:scale-105"
                      />
                    </Link>
                    <img 
                      src="/money back guarantee.png" 
                      alt={language === 'bg' ? 'Гаранция за връщане на парите' : 'Money Back Guarantee'}
                      className="absolute -top-16 right-[-1.5rem] drop-shadow-lg pointer-events-none select-none"
                    />
                  </div>

                  {/* Game Details */}
                  <div className="space-y-1">
                    <Link to={`/preview/${featuredGame.game_id}`} className="block">
                      <h3 className="font-display text-xl font-bold text-gray-900 hover:text-primary-600 transition-colors cursor-pointer">
                        {language === 'bg' ? featuredGame?.title_bg || featuredGame?.title : featuredGame?.title}
                      </h3>
              </Link>
                    
                    


                    {/* Price and Buy Button */}
                    <div className="flex items-center justify-between pt-1">
                      <div className="text-2xl font-bold text-gray-900">
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
                      </div>
                      
                      {cartGames.some(game => game.id === featuredGame.id) ? (
                        <button
                          onClick={() => navigate('/cart')}
                          className="bg-primary-600 hover:bg-primary-700 text-white font-bold py-3 px-6 rounded-lg flex items-center gap-2 transition-all duration-300 transform hover:scale-105"
                        >
                          <ShoppingCart className="w-4 h-4" />
                          {t('shop.inCart')}
                        </button>
                      ) : (
                        <button
                          onClick={() => handleAddToCart(featuredGame)}
                          className="bg-primary-600 hover:bg-primary-700 text-white font-bold py-3 px-6 rounded-lg flex items-center gap-2 transition-all duration-300 transform hover:scale-105"
                        >
                          <ShoppingCart className="w-4 h-4" />
                          {language === 'bg' ? 'Купи сега' : 'Buy Now'}
                        </button>
                      )}
                    </div>
                  </div>
            </div>
          </motion.div>
            )}
          </div>
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

      {/* How It Works */}
      <section id="how-it-works" className="section bg-white">
        <div className="container-custom">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{language === 'bg' ? 'Как работи?' : 'How it works?'}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
            <p className="text-secondary-600 max-w-2xl mx-auto">
              {t('home.howItWorks.subtitle')}
            </p>
            <p className="text-secondary-700 max-w-3xl mx-auto mt-4">
              {language === 'bg'
                ? 'Уебсайтът ще ви напътства през цялата игра, нужно ви е само едно устройство за достъпване на указанията.'
                : 'The website will guide you through all the steps in the game using a single device — mobile phone, tablet, computer, or TV.'}
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

      {/* How it works images carousel */}
      {howItWorksImages.length > 0 && (
        <div className="mt-10">
          <div className="container-custom">
            <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{language === 'bg' ? 'Откъси от играта' : 'Game Previews'}</h2>
              <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
            </div>
            {/* iPhone-like frame */}
            <div className="max-w-sm md:max-w-md lg:max-w-lg mx-auto">
              <div className="relative mx-auto bg-black rounded-[2rem] shadow-2xl border-4 border-primary-600" style={{ width: '100%', aspectRatio: '9 / 18' }}>
                <div className="absolute top-0 left-1/2 -translate-x-1/2 w-20 h-3 bg-black rounded-b-xl"></div>
                <div className="absolute inset-[4px] bg-black rounded-[1.6rem] overflow-hidden">
                  <motion.img 
                    key={howItWorksSlide}
                    src={howItWorksImages[howItWorksSlide]}
                    alt="How it works preview"
                    className="absolute inset-0 w-full h-full object-contain bg-black cursor-grab active:cursor-grabbing"
                    loading="lazy"
                    drag="x"
                    dragConstraints={{ left: 0, right: 0 }}
                    dragElastic={0.2}
                    onDragEnd={handleHowItWorksDragEnd}
                  />
                </div>
              </div>
            </div>

            {/* Thumbnails */}
            <div className="mt-4 flex items-center justify-center gap-3 overflow-x-auto px-2">
              {howItWorksImages.map((src, idx) => (
                <button
                  key={idx}
                  onClick={() => setHowItWorksSlide(idx)}
                  className={`relative w-20 h-14 rounded-lg overflow-hidden border bg-white transition-all ${idx === howItWorksSlide ? 'ring-2 ring-primary-600' : 'opacity-70 hover:opacity-100'}`}
                  aria-label={`Preview slide ${idx + 1}`}
                >
                  <img src={src} alt={`Slide ${idx + 1}`} className="w-full h-full object-cover" />
                </button>
              ))}
            </div>

            {/* Dots indicator */}
            <div className="mt-3 flex justify-center gap-2">
              {howItWorksImages.map((_, idx) => (
                <span key={idx} className={`block h-2 rounded-full ${idx === howItWorksSlide ? 'bg-primary-600 w-8' : 'bg-secondary-300 w-2'}`}></span>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* Available games (carousel) */}
      {games && games.length > 0 && (
      <section id="featured" className="section bg-secondary-50">
        <div className="container-custom">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-display font-bold mb-4">{language === 'bg' ? 'Налични игри' : 'Available games'}</h2>
            <div className="w-24 h-1 bg-primary-600 mx-auto mb-6"></div>
          </div>

          <div className="relative">
            {/* Carousel body */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 lg:gap-8 items-center">
              {(() => { const game = games[currentGameIndex]; return (
                <>
                  <Link to={`/preview/${game.game_id}`} className="vintage-border block">
                    <div className="vintage-border-inner">
                      {loading ? (
                        <div className="flex items-center justify-center h-full">
                          <Loader2 className="w-8 h-8 text-primary-600 animate-spin" />
                        </div>
                      ) : error ? (
                        <div className="flex items-center justify-center h-full text-secondary-600">{error}</div>
                      ) : (
                        <motion.img 
                          src={game.image} 
                          alt={language === 'bg' ? game.title_bg || game.title : game.title}
                          className="w-full h-auto max-h-[450px] object-cover rounded shadow-lg cursor-pointer transition-transform duration-300 hover:scale-105"
                          initial={{ opacity: 0, scale: 0.98 }}
                          animate={{ opacity: 1, scale: 1 }}
                          transition={{ duration: 0.3 }}
                          drag="x"
                          dragConstraints={{ left: 0, right: 0 }}
                          dragElastic={0.2}
                          onDragEnd={handleGameDragEnd}
                        />
                      )}
                    </div>
                  </Link>

                  <motion.div 
                    className="space-y-4"
                    initial={{ opacity: 0, x: 20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.3 }}
                    drag="x"
                    dragConstraints={{ left: 0, right: 0 }}
                    dragElastic={0.2}
                    onDragEnd={handleGameDragEnd}
                  >
                    <Link to={`/preview/${game.game_id}`} className="block">
                      <h3 className="font-display text-3xl font-bold hover:text-primary-600 transition-colors cursor-pointer">
                        {language === 'bg' ? game?.title_bg || game?.title : game?.title}
                      </h3>
                    </Link>
                    <p className="text-lg italic text-primary-600">
                      {language === 'bg' ? game?.subtitle_bg || game?.subtitle : game?.subtitle}
                    </p>
                    <p className="text-secondary-600">
                      {language === 'bg' ? game?.description_bg || game?.description : game?.description}
                    </p>

                    <div className="grid grid-cols-2 gap-4">
                      <div className="flex items-center">
                        <Users className="w-5 h-5 text-primary-600 mr-2" />
                        <span>{game?.players}</span>
                      </div>
                      <div className="flex items-center">
                        <Clock className="w-5 h-5 text-primary-600 mr-2" />
                        <span>{formatDuration(game?.duration || '', language)}</span>
                      </div>
                      <div className="flex items-center">
                        <Award className="w-5 h-5 text-primary-600 mr-2" />
                        <span>
                          {t('common.difficulty')}{' '}
                          {language === 'bg' ? game?.difficulty_bg || game?.difficulty : game?.difficulty}
                        </span>
                      </div>
                    </div>

                    {renderGameActions(game)}
                  </motion.div>
                </>
              ); })()}
            </div>

            {/* Carousel controls */}
            {games.length > 1 && (
              <div className="flex items-center justify-center gap-4 mt-8">
                <button onClick={showPrevGame} className="btn-secondary px-4 py-2">{"<"}</button>
                <div className="text-sm text-secondary-600">
                  {currentGameIndex + 1} / {games.length}
                </div>
                <button onClick={showNextGame} className="btn-secondary px-4 py-2">{">"}</button>
              </div>
            )}
          </div>
        </div>
      </section>
      )}

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