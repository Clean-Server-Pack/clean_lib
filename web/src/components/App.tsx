import '@mantine/dates/styles.css';
import React, { useEffect, useState } from "react";
import "./App.css";
import Menu from './Menu/main';
import { BackgroundImage, MantineProvider } from '@mantine/core';
import Quiz from './Quiz/main';
import Notifications from './Notify/main';
import { useSettings } from '../providers/settings/settings';
import theme from '../theme';
import Dialog from './Dialog/main';

const App: React.FC = () => {
  const [curTheme, setCurTheme] = useState(theme);
  const settings = useSettings();
  // Ensure the theme is updated when the settings change
  useEffect(() => {
    const cloned = { ...curTheme };
    console.log('new theme' + settings.primaryColor + settings.primaryShade);
    cloned.primaryColor = settings.primaryColor;
    cloned.primaryShade = settings.primaryShade;
    setCurTheme(cloned);
  }, [settings]);

  return (
    <MantineProvider theme={curTheme} defaultColorScheme='dark'>
      {/* <BackgroundImage w='100vw' h='100vh' style={{overflow:'hidden'}}
        src="https://i.ytimg.com/vi/TOxuNbXrO28/maxresdefault.jpg"
      >  */}
      <>
        <Notifications />
        <Menu />
        <Quiz />
        <Dialog />
      </>
      {/* </BackgroundImage> */}
    </MantineProvider>
  );
};

export default App;
