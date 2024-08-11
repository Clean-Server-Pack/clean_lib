import '@mantine/dates/styles.css';
import React from "react";
import "./App.css";
import Menu from './Menu/main';
import Clipboard from './Main/Clipboard';
import { BackgroundImage } from '@mantine/core';
import Quiz from './Quiz/main';
import Notification from './Notify/main';

const App: React.FC = () => {
  return (
    
    // <BackgroundImage w='100vw' h='100vh' style={{overflow:'hidden'}}
    //   src="https://i.ytimg.com/vi/TOxuNbXrO28/maxresdefault.jpg"
    // > 
    <>
      <Notification />
      <Menu />
      <Quiz />
      <Clipboard />
    </>
    // </BackgroundImage>
  );
};

export default App;
