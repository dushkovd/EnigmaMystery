import React, { useEffect } from 'react';
import { Routes, Route, useLocation } from 'react-router-dom';
import Layout from './components/layout/Layout';
const HomePage = React.lazy(() => import('./pages/HomePage'));
const ShopPage = React.lazy(() => import('./pages/ShopPage'));
const CartPage = React.lazy(() => import('./pages/CartPage'));
const CheckoutPage = React.lazy(() => import('./pages/Checkout'));
const CheckoutPageLegacy = React.lazy(() => import('./pages/CheckoutPage'));
const MyProductsPage = React.lazy(() => import('./pages/MyProductsPage'));
const GameViewerPage = React.lazy(() => import('./pages/GameViewerPage'));
const GamePreviewPage = React.lazy(() => import('./pages/GamePreviewPage'));
const ResetPasswordPage = React.lazy(() => import('./pages/ResetPasswordPage'));
const TermsPage = React.lazy(() => import('./pages/TermsPage'));
const FaqPage = React.lazy(() => import('./pages/FaqPage'));
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext';
import { LanguageProvider } from './context/LanguageContext';
import { CurrencyProvider } from './context/CurrencyContext';
import { GameProvider } from './context/GameContext';
import ScrollToTop from './components/layout/ScrollToTop';
import { trackPageView } from './utils/analytics';

function AppContent() {
  const location = useLocation();

  useEffect(() => {
    // Track page views
    const pageName = location.pathname || '/';
    trackPageView(pageName);
  }, [location]);

  return (
    <>
      <ScrollToTop />
      <Layout>
        <React.Suspense fallback={<div />}> 
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/shop" element={<ShopPage />} />
            <Route path="/cart" element={<CartPage />} />
            <Route path="/checkout" element={<CheckoutPage />} />
            <Route path="/checkout-legacy" element={<CheckoutPageLegacy />} />
            <Route path="/my-products" element={<MyProductsPage />} />
            <Route path="/game/:gameId/:screen?" element={<GameViewerPage />} />
            <Route path="/preview/:gameId" element={<GamePreviewPage />} />
            <Route path="/reset-password" element={<ResetPasswordPage />} />
            <Route path="/terms" element={<TermsPage />} />
            <Route path="/faq" element={<FaqPage />} />
          </Routes>
        </React.Suspense>
      </Layout>
    </>
  );
}

function App() {
  return (
    <LanguageProvider>
      <AuthProvider>
        <GameProvider>
          <CartProvider>
            <CurrencyProvider>
              <AppContent />
            </CurrencyProvider>
          </CartProvider>
        </GameProvider>
      </AuthProvider>
    </LanguageProvider>
  );
}

export default App;