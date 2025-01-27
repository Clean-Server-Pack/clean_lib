import { Flex, Transition } from '@mantine/core';

interface BackgroundProps {
  children: React.ReactNode;
  display?: boolean;
}

export default function Background(props: BackgroundProps) {

  return ( 

    <Transition
      duration={400}
      timingFunction="ease"
      transition="fade"
      mounted={props.display !== undefined ? props.display : true}
    >
      {(styles) => (
        <Flex
          direction='column'
          bg='rgba(0, 0, 0, 0.9)'
          w='100vw'
          h='100vh'
          p='7rem'
          align={'center'}
          style={{
            transition: 'all ease-in-out 0.3s',
            userSelect: 'none',
            ...styles
          }}
        >
          {props.children}
        </Flex>



      )}
    </Transition>
  )
}