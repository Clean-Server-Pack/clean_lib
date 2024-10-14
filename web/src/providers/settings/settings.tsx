// SettingsProvider.tsx
import React, { createContext, ReactNode, useContext, useEffect, useState } from 'react';
import { SettingsProps } from './default_settings';
import { fetchAndSetSettings, updateSettings, getSettings } from './settings_manager';
import { useNuiEvent } from '../../hooks/useNuiEvent';

const SettingsContext = createContext<SettingsProps | undefined>(undefined);

export const SettingsProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [settings, setSettings] = useState<SettingsProps>(getSettings());

  useEffect(() => {
    fetchAndSetSettings().then(() => setSettings(getSettings()));
  }, []);

  useNuiEvent('UPDATE_SETTINGS', (data: SettingsProps) => {
    updateSettings(data);
    setSettings(data);
  });

  return (
    <SettingsContext.Provider value={settings}>
      {children}
    </SettingsContext.Provider>
  );
};

export const useSettings = (): SettingsProps => {
  const context = useContext(SettingsContext);
  if (context === undefined) {
    throw new Error('useSettings must be used within a SettingsProvider');
  }
  return context;
};
