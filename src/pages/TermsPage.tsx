import React from 'react';
import { useLanguage } from '../context/LanguageContext';

const TermsPage: React.FC = () => {
  const { t } = useLanguage();

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom max-w-3xl mx-auto">
        <div className="mystery-paper p-8 rounded-lg shadow-lg">
          <h1 className="text-3xl font-display font-bold mb-6 text-center">{t('terms.title')}</h1>
          <p className="text-center text-secondary-500 mb-8">{t('terms.lastUpdated')} {new Date().toLocaleDateString()}</p>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.introduction.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.introduction.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.digitalProducts.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.digitalProducts.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.payment.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.payment.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.delivery.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.delivery.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.refunds.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.refunds.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.userAccounts.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.userAccounts.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.intellectualProperty.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.intellectualProperty.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.prohibitedUse.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.prohibitedUse.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.limitationOfLiability.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.limitationOfLiability.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.changesToTerms.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.changesToTerms.content')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.contactUs.title')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.contactUs.content')}</p>
          </section>
        </div>
      </div>
    </div>
  );
};

export default TermsPage;