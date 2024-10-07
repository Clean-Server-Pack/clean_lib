export const defaultSettings: SettingsProps = {
  primaryColor:'clean', 
  primaryShade: 9,
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

  locales: {
    CancelProgress: "Cancelled"
  },
  // Add more default settings here
};

import { MantineColor, MantineColorShade, MantineColorsTuple } from "@mantine/core";

export type SettingsProps = {
  primaryColor: MantineColor;
  primaryShade: MantineColorShade;
  customTheme: MantineColorsTuple;
  locales: {
    [key: string]: string;
  };
  // Add more settings here
};