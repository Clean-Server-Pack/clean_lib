import { createTheme } from "@mantine/core";

const theme = createTheme({
  primaryColor: "clean",
  primaryShade: 9,
  defaultRadius: "sm",
  fontFamily: "Akrobat, sans-serif",
  colors: {
    dark:[
      "#ffffff",
      "#e2e2e2",
      "#c6c6c6",
      "#aaaaaa",
      "#8d8d8d",
      "#717171",
      "#555555",
      "#393939",
      "#1c1c1c",
      "#000000",
    ],
    clean:[
      "#ffffff",
      "#f3fce9",
      "#dbf5bd",
      "#c3ee91",
      "#ace765",
      "#94e039",
      "#7ac61f",
      "#5f9a18",
      "#29420a",
      "#446e11",
    ],
  },
});


export default theme;