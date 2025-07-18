import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ShoppingCart, Eye, Plus, Minus } from 'lucide-react';
import { Game } from '../../api/games';
import { useCart } from '../../context/CartContext';
import { useAuth } from '../../context/AuthContext';
import { useLanguage } from '../../context/LanguageContext';
import { formatPrice } from '../../utils/currencyFormatter';

interface GameCardProps {
  game: Game;
  purchased?: boolean;
}

const GameCard: React.FC<GameCardProps> = ({ game, purchased = false }) => {
  const { addToCart, removeFromCart, items } = useCart();
  const { isAuthenticated } = useAuth();
  const { t, language } = useLanguage();
  const navigate = useNavigate();

  const getItemQuantity = () => {
    const item = items.find(item => item.gameId === game.id);
    return item ? item.quantity : 0;
  };

  const quantity = getItemQuantity();

  const handleAddToCart = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    addToCart(game.id);
    navigate('/cart');
  };

  const handleRemoveFromCart = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    removeFromCart(game.id);
  };

  const handlePreview = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    navigate(`/preview/${game.game_id}`);
  };

  const title = language === 'bg' ? game.title_bg || game.title : game.title;
  const subtitle = language === 'bg' ? game.subtitle_bg || game.subtitle : game.subtitle;
  const description = language === 'bg' ? game.description_bg || game.description : game.description;
  const difficulty = language === 'bg' ? game.difficulty_bg || game.difficulty : game.difficulty;
  const players = language === 'bg' ? game.players : game.players;

  return (
    <>
      <motion.div 
        className="card card-hover h-full flex flex-col cursor-pointer"
        whileHover={{ y: -5 }}
        transition={{ duration: 0.2 }}
        onClick={() => navigate(`/preview/${game.game_id}`)}
      >
        <div className="relative h-48 sm:h-60 overflow-hidden">
          <img 
            src={game.image} 
            alt={title} 
            className="w-full h-full object-cover transition-transform duration-700 hover:scale-105"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-secondary-900 to-transparent opacity-60"></div>
          <div className="absolute bottom-2 left-3 right-3">
            <div className="flex justify-between items-center">
              <span className="text-xs font-medium px-2 py-1 bg-primary-600 text-white rounded">
                {difficulty}
              </span>
              <span className="text-xs font-medium px-2 py-1 bg-secondary-700 text-white rounded">
                {players}
              </span>
            </div>
          </div>
        </div>

        <div className="p-5 flex flex-col flex-grow">
          <h3 className="font-display text-xl font-bold text-secondary-800 mb-1 hover:text-primary-600 transition-colors">{title}</h3>
          <p className="text-sm text-primary-600 italic mb-3">{subtitle}</p>
          <p className="text-secondary-600 text-sm mb-4 flex-grow">{description}</p>
          
          <div className="mt-auto flex items-center justify-between" onClick={(e) => e.stopPropagation()}>
            <span className="text-lg font-bold text-secondary-800">
              {formatPrice(game.price, language)}
            </span>
            
            {purchased ? (
              <Link to={`/game/${game.id}`} className="btn-primary py-2 px-4 text-sm">
                {t('myProducts.playNow')}
              </Link>
            ) : (
              <div className="flex items-center space-x-2">
                <button onClick={handlePreview} className="btn-outline py-2 px-3 text-sm">
                  <Eye className="w-4 h-4 mr-1" />
                  {t('shop.preview')}
                </button>
                {quantity > 0 ? (
                  <button className="btn-primary py-2 px-3 text-sm" disabled>
                    {t('shop.inCart')}
                  </button>
                ) : (
                  <button onClick={handleAddToCart} className="btn-primary py-2 px-3 text-sm">
                    {t('shop.addToCart')}
                  </button>
                )}
              </div>
            )}
          </div>
        </div>
      </motion.div>
    </>
  );
};

export default GameCard;