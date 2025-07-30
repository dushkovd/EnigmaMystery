import React from 'react';
import { useLanguage } from '../context/LanguageContext';

const DebugTranslations: React.FC = () => {
  const { language, t } = useLanguage();

  return (
    <div style={{ 
      position: 'fixed', 
      top: '10px', 
      right: '10px', 
      background: 'red', 
      color: 'white', 
      padding: '10px', 
      zIndex: 9999,
      fontSize: '12px',
      maxWidth: '300px'
    }}>
      <div><strong>Language:</strong> {language}</div>
      <div><strong>Terms Accept:</strong> {t('auth.termsAccept')}</div>
      <div><strong>Terms:</strong> {t('auth.termsAndConditions')}</div>
      <div><strong>Already Account:</strong> {t('auth.alreadyHaveAccount')}</div>
      <div><strong>Sign In Here:</strong> {t('auth.signInHere')}</div>
    </div>
  );
};

export default DebugTranslations; 