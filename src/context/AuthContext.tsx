import React, { createContext, useContext, useState, ReactNode } from 'react';
import { supabase } from '../supabaseClient.js';
import { useEffect } from 'react';
import { AuthChangeEvent, Session } from '@supabase/supabase-js';


interface User {
  id: string;
  email: string;
}

interface AuthContextType {
  user: User | null;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  register: (email: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  loading: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(false);

  const login = async (email: string, password: string) => {
    setLoading(true);
    try {
      const { data, error } = await supabase.auth.signInWithPassword({ email, password });

      if (error) throw error;
      if (!data.session || !data.user) throw new Error('No user session returned');

      setUser({
        id: data.user.id,
        email: data.user.email || '',
      });
    } catch (error) {
      console.error('Login error:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const waitForUserRow = async (userId: string, maxAttempts = 10, delayMs = 200) => {
    for (let i = 0; i < maxAttempts; i++) {
      const { data, error } = await supabase
        .from('Users')
        .select('user_id')
        .eq('user_id', userId)
        .single();
      if (data && data.user_id === userId) {
        return true;
      }
      await new Promise(res => setTimeout(res, delayMs));
    }
    throw new Error('User row not found in Users table after registration.');
  };

  const register = async (email: string, password: string) => {
    setLoading(true);
    try {
      const { data, error } = await supabase.auth.signUp({ email, password });

      if (error) throw error;
      if (!data.user) throw new Error('No user returned');

      // Create user record in Users table
      const { error: createError } = await supabase.rpc('create_user_record');
      if (createError) {
        console.error('Error creating user record:', createError);
        // Continue anyway - the user is still created in auth.users
      }

      // Wait for the user row to appear in Users table (fallback)
      await waitForUserRow(data.user.id);

      setUser({
        id: data.user.id,
        email: data.user.email || '',
      });
    } catch (error) {
      console.error('Registration error:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const logout = async () => {
    await supabase.auth.signOut();
    setUser(null);
  };

  useEffect(() => {
    const getSession = async () => {
      setLoading(true);
      try {
        const {
          data: { session },
        } = await supabase.auth.getSession();

        if (session?.user) {
          setUser({
            id: session.user.id,
            email: session.user.email || '',
          });
        }
      } finally {
        setLoading(false);
      }
    };

    getSession();

    const { data: listener } = supabase.auth.onAuthStateChange((_event: AuthChangeEvent, session: Session | null) => {
      if (session?.user) {
        setUser({
          id: session.user.id,
          email: session.user.email || '',
        });
      } else {
        setUser(null);
      }
    });

    return () => {
      listener?.subscription?.unsubscribe();
    };
  }, []);

  const value = {
    user,
    isAuthenticated: !!user,
    login,
    register,
    logout,
    loading
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}