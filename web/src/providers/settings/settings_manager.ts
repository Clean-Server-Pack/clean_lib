// settingsManager.ts
import { SettingsProps } from './default_settings';
import { defaultSettings } from './default_settings';
import { fetchNui } from '../../utils/fetchNui';
import { isEnvBrowser } from '../../utils/misc';

let settings: SettingsProps = defaultSettings;

export const getSettings = (): SettingsProps => settings;

export const fetchAndSetSettings = async (): Promise<void> => {
  if (!isEnvBrowser()) {
    try {
      const fetchedSettings = await fetchNui('GET_SETTINGS');
      settings = fetchedSettings as SettingsProps;
    } catch (error) {
      console.error('Failed to fetch settings:', error);
    }
  } else {
    console.warn('settingsManager: Not fetching settings from NUI');
  }
};

export const updateSettings = (newSettings: SettingsProps): void => {
  settings = newSettings;
};
