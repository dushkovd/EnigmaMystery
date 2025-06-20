import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';

type Currency = 'usd' | 'eur' | 'bgn';

interface CurrencyContextType {
  currency: Currency;
  setCurrency: (currency: Currency) => void;
  loading: boolean;
}

const CurrencyContext = createContext<CurrencyContextType | undefined>(undefined);

export const useCurrency = () => {
  const context = useContext(CurrencyContext);
  if (context === undefined) {
    throw new Error('useCurrency must be used within a CurrencyProvider');
  }
  return context;
};

interface CurrencyProviderProps {
  children: ReactNode;
}

export const CurrencyProvider: React.FC<CurrencyProviderProps> = ({ children }) => {
  const [currency, setCurrency] = useState<Currency>('usd');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const initializeCurrency = async () => {
      try {
        const savedCurrency = localStorage.getItem('user-currency');
        
        if (savedCurrency && ['usd', 'eur', 'bgn'].includes(savedCurrency)) {
          setCurrency(savedCurrency as Currency);
          setLoading(false);
          return;
        }

        const response = await fetch('https://ipapi.co/json/');
        const data = await response.json();
        let determinedCurrency: Currency = 'usd';

        if (data.country_code === 'BG') {
          determinedCurrency = 'bgn';
        } else if (data.continent_code === 'EU') {
          determinedCurrency = 'eur';
        }
        
        setCurrency(determinedCurrency);
        localStorage.setItem('user-currency', determinedCurrency);
      } catch (error) {
        console.error('Failed to fetch currency, defaulting to USD:', error);
        setCurrency('usd');
        localStorage.setItem('user-currency', 'usd'); // Save default on error
      } finally {
        setLoading(false);
      }
    };

    initializeCurrency();
  }, []);

  const handleSetCurrency = (newCurrency: Currency) => {
    setCurrency(newCurrency);
    localStorage.setItem('user-currency', newCurrency);
  };

  const value = { currency, setCurrency: handleSetCurrency, loading };

  return (
    <CurrencyContext.Provider value={value}>
      {children}
    </CurrencyContext.Provider>
  );
}; 