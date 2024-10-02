import { Flex, Transition } from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
// eslint-disable-next-line
import { internalEvent } from "../../utils/internalEvent";
import { getPositionProps, getTranslate, PositionProps } from "../../utils/positioning";
import KeyIcon from "./KeyButton";
import { KeyLabel } from "./KeyLabel";

export type KeyInputProps = {
  qwerty: string
  label: string
  icon: string
  delay?: number
  hidden?: boolean
  pressed?: boolean
}


export default function KeyInputs(){
  const [display, setDisplay] = useState<boolean>(false)
  const [position, setPosition] = useState<PositionProps>('right-center')
  // eslint-disable-next-line
  const [pressedKeys, setPressedKeys] = useState<string[]>([])
  const [keyInputs, setKeyInputs] = useState<KeyInputProps[]>([
    { qwerty: 'F1', label: 'Open Menu', icon: 'fa fa-bars', delay: 1000 },
    { qwerty: 'F2', label: 'Open Inventoryasdasdsadasdasdasddsasdasdsaasdasdsddasdasddsdsad', icon: 'fa fa-box' },
  ])

  useNuiEvent('SET_KEY_INPUTS', (data: {
    position: PositionProps
    inputs: KeyInputProps[]
  }) => {
    setPosition(data.position)
    setKeyInputs(data.inputs) 
    setDisplay(true)
  })

  useNuiEvent('HIDE_KEY_INPUTS', () => {
    setDisplay(false)
  })

  
  // redo useEffect for the .qwerty key
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (!display) return;
      if (e.key !== 'F12' && e.key !== 'F5') e.preventDefault();
      
      const key = e.key.toUpperCase(); // Convert to uppercase
  
      setPressedKeys((prevKeys) => {
        if (prevKeys.includes(key) || prevKeys.includes(e.key)) return prevKeys; // Prevent duplicates
        return [...prevKeys, key]; // Append the new key
      });
    }

    const handleKeyUp = (e: KeyboardEvent) => {
      if (!display) return;
      if (e.key !== 'F12' && e.key !== 'F5') e.preventDefault();
  
      const key = e.key.toUpperCase(); // Convert to uppercase
      setPressedKeys((prevKeys) => prevKeys.filter((k) => k !== key)); // Remove the released key
    }

    window.addEventListener('keydown', handleKeyDown);
    window.addEventListener('keyup', handleKeyUp);

    return () => {
      window.removeEventListener('keydown', handleKeyDown);
      window.removeEventListener('keyup', handleKeyUp);
    }
  }, [])

  return (
<Transition
  mounted={display}
  transition={'fade'}
  duration={400}
  timingFunction="ease"
>
  {(styles) => (
    <Flex
      pos='absolute'
      gap='xs'
      p='xs'
      {...getPositionProps(position)}
      style={{
        ...styles, // Keep Mantine's animation styles
        transform: getTranslate(position), // Custom transform logic
      }}
      direction={'column'}
      justify={'center'}
    >
      {keyInputs.map((keyInput, index) => (
        !keyInput.hidden && 
        <Flex 
          key={index}
          gap='xs'
          align={'center'}
        >
          <KeyIcon _key={keyInput.qwerty} pressed={keyInput.pressed} />
          <KeyLabel {...keyInput} pressed={keyInput.pressed} />
        </Flex>
      ))}
    </Flex>
  )}
</Transition>

  )
}


// internalEvent([
//   {
//     action: 'SET_KEY_INPUTS',
//     data: {
//       inputs: [
//         { qwerty: 'F1', label: 'Open Menu', icon: 'fa fa-bars', delay: 1000 },
        
//       ],

//       position: 'bottom-center'
//     }
//   }
// ])

// setTimeout(() => {

//   internalEvent([
//     {
//       action: 'HIDE_KEY_INPUTS',
//     }
//   ])
// }, 5000)