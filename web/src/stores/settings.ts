import { MantineColor, MantineColorShade, MantineColorsTuple } from "@mantine/core";
import { create } from "zustand";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";

export type SettingsProps = {
  primaryColor: MantineColor;
  primaryShade: MantineColorShade;
  customTheme: MantineColorsTuple;
  itemImgPath: string;
  fetchSettings: () => void;
  // Add more settings here
};

export const useSettings = create<SettingsProps>((set) => ({
  primaryColor:'clean', 
  primaryShade: 9,
  itemImgPath: 'nui://clean_inventory/web/images/',
  customTheme: [
    "#f8edff",
    "#e9d9f6",
    "#d0b2e8",
    "#b588da",
    "#9e65cf",
    "#914ec8",
    "#8a43c6",
    "#7734af",
    "#692d9d",
    "#5c258b"
  ],

  fetchSettings: () => {
    if (!isEnvBrowser()) {
      fetchNui<{
        primaryColor: string;
        primaryShade: MantineColorShade;
        customTheme: MantineColorsTuple;
      }>('GET_SETTINGS')
        .then((data) => {
          // Ensure data is of type SettingsProps
          if (data.primaryColor && data.primaryShade && data.customTheme) {
            set({
              primaryColor: data.primaryColor,
              primaryShade: data.primaryShade,
              customTheme: data.customTheme
            });
          } else {
            console.error('SettingsProvider: Invalid settings data received from NUI:', data);
          }
        }) 
        .catch((error) => {
          console.error('Failed to fetch settings:', error);
        });
    } else {
      console.warn('SettingsProvider: Not fetching settings from NUI');
    }
  }, 
  
  
  // Add more default settings here
}));