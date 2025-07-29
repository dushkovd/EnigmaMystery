// Analytics and Monitoring Configuration
// This file contains utilities for tracking user interactions and monitoring

declare global {
  interface Window {
    clarity: any;
  }
}

// Microsoft Clarity tracking
export const trackClarityEvent = (eventName: string, data?: any) => {
  if (typeof window !== 'undefined' && window.clarity) {
    window.clarity('event', eventName, data);
  }
};

// Track page views
export const trackPageView = (pageName: string) => {
  trackClarityEvent('page_view', { page: pageName });
};

// Track user interactions
export const trackUserAction = (action: string, details?: any) => {
  trackClarityEvent('user_action', { action, ...details });
};

// Track game interactions
export const trackGameEvent = (gameId: number, eventType: string, details?: any) => {
  trackClarityEvent('game_event', { 
    game_id: gameId, 
    event_type: eventType, 
    ...details 
  });
};

// Track purchase events
export const trackPurchase = (gameId: number, amount: number, currency: string = 'USD') => {
  trackClarityEvent('purchase', { 
    game_id: gameId, 
    amount, 
    currency 
  });
};

// Track errors
export const trackError = (error: Error, context?: any) => {
  trackClarityEvent('error', { 
    message: error.message, 
    stack: error.stack, 
    context 
  });
};

// Performance monitoring
export const trackPerformance = (metric: string, value: number) => {
  trackClarityEvent('performance', { metric, value });
};

// User engagement tracking
export const trackEngagement = (action: string, duration?: number) => {
  trackClarityEvent('engagement', { action, duration });
}; 