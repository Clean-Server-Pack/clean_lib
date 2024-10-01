import { BackgroundImage, MantineProvider } from '@mantine/core';
import '@mantine/dates/styles.css';
import React, { useEffect, useState } from "react";
import { useNuiEvent } from '../hooks/useNuiEvent';
import { useSettings } from '../providers/settings/settings';
import theme from '../theme';
import { isEnvBrowser } from '../utils/misc';

import Dialog from './Dialog/main';
import Input from './Input/main';
import Menu from './Menu/main';
import Notifications from './Notify/main';
import Quiz from './Quiz/main';
import KeyInputs from './KeyInputs/main';

const App: React.FC = () => {
  const [curTheme, setCurTheme] = useState(theme);
  const settings = useSettings();
  // Ensure the theme is updated when the settings change

  useEffect(() => {
    const updatedTheme = {
      ...theme, // Start with the existing theme object
      colors: {
        ...theme.colors, // Copy the existing colors
        custom: settings.customTheme
      },
    };
    
    setCurTheme(updatedTheme);

    // set primary color
    setCurTheme({
      ...updatedTheme,
      primaryColor: settings.primaryColor,
      primaryShade: settings.primaryShade,
    });

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
      <Wrapper>
        <Notifications />
        <Menu />
        <Quiz />
        <Dialog />
        <Input />
        <KeyInputs />
      </Wrapper>
    </MantineProvider>
  );
};

export default App;


function Wrapper({ children }: { children: React.ReactNode }) {
  return isEnvBrowser() ? ( 
    <BackgroundImage w='100vw' h='100vh' style={{overflow:'hidden'}}
      src="https://i.ytimg.com/vi/TOxuNbXrO28/maxresdefault.jpg"
    >  
      {children}
    </BackgroundImage>
  ) : (
    <>{children}</>
  )
}