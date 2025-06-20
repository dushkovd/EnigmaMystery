import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Game, getActiveGames } from '../api/games';

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

  // Calculate total items and price
  useEffect(() => {
    const fetchGames = async () => {
      try {
        const games = await getActiveGames();
      const gamesInCart = items.map(item => {
        const game = games.find(g => g.id === item.gameId);
        return game ? { ...game, quantity: item.quantity } : null;
      }).filter(Boolean) as Game[];
      
      setCartGames(gamesInCart);
      setTotalItems(items.reduce((total, item) => total + item.quantity, 0));
      setTotalPrice(
        gamesInCart.reduce(
          (total, game) => {
            const item = items.find(i => i.gameId === game.id);
            return total + (game.price * (item?.quantity || 0));
          }, 
          0
        )
      );
      } catch (error) {
        console.error('Failed to fetch games for cart:', error);
      }
    };

    fetchGames();
  }, [items]);

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

  const value = {
    items,
    addToCart,
    removeFromCart,
    clearCart,
    totalItems,
    totalPrice,
    cartGames
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}