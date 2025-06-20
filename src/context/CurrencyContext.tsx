import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { SupportedCurrency, getCurrencyForCountry } from '../utils/currencyFormatter';

interface CurrencyContextType {
  currency: SupportedCurrency;
  setCurrency: (currency: SupportedCurrency) => void;
}

const CurrencyContext = createContext<CurrencyContextType | undefined>(undefined);

export function useCurrency() {
  const context = useContext(CurrencyContext);
  if (context === undefined) {
    throw new Error('useCurrency must be used within a CurrencyProvider');
  }
  return context;
}

export function CurrencyProvider({ children }: { children: ReactNode }) {
  const [currency, setCurrency] = useState<SupportedCurrency>('EUR');

  useEffect(() => {
    // Attempt to detect user's country
    fetch('https://ipapi.co/json/')
      .then(response => response.json())
      .then(data => {
        const detectedCurrency = getCurrencyForCountry(data.country);
        setCurrency(detectedCurrency);
      })
      .catch(() => {
        // If detection fails, default to EUR
        setCurrency('EUR');
      });
  }, []);

  return (
    <CurrencyContext.Provider value={{ currency, setCurrency }}>
      {children}
    </CurrencyContext.Provider>
  );
} 