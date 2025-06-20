// Exchange rates (BGN is pegged to EUR at a fixed rate)
const BGN_TO_EUR = 1.95583;

export type SupportedCurrency = 'EUR' | 'BGN';

interface CurrencyConfig {
  symbol: string;
  code: string;
  rate: number; // Rate relative to EUR (base currency)
}

const CURRENCY_CONFIG: Record<SupportedCurrency, CurrencyConfig> = {
  EUR: {
    symbol: '€',
    code: 'eur',
    rate: 1,
  },
  BGN: {
    symbol: 'лв.',
    code: 'bgn',
    rate: BGN_TO_EUR,
  },
};

export const formatPrice = (priceInEur: number, language: 'en' | 'bg'): string => {
  const currency = language === 'bg' ? 'BGN' : 'EUR';
  const config = CURRENCY_CONFIG[currency];
  const price = Math.round(priceInEur * config.rate * 100) / 100; // Round to 2 decimal places
  
  // Format based on currency
  if (currency === 'BGN') {
    return `${price.toFixed(2)} ${config.symbol}`;
  }
  return `${config.symbol}${price.toFixed(2)}`;
};

export const convertToEur = (price: number, fromCurrency: SupportedCurrency): number => {
  if (fromCurrency === 'EUR') return price;
  return Math.round((price / CURRENCY_CONFIG[fromCurrency].rate) * 100) / 100;
};

export const getStripeCurrencyCode = (language: 'en' | 'bg'): string => {
  const currency = language === 'bg' ? 'BGN' : 'EUR';
  return CURRENCY_CONFIG[currency].code;
};

// Function to determine currency based on country code
export const getCurrencyForCountry = (countryCode: string): SupportedCurrency => {
  return countryCode === 'BG' ? 'BGN' : 'EUR';
}; 