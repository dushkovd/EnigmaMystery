import React, { useEffect } from 'react';
import { Routes, Route, useLocation } from 'react-router-dom';
import Layout from './components/layout/Layout';
import HomePage from './pages/HomePage';
import ShopPage from './pages/ShopPage';
import CartPage from './pages/CartPage';
import CheckoutPage from './pages/CheckoutPage';
import MyProductsPage from './pages/MyProductsPage';
import GameViewerPage from './pages/GameViewerPage';
import GamePreviewPage from './pages/GamePreviewPage';
import ResetPasswordPage from './pages/ResetPasswordPage';
import TermsPage from './pages/TermsPage';
import FaqPage from './pages/FaqPage';
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
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/shop" element={<ShopPage />} />
          <Route path="/cart" element={<CartPage />} />
          <Route path="/checkout" element={<CheckoutPage />} />
          <Route path="/my-products" element={<MyProductsPage />} />
          <Route path="/game/:gameId/:screen?" element={<GameViewerPage />} />
          <Route path="/preview/:gameId" element={<GamePreviewPage />} />
          <Route path="/reset-password" element={<ResetPasswordPage />} />
          <Route path="/terms" element={<TermsPage />} />
          <Route path="/faq" element={<FaqPage />} />
        </Routes>
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