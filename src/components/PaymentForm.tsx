import React, { useState } from 'react';
import { loadStripe } from '@stripe/stripe-js';
import {
  CardNumberElement,
  CardCvcElement,
  CardExpiryElement,
  Elements,
  useStripe,
  useElements,
} from '@stripe/react-stripe-js';
import { useAuth } from '../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../supabaseClient';
import { motion, AnimatePresence } from 'framer-motion';
import { useCart } from '../context/CartContext';
import { useLanguage } from '../context/LanguageContext';
import { useCurrency } from '../context/CurrencyContext';
import { formatPrice, getStripeCurrencyCode } from '../utils/currencyFormatter';

// Initialize Stripe with your publishable key
const stripePromise = loadStripe(import.meta.env.VITE_STRIPE_PUBLIC_KEY);

interface PaymentFormProps {
  gameId: string;
  gameTitle: string;
  price: number;
}

const PaymentFormContent: React.FC<PaymentFormProps> = ({ gameId, gameTitle, price }) => {
  const stripe = useStripe();
  const elements = useElements();
  const [error, setError] = useState<string | null>(null);
  const [processing, setProcessing] = useState(false);
  const [success, setSuccess] = useState(false);
  const { user } = useAuth();
  const { clearCart } = useCart();
  const navigate = useNavigate();
  const { t, language } = useLanguage();
  const { currency } = useCurrency();

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    
    if (!stripe || !elements) {
      return;
    }

    setProcessing(true);
    setError(null);

    try {
      // Create payment intent with the selected currency
      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_FUNCTION_URL}/create-payment-intent`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${import.meta.env.VITE_SUPABASE_ANON_KEY}`,
          },
          body: JSON.stringify({
            amount: Math.round(price * 100), // Convert to cents
            currency: getStripeCurrencyCode(language),
            userId: user?.id,
          }),
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || t('common.error'));
      }

      const data = await response.json();

      if (!data.clientSecret) {
        throw new Error(data.error || t('common.error'));
      }

      // 2. Confirm the payment with Stripe
      const { error: stripeError, paymentIntent } = await stripe.confirmCardPayment(
        data.clientSecret,
        {
          payment_method: {
            card: elements.getElement(CardNumberElement)!,
            billing_details: {
              email: user?.email,
            },
          },
        }
      );

      if (stripeError) {
        throw new Error(stripeError.message);
      }

      if (paymentIntent.status === 'succeeded') {
        // Create order in the database
        const { data: orderData, error: orderError } = await supabase
          .from('Orders')
          .insert([
            {
              user_id: user?.id,
              total_amount: price,
              status: 'completed',
              payment_intent_id: paymentIntent.id
            }
          ])
          .select()
          .single();

        if (orderError) {
          throw new Error(t('checkout.orderError'));
        }

        // Create order item
        const { error: orderItemError } = await supabase
          .from('Order_Items')
          .insert([
            {
              order_id: orderData.order_id,
              game_id: gameId,
              quantity: 1,
              price: price
            }
          ]);

        if (orderItemError) {
          throw new Error(t('checkout.orderItemError'));
        }

        // Show success message
        setSuccess(true);
        clearCart();
        // Only redirect to /my-products after a short delay
        setTimeout(() => {
          navigate('/my-products');
        }, 2000);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : t('common.error'));
    } finally {
      setProcessing(false);
    }
  };

  const cardElementOptions = {
    style: {
      base: {
        fontSize: '16px',
        color: '#424770',
        '::placeholder': {
          color: '#aab7c4',
        },
      },
      invalid: {
        color: '#9e2146',
      },
    },
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-md mx-auto p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-6">{t('checkout.paymentDetails')}</h2>
      <p className="mb-4 text-gray-600">{t('checkout.purchasing')}: {gameTitle}</p>
      <p className="mb-6 text-gray-600">{t('checkout.amount')}: {formatPrice(price, language)}</p>
      
      <div className="space-y-4">
        <div>
          <label className="block text-gray-700 text-sm font-bold mb-2">
            {t('checkout.cardNumber')}
          </label>
          <div className="p-3 border rounded-md">
            <CardNumberElement options={cardElementOptions} />
          </div>
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-gray-700 text-sm font-bold mb-2">
              {t('checkout.expiryDate')}
            </label>
            <div className="p-3 border rounded-md">
              <CardExpiryElement options={cardElementOptions} />
            </div>
          </div>
          <div>
            <label className="block text-gray-700 text-sm font-bold mb-2">
              {t('checkout.cvc')}
            </label>
            <div className="p-3 border rounded-md">
              <CardCvcElement options={cardElementOptions} />
            </div>
          </div>
        </div>

        {/* Stripe Disclaimer */}
        <div className="mt-6 p-4 bg-gray-50 rounded-lg border border-gray-200">
          <div className="flex items-center justify-between mb-2">
            <p className="text-sm text-gray-600">{t('checkout.stripe')}</p>
            <img 
              src="https://upload.wikimedia.org/wikipedia/commons/b/ba/Stripe_Logo%2C_revised_2016.svg" 
              alt="Stripe" 
              className="h-6 object-contain"
            />
          </div>
          <p className="text-xs text-gray-500">{t('checkout.stripeDisclaimer')}</p>
        </div>
      </div>

      <AnimatePresence>
        {error && (
          <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            className="mt-4 p-3 bg-red-100 text-red-700 rounded-md"
          >
            {error}
          </motion.div>
        )}

        {success && (
          <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            className="mt-4 p-3 bg-green-100 text-green-700 rounded-md"
          >
            {t('checkout.paymentSuccess')}
          </motion.div>
        )}
      </AnimatePresence>

      <button
        type="submit"
        disabled={!stripe || processing}
        className={`w-full py-3 px-4 text-white font-medium rounded-lg ${
          processing ? 'bg-primary-400' : 'bg-primary-600 hover:bg-primary-700'
        }`}
      >
        {processing ? t('checkout.processingPayment') : `${t('checkout.pay')} ${formatPrice(price, language)}`}
      </button>
    </form>
  );
};

const PaymentForm: React.FC<PaymentFormProps> = (props) => {
  return (
    <Elements stripe={stripePromise}>
      <PaymentFormContent {...props} />
    </Elements>
  );
};

export default PaymentForm; 