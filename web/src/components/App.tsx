import '@mantine/dates/styles.css';
import React from "react";
import "./App.css";
import Menu from './Menu/main';
import { BackgroundImage } from '@mantine/core';
import Quiz from './Quiz/main';

const App: React.FC = () => {
  return (
    
    // <BackgroundImage w='100vw' h='100vh' style={{overflow:'hidden'}}
    //   src="https://i.ytimg.com/vi/TOxuNbXrO28/maxresdefault.jpg"
    // > 
    <>
      <Menu />
      <Quiz />
    </>
    // </BackgroundImage>
  );
};

export default App;
