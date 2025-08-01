import React, { useEffect, Suspense } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { useLanguage } from '../context/LanguageContext';
import AuthForm from '../components/AuthForm';

// Declare Meta Pixel types
declare global {
  interface Window {
    fbq: any;
    _fbq: any;
  }
}

// Track initiate checkout event
const trackInitiateCheckout = (value?: number, currency: string = 'USD', contentIds?: string[]) => {
  if (typeof window !== 'undefined' && (window as any).fbq) {
    const parameters: any = {
      content_type: 'product'
    };
    
    if (value !== undefined) {
      parameters.value = value;
      parameters.currency = currency;
    }
    
    if (contentIds) {
      parameters.content_ids = contentIds;
    }
    
    (window as any).fbq('track', 'InitiateCheckout', parameters);
  }
};

const PaymentForm = React.lazy(() => import('../components/PaymentForm'));

const CheckoutPage: React.FC = () => {
  const { cartGames, totalPrice } = useCart();
  const { isAuthenticated } = useAuth();
  const { t } = useLanguage();
  const navigate = useNavigate();
  const [authComplete, setAuthComplete] = React.useState(false);
  const [showRegister, setShowRegister] = React.useState(!isAuthenticated);
  const [isProcessingPayment, setIsProcessingPayment] = React.useState(false);

  useEffect(() => {
    document.title = `${t('checkout.title')} | Enigma Mysteries`;
    
    // Only redirect to shop if cart is empty and user is not authenticated
    // Authenticated users should stay on checkout page even with empty cart
    if (cartGames.length === 0 && !isAuthenticated) {
      navigate('/shop');
    }
  }, [cartGames.length, navigate, t, isAuthenticated]);

  // Track initiate checkout event when user reaches checkout page
  useEffect(() => {
    if (cartGames.length > 0) {
      const contentIds = cartGames.map(game => game.id.toString());
      trackInitiateCheckout(totalPrice, 'USD', contentIds);
    }
  }, [cartGames, totalPrice]);

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
              <Suspense fallback={<div className="text-center p-8">Loading payment form...</div>}>
                <PaymentForm 
                  gameId={selectedGame.id}
                  gameTitle={selectedGame.title}
                  game={selectedGame}
                  onProcessingChange={setIsProcessingPayment}
                />
              </Suspense>
            )}
          </div>
        </motion.div>
      </div>
    </div>
  );
};

export default CheckoutPage;