import { Box } from '@mantine/core'
import { useEffect, useState } from 'react'



type SideBarProps = {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  menuOpen: boolean | any
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  setMenuOpen?: any
  escapeClose?: boolean
  children: React.ReactNode
  style?: React.CSSProperties
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  onClose?: any
  w?: string
  h?: string
  pt?: string

  
}

function SideBar(props:SideBarProps){
  const setMenuOpen = props.setMenuOpen
  const [slideIn, setSlideIn] = useState(false)
  const [rawDisplay, setRawDisplay] = useState(false)

    //  Listen for escape key if menu can close
  useEffect(() => {
    if (props.menuOpen){
      setRawDisplay(true)
      setTimeout(() => {
        setSlideIn(true)
      }, 100)
    } else {
      setSlideIn(false)
      setTimeout(() => {
        setRawDisplay(false)
      }, 300)
    }
  }, [props.menuOpen])


  useEffect(() => {
    // listen for key here instead 
    const handleKeyPress = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && props.menuOpen && props.escapeClose) {
        if (props.onClose){
          props.onClose()
        }
        if (setMenuOpen){
          setMenuOpen(false)
        }
      }
    } 

    window.addEventListener('keydown', handleKeyPress)
    return () => window.removeEventListener('keydown', handleKeyPress)
  }, [props, setMenuOpen])

  return rawDisplay && (
    <Box
      pt={props.pt || '0'}
      pos='absolute'
      right={slideIn ? 0 : '-100%'}
      bg='linear-gradient(270deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 77%, rgba(36,36,36,0.4) 94%, rgba(0,0,0,0) 100%)'
      w={props.w}
      h={props.h}
      style={{
        transition: 'all ease-in-out 0.3s',
        ...props.style,
      }}
    >
      {props.children}
    </Box>
  ) 
}

export default SideBar