export const defaultSettings: SettingsProps = {
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
  // Add more default settings here
};

import { MantineColor, MantineColorShade, MantineColorsTuple } from "@mantine/core";

export type SettingsProps = {
  primaryColor: MantineColor;
  primaryShade: MantineColorShade;
  customTheme: MantineColorsTuple;
  itemImgPath: string;
  // Add more settings here
};