import { Flex, Transition } from '@mantine/core';

interface BackgroundProps {
  children: React.ReactNode;
  display?: boolean;
}

export default function Background(props: BackgroundProps) {
  return ( 
    <Transition
      duration={500}
      timingFunction='ease'
      transition='slide-up'
      mounted={props.display !== undefined ? props.display : true}
    >
      {(styles) => (
        <Flex
          direction='column'
          bg='linear-gradient(0deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 65%, rgba(36,36,36,0.4) 77%, rgba(0,0,0,0) 100%)'
          w='100vw'
          // h='fit-content'
          h='38vh'
          pos='absolute'
          bottom={0}
          p='2vh'
          align={'center'}
          style={{
            userSelect: 'none',
            ...styles,
          }}
        >
          {props.children}
        </Flex>
      )}
    </Transition>
  )
}