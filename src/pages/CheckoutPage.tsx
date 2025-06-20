import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { useLanguage } from '../context/LanguageContext';
import PaymentForm from '../components/PaymentForm';
import AuthForm from '../components/AuthForm';

const CheckoutPage: React.FC = () => {
  const { cartGames, totalPrice } = useCart();
  const { isAuthenticated } = useAuth();
  const { t } = useLanguage();
  const navigate = useNavigate();
  const [authComplete, setAuthComplete] = React.useState(false);
  const [showRegister, setShowRegister] = React.useState(!isAuthenticated);

  useEffect(() => {
    document.title = `${t('checkout.title')} | Enigma Mysteries`;
    
    // If cart is empty, redirect to shop
    if (cartGames.length === 0) {
      navigate('/shop');
    }
  }, [cartGames.length, navigate, t]);

  // For now, we'll just use the first game in the cart
  const selectedGame = cartGames[0];

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
        <div className="max-w-4xl mx-auto">
            <h1 className="text-3xl font-bold mb-8 text-center">{t('checkout.title')}</h1>
            {!isAuthenticated && !authComplete ? (
              <AuthForm onSuccess={() => setAuthComplete(true)} showRegister={showRegister} setShowRegister={setShowRegister} />
            ) : selectedGame && (
              <PaymentForm 
                gameId={selectedGame.id}
                gameTitle={selectedGame.title}
                price={selectedGame.price}
              />
            )}
          </div>
        </motion.div>
      </div>
    </div>
  );
};

export default CheckoutPage;