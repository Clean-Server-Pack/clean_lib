import { Flex } from '@mantine/core';
import { useEffect, useState } from 'react';

interface BackgroundProps {
  children: React.ReactNode;
  display?: boolean;
}

export default function Background(props: BackgroundProps) {
  const [rawDisplay, setRawDisplay] = useState<boolean>(false);
  const [slide, setSlide] = useState<boolean>(false);

  useEffect(() => {
    if (props.display !== undefined) {
      setRawDisplay(props.display);
    }
  } , [props.display])

  useEffect(() => {
    if (rawDisplay) {
      setTimeout(() => {
        setSlide(true);
      }, 1)
    } else {
      setSlide(false);
    }
  }, [rawDisplay])

  return ( 
    // <BackgroundImage 
    //   w='100vw' h='100vh' 
    //   style={{overflow:'hidden'}}
    //   src="https://i.ytimg.com/vi/TOxuNbXrO28/maxresdefault.jpg"
    // > 
      <Flex
        direction='column'
        bg='rgba(0, 0, 0, 0.9)'
        
        w='100vw'
        h='fit-content'
        
        pos='absolute'
        bottom={slide ? 0 : '-50vh'}
        p='xs'
        align={'center'}
        style={{
          transition: 'all ease-in-out 0.3s',
          userSelect: 'none'
        }}
      >
        {props.children}
      </Flex>
    // </BackgroundImage>
  )
}