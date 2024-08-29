import { IconProp } from "@fortawesome/fontawesome-svg-core"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { Box, Flex, Image, Text, useMantineTheme } from "@mantine/core"
import colorWithAlpha from "../../utils/colorWithAlpha"
import { useEffect, useMemo, useState } from "react"

export type NotificationProps = {
  title?: string
  description?: string
  duration?: number
  showDuration?: boolean
  position: 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right'
  type?: 'info' | 'success' | 'warning' | 'error'
  icon?: string
  iconColor?: string
  iconAnimation?: string
  
  
  // FOR UI 
  hide?: boolean
  count?: number
}

export default function Notification(props: NotificationProps){
  const theme = useMantineTheme();
  const [display, setDisplay] = useState(false)
  const [amountEffect, setAmountEffect] = useState(false) // For the amount effect

  const is_icon = useMemo(() => {
    //  CHECK IF IS A HTTPS STRING
    if (typeof props.icon === 'string' && props.icon.startsWith('https')) {
      return false;
    }
    return true;
  }, [props.icon]);


  useEffect(() => {
    if (props.count && !amountEffect) {
      setAmountEffect(true)
      setTimeout(() => {
        setAmountEffect(false)
      }, 500)
    }
  }, [props.count])

  useEffect(() => {
    if (!props.hide) { 
      setTimeout(() => {
        setDisplay(true)
      }, 500)
    } else {
      setDisplay(false)
    }
  }, [props.hide])
  return (
    <Box 
      style={{ 
        position: 'relative',
        transition: 'all 0.3s ease-in-out',
      }} 
      w="100%"
      right={props.position.includes('right') ? !display ? '-150%' : '0': 'auto'}
      left={props.position.includes('left') ? !display  ? '-150%' : '0': 'auto'}
      top={props.position.includes('top') ? !display  ? '-150%' : '0': 'auto'}
      bottom={props.position.includes('bottom') ? !display  ? '-150%' : '0': 'auto'}
    
    >
      {/* Box for the number */}
      {props.count && (
        <Box
          style={{
            position: 'absolute',
            top: '-8%',
            right: '-5px',
            backgroundColor: colorWithAlpha(theme.colors[theme.primaryColor][9], 0.7),
            color: 'white',
            borderRadius: theme.radius.xs,
            padding: '0rem 0.4rem',  
            fontSize: '0.9rem',
            fontWeight: 700,
            textAlign: 'center',
            transform: amountEffect ? 'scale(1.2)' : 'scale(1)',
            transition: 'all 0.3s ease-in-out',
            zIndex: 1000, // Ensure it is above other content
          }}
        >
          <Text size='xs'>{props.count}</Text>
        </Box> 
      )}

      <Flex
        
        bg='rgba(0,0,0,0.6)'
        p='xs'
        style={{
          borderRadius: theme.radius.xs,
        }}
        align='center'
        gap='xs'
      >

      <Flex
        direction={'column'}
        style={{
          backgroundColor: colorWithAlpha(props.iconColor || theme.colors[theme.primaryColor][9], 0.3),
          padding: theme.spacing.xs,
          borderRadius: theme.radius.xs,
          border: `2px solid ${colorWithAlpha(props.iconColor || theme.colors[theme.primaryColor][9], 0.9)}`,
          boxShadow: `0 0 5px ${colorWithAlpha(props.iconColor || theme.colors[theme.primaryColor][9], 0.9)}`,
        }} 
      >
        {props.icon && is_icon && (
          <FontAwesomeIcon 
            icon={props.icon as IconProp || 'fas fa-info-circle' as IconProp} 
            size='2x'
            color={colorWithAlpha(props.iconColor || theme.colors[theme.primaryColor][9], 1)}
          />
        )}

        {props.icon && !is_icon && (
          <Image 
            src={props.icon}
            alt='icon'
            h='2.7em'
          />

        )}

      </Flex>


        <Flex
          direction='column'
        >
          <Text
            size="lg"
            c={theme.colors[theme.primaryColor][9]}
            style={{
              fontFamily: 'Akrobat Bold',
              lineHeight: '1.2rem',
              textShadow: `0 0 8px ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.9)}`
            }}
          >{props.title}</Text>
          <Text
            c='rgba(255,255,255,0.6)'
            style={{
              lineHeight: '1rem',
            }}
          >{props.description}</Text>
        </Flex>
      </Flex>
    </Box>
  )
}