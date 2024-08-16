import { Flex } from '@mantine/core';
import { useEffect, useState } from 'react';

interface BackgroundProps {
  children: React.ReactNode;
  display?: boolean;
}

export default function Background(props: BackgroundProps) {
  const [rawDisplay, setRawDisplay] = useState<boolean>(false);
  const [opacity, setOpacity] = useState<number>(0);

  useEffect(() => {
    if (props.display !== undefined) {
      setRawDisplay(props.display);
    }
  } , [props.display])

  useEffect(() => {
    if (rawDisplay) {
      setTimeout(() => {
        setOpacity(1);
      }, 100)
    } else {
      setOpacity(0);
    }
  }, [rawDisplay])

  return rawDisplay && ( 
    // <BackgroundImage 
    //   w='100vw' h='100vh' 
    //   style={{overflow:'hidden'}}
    //   src="https://i.ytimg.com/vi/TOxuNbXrO28/maxresdefault.jpg"
    // > 
      <Flex
        direction='column'
        bg='rgba(0, 0, 0, 0.9)'
        opacity={opacity}
        w='100vw'
        h='100vh'
        p='7rem'
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