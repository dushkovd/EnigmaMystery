import React, { useEffect, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import AuthForm from '../components/AuthForm';
import { useLanguage } from '../context/LanguageContext';

const ResetPasswordPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const [token, setToken] = useState('');
  const { t } = useLanguage();
  const navigate = useNavigate();

  useEffect(() => {
    document.title = `${t('auth.resetPassword')} | Enigma Mysteries`;
    
    // Get token from URL parameters
    const resetToken = searchParams.get('token');
    if (resetToken) {
      setToken(resetToken);
    } else {
      // If no token, redirect to home
      navigate('/');
    }
  }, [searchParams, navigate, t]);

  const handleResetSuccess = () => {
    navigate('/');
  };

  return (
    <div className="pt-24 pb-16 min-h-screen bg-secondary-50">
      <div className="container-custom">
        <div className="max-w-md mx-auto">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <AuthForm
              onSuccess={handleResetSuccess}
              title={t('auth.resetPassword')}
            />
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export default ResetPasswordPage;