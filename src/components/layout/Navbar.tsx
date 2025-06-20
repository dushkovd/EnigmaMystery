import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Menu, X, ShoppingCart, User, Layers, Globe } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useCart } from '../../context/CartContext';
import { useLanguage } from '../../context/LanguageContext';
import { motion, AnimatePresence } from 'framer-motion';
import AuthForm from '../AuthForm';

const Navbar: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const [showLanguageMenu, setShowLanguageMenu] = useState(false);
  const [showAuthModal, setShowAuthModal] = useState(false);
  const { isAuthenticated, user, logout } = useAuth();
  const { totalItems } = useCart();
  const { language, setLanguage, t } = useLanguage();
  const location = useLocation();

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 10) {
        setIsScrolled(true);
      } else {
        setIsScrolled(false);
      }
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  // Close mobile menu when route changes
  useEffect(() => {
    setIsOpen(false);
  }, [location]);

  const toggleLanguage = () => {
    setLanguage(language === 'en' ? 'bg' : 'en');
    setShowLanguageMenu(false);
  };

  const handleAuthSuccess = () => {
    setShowAuthModal(false);
  };

  return (
    <>
      <header 
        className={`fixed w-full z-50 transition-all duration-300 ${
          isScrolled ? 'bg-secondary-800 shadow-lg' : 'bg-transparent'
        }`}
      >
        <div className="container-custom py-4">
          <div className="flex justify-between items-center">
            {/* Logo */}
            <Link to="/" className="flex items-center">
              <Layers className="w-8 h-8 text-accent-400 mr-2" />
              <span className="font-display text-xl font-bold text-white">{t('nav.siteName')}</span>
            </Link>

            {/* Desktop Navigation */}
            <nav className="hidden md:flex items-center space-x-8">
              <Link to="/" className="text-white hover:text-accent-400 transition-colors font-medium">
                {t('nav.home')}
              </Link>
              <Link to="/shop" className="text-white hover:text-accent-400 transition-colors font-medium">
                {t('nav.shop')}
              </Link>
              {isAuthenticated && (
                <Link to="/my-products" className="text-white hover:text-accent-400 transition-colors font-medium">
                  {t('nav.myGames')}
                </Link>
              )}
            </nav>

            {/* User Actions */}
            <div className="hidden md:flex items-center space-x-4">
              {/* Language Switcher */}
              <div className="relative">
                <button
                  onClick={() => setShowLanguageMenu(!showLanguageMenu)}
                  className="flex items-center text-white hover:text-accent-400 transition-colors"
                >
                  <Globe className="w-5 h-5 mr-1" />
                  <span className="text-sm font-medium">{language.toUpperCase()}</span>
                </button>
                
                <AnimatePresence>
                  {showLanguageMenu && (
                    <motion.div
                      initial={{ opacity: 0, y: -10 }}
                      animate={{ opacity: 1, y: 0 }}
                      exit={{ opacity: 0, y: -10 }}
                      className="absolute top-full right-0 mt-2 bg-white rounded-md shadow-lg border border-secondary-200 overflow-hidden"
                    >
                      <button
                        onClick={() => { setLanguage('en'); setShowLanguageMenu(false); }}
                        className={`block w-full px-4 py-2 text-left hover:bg-secondary-50 transition-colors ${
                          language === 'en' ? 'bg-primary-50 text-primary-600' : 'text-secondary-700'
                        }`}
                      >
                        {t('nav.english')}
                      </button>
                      <button
                        onClick={() => { setLanguage('bg'); setShowLanguageMenu(false); }}
                        className={`block w-full px-4 py-2 text-left hover:bg-secondary-50 transition-colors ${
                          language === 'bg' ? 'bg-primary-50 text-primary-600' : 'text-secondary-700'
                        }`}
                      >
                        {t('nav.bulgarian')}
                      </button>
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>

              {isAuthenticated ? (
                <div className="flex items-center space-x-4">
                  <Link to="/my-products" className="flex items-center text-white hover:text-accent-400">
                    <User className="w-5 h-5 mr-2" />
                    <span>{user?.email}</span>
                  </Link>
                  <button
                    onClick={logout}
                    className="text-white hover:text-accent-400 text-sm"
                  >
                    {t('nav.logout')}
                  </button>
                </div>
              ) : (
                <button
                  onClick={() => setShowAuthModal(true)}
                  className="text-white hover:text-accent-400"
                >
                  {t('nav.signIn')}
                </button>
              )}
              
              <Link to="/cart" className="relative group">
                <ShoppingCart className="w-6 h-6 text-white group-hover:text-accent-400" />
                {totalItems > 0 && (
                  <span className="absolute -top-2 -right-2 bg-primary-600 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full">
                    {totalItems}
                  </span>
                )}
              </Link>
            </div>

            {/* Mobile Menu Button */}
            <button
              className="md:hidden text-white focus:outline-none"
              onClick={() => setIsOpen(!isOpen)}
            >
              {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>

        {/* Mobile Navigation */}
        <AnimatePresence>
          {isOpen && (
            <motion.div
              className="md:hidden bg-secondary-700 absolute w-full"
              initial={{ opacity: 0, height: 0 }}
              animate={{ opacity: 1, height: 'auto' }}
              exit={{ opacity: 0, height: 0 }}
              transition={{ duration: 0.2 }}
            >
              <nav className="container-custom py-4 flex flex-col space-y-4">
                <Link to="/" className="text-white hover:text-accent-400 transition-colors py-2 font-medium">
                  {t('nav.home')}
                </Link>
                <Link to="/shop" className="text-white hover:text-accent-400 transition-colors py-2 font-medium">
                  {t('nav.shop')}
                </Link>
                {isAuthenticated && (
                  <Link to="/my-products" className="text-white hover:text-accent-400 transition-colors py-2 font-medium">
                    {t('nav.myGames')}
                  </Link>
                )}
                
                {/* Mobile Language Switcher */}
                <div className="py-2">
                  <button
                    onClick={toggleLanguage}
                    className="flex items-center text-white hover:text-accent-400 transition-colors"
                  >
                    <Globe className="w-5 h-5 mr-2" />
                    <span>{language === 'en' ? t('nav.bulgarian') : t('nav.english')}</span>
                  </button>
                </div>
                
                <div className="pt-2 border-t border-secondary-600 flex items-center justify-between">
                  {isAuthenticated ? (
                    <div className="flex items-center space-x-4">
                      <button
                        onClick={logout}
                        className="text-white hover:text-accent-400 text-sm"
                      >
                        {t('nav.logout')}
                      </button>
                    </div>
                  ) : (
                    <button
                      onClick={() => {
                        setIsOpen(false);
                        setShowAuthModal(true);
                      }}
                      className="text-white hover:text-accent-400 py-2"
                    >
                      {t('nav.signIn')}
                    </button>
                  )}
                  <Link to="/cart" className="relative text-white hover:text-accent-400 py-2">
                    <ShoppingCart className="w-5 h-5 inline mr-1" />
                    {t('nav.cart')} ({totalItems})
                  </Link>
                </div>
              </nav>
            </motion.div>
          )}
        </AnimatePresence>
      </header>

      {/* Auth Modal */}
      <AnimatePresence>
        {showAuthModal && (
          <motion.div
            className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setShowAuthModal(false)}
          >
            <motion.div
              className="max-w-md w-full"
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              <AuthForm
                onSuccess={handleAuthSuccess}
                onCancel={() => setShowAuthModal(false)}
                showCancelButton={true}
              />
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
};

export default Navbar;