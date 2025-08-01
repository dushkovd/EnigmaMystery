import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Game } from '../api/games';
import { useGames } from './GameContext';
import { getEffectivePrice } from '../utils/currencyFormatter';

// Track AddToCart event with Meta Pixel
const trackAddToCart = (value: number, currency: string, contentIds: string[]) => {
  if (typeof window !== 'undefined' && (window as any).fbq) {
    (window as any).fbq('track', 'AddToCart', {
      value: value,
      currency: currency,
      content_ids: contentIds,
      content_type: 'product'
    });
  }
};

interface CartItem {
  gameId: string;
  quantity: number;
}

interface CartContextType {
  items: CartItem[];
  addToCart: (gameId: string) => void;
  removeFromCart: (gameId: string) => void;
  clearCart: () => void;
  totalItems: number;
  totalPrice: number;
  cartGames: Game[];
  refreshGames: () => Promise<void>;
}

interface CartProviderProps {
  children: ReactNode;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export function useCart() {
  const context = useContext(CartContext);
  if (context === undefined) {
    throw new Error('useCart must be used within a CartProvider');
  }
  return context;
}

export function CartProvider({ children }: CartProviderProps) {
  const [items, setItems] = useState<CartItem[]>([]);
  const { games, loading: gamesLoading } = useGames();
  const [cartGames, setCartGames] = useState<Game[]>([]);
  const [totalItems, setTotalItems] = useState(0);
  const [totalPrice, setTotalPrice] = useState(0);

  // Load cart from localStorage on initial load
  useEffect(() => {
    const savedCart = localStorage.getItem('cart');
    if (savedCart) {
      try {
        setItems(JSON.parse(savedCart));
      } catch (e) {
        console.error('Failed to parse cart from localStorage:', e);
      }
    }
  }, []);

  // Save cart to localStorage whenever it changes
  useEffect(() => {
    localStorage.setItem('cart', JSON.stringify(items));
  }, [items]);

  // Calculate totals whenever cart items or the main game list changes
  useEffect(() => {
    if (!gamesLoading && games.length > 0) {
      const gamesInCart = items.map(item => {
        const game = games.find(g => g.id === item.gameId);
        return game ? { ...game, quantity: item.quantity } : null;
      }).filter(Boolean) as (Game & { quantity: number })[];
      
      setCartGames(gamesInCart);
      setTotalItems(items.reduce((total, item) => total + item.quantity, 0));
      setTotalPrice(
        gamesInCart.reduce((total, game) => total + (getEffectivePrice(game) * game.quantity), 0)
      );
    }
  }, [items, games, gamesLoading]);

  const addToCart = (gameId: string) => {
    setItems(prevItems => {
      const existingItem = prevItems.find(item => item.gameId === gameId);
      if (existingItem) {
        return prevItems.map(item => 
          item.gameId === gameId 
            ? { ...item, quantity: item.quantity + 1 } 
            : item
        );
      } else {
        return [...prevItems, { gameId, quantity: 1 }];
      }
    });
    
    // Track AddToCart event with Meta Pixel
    const game = games.find(g => g.id === gameId);
    if (game) {
      const price = getEffectivePrice(game);
      trackAddToCart(price, 'USD', [gameId]);
    }
  };

  const removeFromCart = (gameId: string) => {
    setItems(prevItems => {
      const existingItem = prevItems.find(item => item.gameId === gameId);
      if (existingItem && existingItem.quantity > 1) {
        return prevItems.map(item => 
          item.gameId === gameId 
            ? { ...item, quantity: item.quantity - 1 } 
            : item
        );
      } else {
        return prevItems.filter(item => item.gameId !== gameId);
      }
    });
  };

  const clearCart = () => {
    setItems([]);
  };

  const refreshGames = async () => {
    // This function is kept for compatibility but no longer needed
    // as games are fetched on every cart change
  };

  const value = {
    items,
    addToCart,
    removeFromCart,
    clearCart,
    totalItems,
    totalPrice,
    cartGames,
    refreshGames
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}