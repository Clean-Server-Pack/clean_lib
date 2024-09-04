import React, { createContext, ReactNode, useContext, useEffect, useState } from 'react';
import { defaultSettings } from './default_settings';
import { SettingsProps } from './settings_props';
import { isEnvBrowser } from '../../utils/misc';
import { fetchNui } from '../../utils/fetchNui';
import { useNuiEvent } from '../../hooks/useNuiEvent';

// Create a context with default values
const SettingsContext = createContext<SettingsProps | undefined>(undefined);

// Create a provider component
export const SettingsProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [settings, setSettings] = useState<SettingsProps>(defaultSettings);

  useEffect(() => {
    if (!isEnvBrowser()) {
      fetchNui('GET_SETTINGS')
        .then((data) => {
          // Ensure data is of type SettingsProps
          setSettings(data as SettingsProps);
        }) 
        .catch((error) => {
          console.error('Failed to fetch settings:', error);
        });
    } else {
      console.warn('SettingsProvider: Not fetching settings from NUI');
    }
  }, []);

  useNuiEvent('UPDATE_SETTINGS', (data: SettingsProps) => {
    setSettings(data);
  });

  return (
    <SettingsContext.Provider value={settings}>
      {children}
    </SettingsContext.Provider>
  );
};

// Custom hook to use settings context
export const useSettings = (): SettingsProps => {
  const context = useContext(SettingsContext);
  if (context === undefined) {
    throw new Error('useSettings must be used within a SettingsProvider');
  }
  return context;
};

