import React, { useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ShoppingCart, Plus, Minus, Trash2, ArrowLeft } from 'lucide-react';
import { useCart } from '../context/CartContext';
import { useLanguage } from '../context/LanguageContext';
import { formatDuration } from '../utils/durationFormatter';
import { formatPrice } from '../utils/currencyFormatter';

const CartPage: React.FC = () => {
  const { cartGames, items, addToCart, removeFromCart, clearCart, totalPrice, totalItems } = useCart();
  const { t, language } = useLanguage();
  const navigate = useNavigate();

  useEffect(() => {
    document.title = `${t('cart.title')} | Enigma Mysteries`;
    window.scrollTo(0, 0);
  }, [t]);

  const getItemQuantity = (gameId: string) => {
    const item = items.find(item => item.gameId === gameId);
    return item ? item.quantity : 0;
  };

  const removeItemCompletely = (gameId: string) => {
    const item = items.find(item => item.gameId === gameId);
    if (item) {
      // Remove all quantities of this item
      for (let i = 0; i < item.quantity; i++) {
        removeFromCart(gameId);
      }
    }
  };

  if (cartGames.length === 0) {
    return (
      <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
        <div className="container-custom">
          <div className="max-w-4xl mx-auto">
            <motion.div
              className="text-center py-16"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5 }}
            >
              <div className="mb-6">
                <ShoppingCart className="w-16 h-16 text-secondary-400 mx-auto" />
              </div>
              <h1 className="text-3xl font-display font-bold mb-4">{t('cart.empty.title')}</h1>
              <p className="text-secondary-600 mb-8 max-w-md mx-auto">
                {t('cart.empty.description')}
              </p>
              <Link to="/shop" className="btn-primary">
                {t('cart.empty.browseGames')}
              </Link>
            </motion.div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom">
        <div className="max-w-4xl mx-auto">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            {/* Header */}
            <div className="flex items-center justify-between mb-8">
              <div className="flex items-center">
                <Link 
                  to="/shop" 
                  className="mr-4 p-2 rounded-full hover:bg-white transition-colors"
                >
                  <ArrowLeft className="w-5 h-5 text-secondary-600" />
                </Link>
                <div>
                  <h1 className="text-3xl font-display font-bold">{t('cart.title')}</h1>
                  <p className="text-secondary-600">
                    {totalItems} {totalItems === 1 ? t('cart.item') : t('cart.items')}
                  </p>
                </div>
              </div>
              
              {cartGames.length > 0 && (
                <button
                  onClick={clearCart}
                  className="text-error-600 hover:text-error-700 text-sm font-medium transition-colors"
                >
                  {t('cart.clearAll')}
                </button>
              )}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
              {/* Cart Items */}
              <div className="lg:col-span-2">
                <div className="bg-white rounded-lg shadow-md overflow-hidden">
                  <div className="p-6 border-b border-secondary-100">
                    <h2 className="text-xl font-display font-bold">{t('cart.items')}</h2>
                  </div>
                  
                  <div className="divide-y divide-secondary-100">
                    {cartGames.map((game, index) => {
                      const quantity = getItemQuantity(game.id);
                      const title = language === 'bg' ? game.title_bg || game.title : game.title;
                      const subtitle = language === 'bg' ? game.subtitle_bg || game.subtitle : game.subtitle;
                      const difficulty = language === 'bg' ? game.difficulty_bg || game.difficulty : game.difficulty;
                      const players = language === 'bg' ? game.players : game.players;
                      const duration = formatDuration(game.duration || '', language);
                      
                      return (
                        <motion.div
                          key={game.id}
                          className="p-6"
                          initial={{ opacity: 0, y: 10 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ duration: 0.3, delay: index * 0.1 }}
                        >
                          <div className="flex flex-col sm:flex-row sm:items-start sm:space-x-4 space-y-2 sm:space-y-0 w-full">
                            {/* Game Image */}
                            <div className="hidden sm:block w-20 h-20 rounded overflow-hidden flex-shrink-0 mx-auto sm:mx-0">
                              <img 
                                src={game.image} 
                                alt={title}
                                className="w-full h-full object-cover"
                              />
                            </div>
                            {/* Game Details and Properties + Price/Remove */}
                            <div className="flex flex-col flex-grow justify-between w-full">
                              <h3 className="font-display text-lg font-bold text-secondary-800 mb-1 text-left">
                                {title}
                              </h3>
                              <p className="text-sm text-primary-600 italic mb-2 text-left">
                                {subtitle}
                              </p>
                              <div className="flex flex-row justify-between items-start w-full">
                                {/* Game Properties (left) */}
                                <div className="flex flex-col space-y-2">
                                  <span className="flex items-center text-base text-secondary-700">
                                    <svg className="w-6 h-6 mr-2 text-primary-600" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-3-3.87"/><path d="M7 21v-2a4 4 0 0 1 3-3.87"/><circle cx="12" cy="7" r="4"/><path d="M5.5 17a4.5 4.5 0 0 1 13 0"/></svg>
                                    {players}
                                  </span>
                                  <span className="flex items-center text-base text-secondary-700">
                                    <svg className="w-6 h-6 mr-2 text-primary-600" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                    {duration}
                                  </span>
                                  <span className="flex items-center text-base text-secondary-700">
                                    <svg className="w-7 h-7 mr-2 text-primary-600" fill="currentColor" viewBox="0 0 64 40"><path d="M2 38A30 30 0 0 1 62 38" stroke="currentColor" strokeWidth="4" fill="none"/><rect x="30" y="20" width="4" height="14" rx="2" fill="currentColor"/><circle cx="32" cy="34" r="3" fill="#fff"/></svg>
                                    {difficulty}
                                  </span>
                                </div>
                                {/* Price and Remove (right) */}
                                <div className="flex flex-col items-end justify-between min-w-[80px] ml-4">
                                  <div className="flex items-center justify-between gap-4">
                                    <button
                                      onClick={() => removeItemCompletely(game.id)}
                                      className="text-red-500 hover:text-red-700 transition-colors"
                                      aria-label={t('cart.removeItem')}
                                    >
                                      <Trash2 className="w-5 h-5" />
                                    </button>
                                    <div className="text-xl font-bold text-secondary-800 text-right">
                                      {formatPrice(game.price, language)}
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </motion.div>
                      );
                    })}
                  </div>
                </div>
              </div>
              
              {/* Order Summary */}
              <div className="lg:col-span-1">
                <div className="bg-white rounded-lg shadow-md sticky top-24">
                  <div className="p-6 border-b border-secondary-100">
                    <h2 className="text-xl font-display font-bold">{t('cart.orderSummary')}</h2>
                  </div>
                  
                  <div className="p-6">
                    <div className="space-y-3 mb-6">
                      <div className="flex justify-between">
                        <span className="text-secondary-600">{t('cart.subtotal')}</span>
                        <span className="font-medium">{formatPrice(totalPrice, language)}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-secondary-600">{t('cart.tax')}</span>
                        <span className="font-medium">{formatPrice(0, language)}</span>
                      </div>
                      <div className="border-t border-secondary-200 pt-3">
                        <div className="flex justify-between text-lg font-bold">
                          <span>{t('cart.total')}</span>
                          <span className="text-primary-600">{formatPrice(totalPrice, language)}</span>
                        </div>
                      </div>
                    </div>
                    
                    <button
                      onClick={() => navigate('/checkout')}
                      className="btn-primary w-full mb-4"
                    >
                      {t('cart.proceedToCheckout')}
                    </button>
                    
                    <Link
                      to="/shop"
                      className="btn-outline w-full"
                    >
                      {t('cart.continueShopping')}
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export default CartPage;