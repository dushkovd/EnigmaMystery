import React from 'react';
import { Link } from 'react-router-dom';
import { Layers, Mail, Phone, MapPin, Facebook, Twitter, Instagram } from 'lucide-react';
import { useLanguage } from '../../context/LanguageContext';

const Footer: React.FC = () => {
  const { t } = useLanguage();

  return (
    <footer className="bg-secondary-800 text-white pt-12 pb-6">
      <div className="container-custom">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
          {/* Company Info */}
          <div>
            <div className="flex items-center mb-4">
              <Layers className="w-8 h-8 text-accent-400 mr-2" />
              <span className="font-display text-xl font-bold">{t('nav.siteName')}</span>
            </div>
            <p className="text-secondary-200 mb-4">
              {t('footer.companyInfo')}
            </p>
            <div className="flex space-x-4">
              <a href="#" className="text-secondary-300 hover:text-accent-400 transition-colors">
                <Facebook className="w-5 h-5" />
              </a>
              <a href="#" className="text-secondary-300 hover:text-accent-400 transition-colors">
                <Twitter className="w-5 h-5" />
              </a>
              <a href="#" className="text-secondary-300 hover:text-accent-400 transition-colors">
                <Instagram className="w-5 h-5" />
              </a>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="text-lg font-display font-bold mb-4">{t('footer.quickLinks')}</h3>
            <ul className="space-y-2">
              <li>
                <Link to="/" className="text-secondary-300 hover:text-accent-400 transition-colors">{t('footer.home')}</Link>
              </li>
              <li>
                <Link to="/shop" className="text-secondary-300 hover:text-accent-400 transition-colors">{t('footer.shop')}</Link>
              </li>
              <li>
                <Link to="/my-products" className="text-secondary-300 hover:text-accent-400 transition-colors">{t('footer.myGames')}</Link>
              </li>
              <li>
                <a href="#" className="text-secondary-300 hover:text-accent-400 transition-colors">{t('footer.aboutUs')}</a>
              </li>
              <li>
                <a href="#" className="text-secondary-300 hover:text-accent-400 transition-colors">{t('footer.faqs')}</a>
              </li>
            </ul>
          </div>

          {/* Contact Info */}
          <div>
            <h3 className="text-lg font-display font-bold mb-4">{t('footer.contactUs')}</h3>
            <ul className="space-y-3">
              <li className="flex items-start">
                <MapPin className="w-5 h-5 text-accent-400 mr-2 mt-0.5" />
                <span className="text-secondary-300">{t('footer.address')}</span>
              </li>
              <li className="flex items-center">
                <Phone className="w-5 h-5 text-accent-400 mr-2" />
                <span className="text-secondary-300">{t('footer.phone')}</span>
              </li>
              <li className="flex items-center">
                <Mail className="w-5 h-5 text-accent-400 mr-2" />
                <span className="text-secondary-300">{t('footer.email')}</span>
              </li>
            </ul>
          </div>
        </div>

        {/* Copyright */}
        <div className="pt-6 border-t border-secondary-700 text-center text-secondary-400 text-sm">
          <p>&copy; {new Date().getFullYear()} {t('nav.siteName')}. {t('footer.copyright')}</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;