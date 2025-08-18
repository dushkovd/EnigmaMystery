import React from 'react';
import { Link } from 'react-router-dom';
import { Layers, Facebook, Twitter, Instagram } from 'lucide-react';
import { useLanguage } from '../../context/LanguageContext';

const Footer: React.FC = () => {
  const { t } = useLanguage();

  return (
    <footer className="bg-secondary-800 text-secondary-300">
      <div className="container-custom py-12">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {/* Brand Info */}
          <div className="space-y-4">
            <Link to="/" className="flex items-center text-white mb-2">
              <Layers className="w-8 h-8 text-accent-400 mr-2" />
              <span className="font-display text-xl font-bold">{t('nav.siteName')}</span>
            </Link>
            <p className="max-w-md">
              {t('footer.companyInfo')}
            </p>
            <div className="flex space-x-4 hidden">
              <a href="#" className="text-secondary-300 hover:text-white"><Facebook /></a>
              <a href="#" className="text-secondary-300 hover:text-white"><Twitter /></a>
              <a href="#" className="text-secondary-300 hover:text-white"><Instagram /></a>
            </div>
          </div>

          {/* Quick Links */}
          <div className="flex flex-col items-start md:items-start">
            <h4 className="font-bold text-white mb-4">{t('footer.quickLinks')}</h4>
            <ul className="flex flex-col md:flex-row md:space-x-6 space-y-2 md:space-y-0">
              <li><Link to="/" className="hover:text-white">{t('nav.home')}</Link></li>
              <li><Link to="/shop" className="hover:text-white">{t('nav.shop')}</Link></li>
              <li><Link to="/my-products" className="hover:text-white">{t('nav.myGames')}</Link></li>
              <li><Link to="/faq" className="hover:text-white">{t('footer.faqs')}</Link></li>
              <li><Link to="/terms" className="hover:text-white">{t('footer.terms')}</Link></li>
            </ul>
          </div>
        </div>
      </div>
      <div className="border-t border-secondary-700 py-4">
        <div className="container-custom text-center text-sm">
          <p>&copy; {new Date().getFullYear()} {t('nav.siteName')}. {t('footer.copyright')}</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;