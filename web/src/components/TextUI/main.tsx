import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Text, Transition, useMantineTheme } from "@mantine/core";
import { useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { getPositionProps, getTranslate, PositionProps } from "../../utils/positioning";

type TextUIOptions = {
  position?: PositionProps
  icon?: string
  iconColor?: string
  iconAnimation?: string
  style?: React.CSSProperties
  alignIcon?: 'top' | 'center' | 'bottom'
}

export default function TextUI(){
  const theme = useMantineTheme()
  const [opened, setOpened] = useState(false)
  const [currentText, setCurrentText] = useState<string>('')
  const [options, setOptions] = useState<TextUIOptions>({
    icon: 'fa fa-bars',
    iconColor: 'white',
    iconAnimation: 'pulse',
    alignIcon: 'center',
  })


  useNuiEvent('SHOW_TEXT_UI', (data:{
    text: string
    options?: TextUIOptions
  }) => {
    setCurrentText(data.text)
    setOptions(data.options || {})
    setOpened(true) 

  })

  useNuiEvent('HIDE_TEXT_UI', () => {
    setOpened(false)
  })

  return (


    <Transition
      mounted={opened}
      transition="fade"
      duration={400}
      timingFunction="ease"
    >
      {(styles) => (
        <Flex
          pos='absolute'
          {...getPositionProps(options.position || 'bottom-center')}
          bg='rgba(0,0,0,0.5)'
          style={{
            ...styles,
            transform: getTranslate(options.position || 'bottom-center'),
            borderRadius: theme.radius.sm,
          }}
          p='xs'
          m='sm'
          justify={'center'}
          align='center'
          direction='column'
        > 
          <Flex
            gap='xs'
            align='center'

          >
            {options.icon && (
              <FontAwesomeIcon
                icon={options.icon as IconProp}
                color={options.iconColor}
                className={options.iconAnimation}
              />  
            )}

            <Text
              size="1.8vh"
            >{currentText}</Text>
          </Flex>

        </Flex>
      )}
    </Transition>
  )
}