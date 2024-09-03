import { MantineProvider } from '@mantine/core';
import '@mantine/dates/styles.css';
import React, { useEffect, useState } from "react";
import { useNuiEvent } from '../hooks/useNuiEvent';
import { useSettings } from '../providers/settings/settings';
import theme from '../theme';
import "./App.css";
import Dialog from './Dialog/main';
import Menu from './Menu/main';
import Notifications from './Notify/main';
import Quiz from './Quiz/main';

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

  useNuiEvent('COPY_TO_CLIPBOARD', (data: string) => {
    const el = document.createElement('textarea');
    el.value = data;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
  });

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
