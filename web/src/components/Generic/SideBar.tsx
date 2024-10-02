import { Box, Transition, useMantineTheme } from '@mantine/core'



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

  
}

function SideBar(props:SideBarProps){
  const setMenuOpen = props.setMenuOpen
    //  Listen for escape key if menu can close
  window.onkeydown = (e) => {
    if (props.menuOpen && props.escapeClose && e.key === 'Escape') {
      setMenuOpen(false)
      props.onClose()
    }
  }

  // insert transtion to style if exists or creatre style with transtion if not   

  return (
    <Transition
      mounted={props.menuOpen}
      transition='slide-left'
      duration={300}
      timingFunction='ease'
    >
      {(transitionStyles) => (
        <Box
          pos='absolute'
          right={0}
          //bg={getGradient({ from: 'rgba(0,0,0,0.3)', to: colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.2), deg: 360 }, theme)}
          bg='linear-gradient(211deg, rgba(0,0,0,1) 0%, rgba(0,0,0,0.75) 27%, rgba(36,36,36,0.55) 47%, rgba(0,0,0,0) 100%)'
          w={props.w}
          h={props.h}
          style={{
            ...props.style,
            ...transitionStyles,
          }}
        >
    
          {props.children}
        </Box>
      )}
    </Transition>
  ) 
}

export default SideBar

// w='23vw'
// h='100vh'  
// // {
//   background:`linear-gradient(90deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.302621947216386) 16%, rgba(0,0,0,0.6) 46%, rgba(0,0,0,0.8) 100%)`,
//   // backdropFilter: 'blur(2px)',
//   display:'flex',
//   flexDirection:'column',
//   justifyContent:'center',
//   alignItems:'center',
//   gap:'1rem',
//   userSelect:'none',
//   transition : 'all ease-in-out 0.2s',
// }