import React from 'react';
import { useLanguage } from '../context/LanguageContext';

const TermsPage: React.FC = () => {
  const { t } = useLanguage();

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom max-w-3xl mx-auto">
        <div className="mystery-paper p-8 rounded-lg shadow-lg">
          <h1 className="text-3xl font-display font-bold mb-6 text-center">{t('terms.title')}</h1>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.introTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.intro')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.digitalProductsTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.digitalProducts')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.paymentTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.payment')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.deliveryTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.delivery')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.refundsTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.refunds')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.userAccountsTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.userAccounts')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.intellectualPropertyTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.intellectualProperty')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.prohibitedUseTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.prohibitedUse')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.limitationOfLiabilityTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.limitationOfLiability')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.changesToTermsTitle')}</h2>
            <p className="text-secondary-700 mb-2">{t('terms.changesToTerms')}</p>
          </section>

          <section className="mb-6">
            <h2 className="text-xl font-semibold mb-2">{t('terms.contactTitle')}</h2>
            <p className="text-secondary-700 mb-2">
              {t('terms.contact')}
              <br />
              <a href="mailto:support@enigmamysteries.com" className="text-primary-600 underline">support@enigmamysteries.com</a>
            </p>
          </section>
        </div>
      </div>
    </div>
  );
};

export default TermsPage; 