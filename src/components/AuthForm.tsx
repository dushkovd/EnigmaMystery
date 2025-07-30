import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Mail, Lock, ArrowLeft, CheckCircle, Eye, EyeOff } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useLanguage } from '../context/LanguageContext';

interface AuthFormProps {
  onSuccess?: () => void;
  onCancel?: () => void;
  showCancelButton?: boolean;
  title?: string;
  showRegister?: boolean;
  setShowRegister?: (show: boolean) => void;
}

type AuthStep = 'login' | 'forgotPassword' | 'resetPassword' | 'resetSuccess';

const AuthForm: React.FC<AuthFormProps> = ({ 
  onSuccess, 
  onCancel, 
  showCancelButton = false,
  title,
  showRegister: showRegisterProp,
  setShowRegister: setShowRegisterProp
}) => {
  const [step, setStep] = useState<AuthStep>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  // const [resetToken, setResetToken] = useState('');
  const [showRegisterState, setShowRegisterState] = useState(!!showRegisterProp);
  const showRegister = showRegisterProp !== undefined ? showRegisterProp : showRegisterState;
  const setShowRegister = setShowRegisterProp || setShowRegisterState;

  const { login, register } = useAuth();
  const { t } = useLanguage();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    if (!email || !password) {
      setError(t('common.fillRequired'));
      setLoading(false);
      return;
    }

    try {
      await login(email, password);
      onSuccess?.();
    } catch (err) {
      setError(t('auth.invalidCredentials'));
    } finally {
      setLoading(false);
    }
  };

  const handleForgotPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    if (!email) {
      setError(t('common.fillRequired'));
      setLoading(false);
      return;
    }

    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      setStep('resetSuccess');
    } catch (err) {
      setError(t('common.error'));
    } finally {
      setLoading(false);
    }
  };

  const handleResetPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    if (!newPassword || !confirmPassword) {
      setError(t('common.fillRequired'));
      setLoading(false);
      return;
    }

    if (newPassword !== confirmPassword) {
      setError(t('auth.passwordMismatch'));
      setLoading(false);
      return;
    }

    if (newPassword.length < 6) {
      setError(t('auth.passwordTooShort'));
      setLoading(false);
      return;
    }

    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      setStep('login');
      setNewPassword('');
      setConfirmPassword('');
      setError('');
      // Show success message
      setTimeout(() => {
        setError(t('auth.passwordResetSuccess'));
      }, 100);
    } catch (err) {
      setError(t('common.error'));
    } finally {
      setLoading(false);
    }
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    if (!email || !password) {
      setError(t('common.fillRequired'));
      setLoading(false);
      return;
    }
    if (password.length < 6) {
      setError(t('auth.passwordTooShort'));
      setLoading(false);
      return;
    }
    try {
      await register(email, password);
      onSuccess?.();
    } catch (err) {
      setError(t('auth.registrationFailed'));
    } finally {
      setLoading(false);
    }
  };

  const renderLoginForm = () => (
    <motion.form
      onSubmit={handleLogin}
      initial={{ opacity: 0, x: 10 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: -10 }}
      transition={{ duration: 0.3 }}
    >
      <div className="form-group">
        <label htmlFor="email" className="label">
          <Mail className="w-4 h-4 inline mr-2" />
          {t('auth.email')}
        </label>
        <input
          type="email"
          id="email"
          className="input"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder={t('auth.emailPlaceholder')}
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="password" className="label">
          <Lock className="w-4 h-4 inline mr-2" />
          {t('auth.password')}
        </label>
        <div className="relative">
          <input
            type={showPassword ? 'text' : 'password'}
            id="password"
            className="input pr-10"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder={t('auth.passwordPlaceholder')}
            required
          />
          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-secondary-400 hover:text-secondary-600"
          >
            {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>

      <div className="mb-4">
        <button
          type="button"
          onClick={() => setStep('forgotPassword')}
          className="text-sm text-primary-600 hover:text-primary-700 transition-colors"
        >
          {t('auth.forgotPassword')}
        </button>
      </div>

      {error && (
        <div className="mb-4 p-3 bg-error-50 text-error-600 rounded border border-error-100">
          {error}
        </div>
      )}

      <div className="flex gap-3">
        {showCancelButton && (
          <button
            type="button"
            onClick={onCancel}
            className="btn-outline flex-1"
          >
            {t('common.cancel')}
          </button>
        )}
        <button
          type="submit"
          className="btn-primary flex-1"
          disabled={loading}
        >
          {loading ? t('auth.signingIn') : t('auth.signIn')}
        </button>
      </div>
    </motion.form>
  );

  const renderForgotPasswordForm = () => (
    <motion.form
      onSubmit={handleForgotPassword}
      initial={{ opacity: 0, x: 10 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: -10 }}
      transition={{ duration: 0.3 }}
    >
      <div className="mb-6">
        <button
          type="button"
          onClick={() => setStep('login')}
          className="flex items-center text-secondary-600 hover:text-secondary-800 transition-colors mb-4"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          {t('auth.backToLogin')}
        </button>
        <p className="text-secondary-600 text-sm">
          {t('auth.forgotPasswordDesc')}
        </p>
      </div>

      <div className="form-group">
        <label htmlFor="resetEmail" className="label">
          <Mail className="w-4 h-4 inline mr-2" />
          {t('auth.email')}
        </label>
        <input
          type="email"
          id="resetEmail"
          className="input"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder={t('auth.emailPlaceholder')}
          required
        />
      </div>

      {error && (
        <div className="mb-4 p-3 bg-error-50 text-error-600 rounded border border-error-100">
          {error}
        </div>
      )}

      <button
        type="submit"
        className="btn-primary w-full"
        disabled={loading}
      >
        {loading ? t('auth.sendingEmail') : t('auth.sendResetEmail')}
      </button>
    </motion.form>
  );

  const renderResetSuccessMessage = () => (
    <motion.div
      className="text-center"
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 0.9 }}
      transition={{ duration: 0.3 }}
    >
      <div className="mb-6">
        <div className="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <CheckCircle className="w-8 h-8 text-success-600" />
        </div>
        <h3 className="text-xl font-display font-bold mb-2">{t('auth.emailSent')}</h3>
        <p className="text-secondary-600 mb-4">
          {t('auth.emailSentDesc')}
        </p>
        <p className="text-sm text-secondary-500">
          {t('auth.checkSpam')}
        </p>
      </div>

      <button
        onClick={() => setStep('login')}
        className="btn-primary"
      >
        {t('auth.backToLogin')}
      </button>
    </motion.div>
  );

  const renderResetPasswordForm = () => (
    <motion.form
      onSubmit={handleResetPassword}
      initial={{ opacity: 0, x: 10 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: -10 }}
      transition={{ duration: 0.3 }}
    >
      <div className="mb-6">
        <h3 className="text-xl font-display font-bold mb-2">{t('auth.resetPassword')}</h3>
        <p className="text-secondary-600 text-sm">
          {t('auth.resetPasswordDesc')}
        </p>
      </div>

      <div className="form-group">
        <label htmlFor="newPassword" className="label">
          <Lock className="w-4 h-4 inline mr-2" />
          {t('auth.newPassword')}
        </label>
        <div className="relative">
          <input
            type={showNewPassword ? 'text' : 'password'}
            id="newPassword"
            className="input pr-10"
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            placeholder={t('auth.newPasswordPlaceholder')}
            required
          />
          <button
            type="button"
            onClick={() => setShowNewPassword(!showNewPassword)}
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-secondary-400 hover:text-secondary-600"
          >
            {showNewPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>

      <div className="form-group">
        <label htmlFor="confirmPassword" className="label">
          <Lock className="w-4 h-4 inline mr-2" />
          {t('auth.confirmPassword')}
        </label>
        <div className="relative">
          <input
            type={showConfirmPassword ? 'text' : 'password'}
            id="confirmPassword"
            className="input pr-10"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            placeholder={t('auth.confirmPasswordPlaceholder')}
            required
          />
          <button
            type="button"
            onClick={() => setShowConfirmPassword(!showConfirmPassword)}
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-secondary-400 hover:text-secondary-600"
          >
            {showConfirmPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>

      {error && (
        <div className="mb-4 p-3 bg-error-50 text-error-600 rounded border border-error-100">
          {error}
        </div>
      )}

      <button
        type="submit"
        className="btn-primary w-full"
        disabled={loading}
      >
        {loading ? t('auth.updatingPassword') : t('auth.updatePassword')}
      </button>
    </motion.form>
  );

  const renderRegisterForm = () => (
    <motion.form
      onSubmit={handleRegister}
      initial={{ opacity: 0, x: 10 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: -10 }}
      transition={{ duration: 0.3 }}
    >
      <div className="form-group">
        <label htmlFor="registerEmail" className="label">
          <Mail className="w-4 h-4 inline mr-2" />
          {t('auth.email')}
        </label>
        <input
          type="email"
          id="registerEmail"
          className="input"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder={t('auth.emailPlaceholder')}
          required
        />
      </div>
      <div className="form-group">
        <label htmlFor="registerPassword" className="label">
          <Lock className="w-4 h-4 inline mr-2" />
          {t('auth.password')}
        </label>
        <div className="relative">
          <input
            type={showPassword ? 'text' : 'password'}
            id="registerPassword"
            className="input pr-10"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder={t('auth.passwordPlaceholder')}
            required
          />
          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-secondary-400 hover:text-secondary-600"
          >
            {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>
      {error && (
        <div className="mb-4 p-3 bg-error-50 text-error-600 rounded border border-error-100">
          {error}
        </div>
      )}
      <div className="mb-4 text-xs text-secondary-500 text-center">
        {t('auth.termsAccept')} <a href="/terms" className="underline text-primary-600 hover:text-primary-800" target="_blank" rel="noopener noreferrer">{t('auth.termsAndConditions')}</a> {t('auth.termsOfThisPage')} // TODO: Fix translations
      </div>
      <div className="flex gap-3">
        {showCancelButton && (
          <button
            type="button"
            onClick={onCancel}
            className="btn-outline flex-1"
          >
            {t('common.cancel')}
          </button>
        )}
        <button
          type="submit"
          className="btn-primary flex-1"
          disabled={loading}
        >
          {loading ? t('auth.signingUp') : t('auth.signUp')}
        </button>
      </div>
      <div className="mt-4 text-center">
        <button type="button" className="text-primary-600 hover:underline" onClick={() => setShowRegister(false)}>
          {t('auth.alreadyHaveAccount')} {t('auth.signInHere')}
        </button>
      </div>
    </motion.form>
  );

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden">
      <div className="p-6 border-b border-secondary-100">
        <h2 className="text-2xl font-display font-bold">
          {title || (showRegister ? t('auth.signUp') : (step === 'forgotPassword' ? t('auth.forgotPassword') : step === 'resetPassword' ? t('auth.resetPassword') : t('auth.signIn')))}
        </h2>
      </div>
      <div className="p-6">
        <AnimatePresence mode="wait">
          {showRegister ? renderRegisterForm() : (
            <>
          {step === 'login' && renderLoginForm()}
          {step === 'forgotPassword' && renderForgotPasswordForm()}
          {step === 'resetSuccess' && renderResetSuccessMessage()}
          {step === 'resetPassword' && renderResetPasswordForm()}
              <div className="mt-4 text-center">
                <button type="button" className="text-primary-600 hover:underline" onClick={() => setShowRegister(true)}>
                  {t('auth.dontHaveAccount')} {t('auth.registerHere')}
                </button>
              </div>
            </>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
};

export default AuthForm;