/**
 * Protocol Configuration Utility
 * 
 * This utility helps manage the protocol (http:// vs https://) for different environments.
 * Use this when you need to switch between HTTP and HTTPS based on your deployment environment.
 */

export type Protocol = 'http://' | 'https://';

/**
 * Get the current protocol based on environment
 * @returns The current protocol to use
 */
export const getCurrentProtocol = (): Protocol => {
  // Check if we're in a secure context (HTTPS)
  if (typeof window !== 'undefined' && window.location.protocol === 'https:') {
    return 'https://';
  }
  
  // Check environment variable
  const envProtocol = import.meta.env.VITE_PROTOCOL;
  if (envProtocol === 'https://' || envProtocol === 'http://') {
    return envProtocol;
  }
  
  // Default to HTTP for development
  return 'http://';
};

/**
 * Update the protocol setting in the database
 * @param protocol - The protocol to set ('http://' or 'https://')
 * @returns Promise<boolean> - Whether the update was successful
 */
export const updateProtocolSetting = async (protocol: Protocol): Promise<boolean> => {
  try {
    const { supabase } = await import('../supabaseClient');
    
    const { error } = await supabase.rpc('update_protocol_setting', {
      new_protocol: protocol
    });
    
    if (error) {
      console.error('Failed to update protocol setting:', error);
      return false;
    }
    
    return true;
  } catch (error) {
    console.error('Error updating protocol setting:', error);
    return false;
  }
};

/**
 * Get the current protocol setting from the database
 * @returns Promise<string> - The current protocol setting
 */
export const getProtocolSetting = async (): Promise<string> => {
  try {
    const { supabase } = await import('../supabaseClient');
    
    const { data, error } = await supabase.rpc('get_current_protocol');
    
    if (error) {
      console.error('Failed to get protocol setting:', error);
      return 'http://'; // Default fallback
    }
    
    return data || 'http://';
  } catch (error) {
    console.error('Error getting protocol setting:', error);
    return 'http://'; // Default fallback
  }
};

/**
 * Initialize protocol setting based on current environment
 * This should be called once when the app starts
 */
export const initializeProtocolSetting = async (): Promise<void> => {
  try {
    const currentProtocol = getCurrentProtocol();
    const dbProtocol = await getProtocolSetting();
    
    // Only update if they don't match
    if (currentProtocol !== dbProtocol) {
      console.log(`Updating protocol setting from ${dbProtocol} to ${currentProtocol}`);
      await updateProtocolSetting(currentProtocol);
    }
  } catch (error) {
    console.error('Error initializing protocol setting:', error);
  }
};

/**
 * Create a URL with the correct protocol
 * @param host - The host (without protocol)
 * @param path - The path (optional)
 * @returns The full URL with correct protocol
 */
export const createUrl = (host: string, path: string = ''): string => {
  const protocol = getCurrentProtocol();
  return `${protocol}${host}${path}`;
};

/**
 * Check if the current environment supports HTTPS
 * @returns boolean - Whether HTTPS is supported
 */
export const supportsHttps = (): boolean => {
  return typeof window !== 'undefined' && window.location.protocol === 'https:';
};

/**
 * Get protocol recommendation for current environment
 * @returns string - Recommended protocol with explanation
 */
export const getProtocolRecommendation = (): { protocol: Protocol; reason: string } => {
  if (supportsHttps()) {
    return {
      protocol: 'https://',
      reason: 'Current environment supports HTTPS'
    };
  }
  
  return {
    protocol: 'http://',
    reason: 'Current environment does not support HTTPS'
  };
}; 