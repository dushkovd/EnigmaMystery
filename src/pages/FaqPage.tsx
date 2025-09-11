import React, { useEffect } from 'react';
// Animations removed for performance
import { useLanguage } from '../context/LanguageContext';

const FaqItem = ({ q, a }: { q: string, a: string }) => (
  <div className="bg-white p-6 rounded-lg shadow-sm">
    <h3 className="text-xl font-display font-bold mb-2">{q}</h3>
    <p className="text-secondary-600 leading-relaxed">{a}</p>
  </div>
);

const FaqPage: React.FC = () => {
  const { t } = useLanguage();

  useEffect(() => {
    document.title = `${t('faq.title')} | Enigma Mysteries`;
  }, [t]);

  const faqData = [
    { q: t('shop.faq.players.question'), a: t('shop.faq.players.answer') },
    { q: t('shop.faq.duration.question'), a: t('shop.faq.duration.answer') },
    { q: t('shop.faq.replay.question'), a: t('shop.faq.replay.answer') },
    { q: t('shop.faq.print.question'), a: t('shop.faq.print.answer') },
  ];

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom">
        <div className="max-w-3xl mx-auto">
          <h1 className="text-4xl font-display font-bold text-center mb-8">{t('faq.title')}</h1>
          <div className="space-y-6">
            {faqData.map((faq, index) => (
              <FaqItem
                key={index}
                q={faq.q}
                a={faq.a}
              />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default FaqPage; 