import { IconName } from "@fortawesome/fontawesome-svg-core";
import { Image, Input, useMantineTheme } from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { fetchNui } from "../../utils/fetchNui";
import { Title } from "../Generic/Title";
import SideBar from "../Generic/SideBar";
import './Menu.module.css';
import { MenuItem, MenuItemProps } from "./MenuItem";
import SearchableContent from "./Searchable";
import { internalEvent } from "../../utils/internalEvent";

type MenuEventProps = {
  action: string
  menu: MenuProps
}

export type MenuProps = {
  title: string
  description?: string
  icon?: IconName | string
  canClose: boolean; 
  dialog?: string
  searchBar?: boolean
  menu: string
  watermark?: string
  clickSounds: boolean
  hoverSounds: boolean
  options: MenuItemProps[]
}

export default function Menu(){
    const [menuOpen, setMenuOpen] = useState<MenuProps | false>(false)
    const [search, setSearch] = useState<string>('')
    const theme = useMantineTheme();
    
    useNuiEvent('CONTEXT_MENU_STATE', function(data : MenuEventProps){
      if (data.action == 'OPEN'){
        setMenuOpen(data.menu)
      } else if (data.action == 'CLOSE'){
        setMenuOpen(false)
      } else if (data.action == 'UPDATE'){
        setMenuOpen(data.menu)
      }
    })

    const handleSearch = (e: React.ChangeEvent<HTMLInputElement>) => {
      setSearch(e.target.value)
    }

    // handle escaape key press
    useEffect(() => {
      const handleKeyPress = (e: KeyboardEvent) => {
        if (e.key === 'Escape' && menuOpen && menuOpen.canClose) {
          fetchNui('closeContext')
        }
      }

      window.addEventListener('keydown', handleKeyPress)
      return () => window.removeEventListener('keydown', handleKeyPress)
    }, [menuOpen])


    return (
      <>

        <SideBar 
          menuOpen={menuOpen} 
          setMenuOpen={setMenuOpen}
          escapeClose={menuOpen ? menuOpen.canClose : false}
          onClose={() => {
            fetchNui('closeContext')
          }}
          w='28vw' 
          h='100vh' 
          style={{
            // backdropFilter: 'blur(2px)',
            display:'flex',
            flexDirection:'column',
            justifyContent:'center',
            alignItems:'center',
            gap:'1rem',
            userSelect:'none',

          }}   
        >
          {menuOpen && 
            <>
              <Title 
                title={menuOpen.title} 
                description={menuOpen.description || ''} 
                icon={menuOpen.icon as IconName} 
                
                backButton={menuOpen.menu ? true : false}
                onBack={() => {
                  if (menuOpen.menu) {
                    fetchNui('openContext', {
                      back:true, 
                      id: menuOpen.menu
                    })
                  }
              
                  if (menuOpen.dialog) {
                    fetchNui('openDialog', {
                      id: menuOpen.dialog,
                      back:true,
                    })
                  }
                }}
              
                closeButton={menuOpen.canClose}
                onClose={() => {
                  setMenuOpen(false)
                  fetchNui('closeContext')
                }}
              />
            
              {menuOpen.searchBar &&
                  <Input 
                    w='65%'
                    size='md'
                    radius={theme.radius.xs}
                    styles={{
                      input:{
                        border:'1px solid var(--mantine-primary-color-9)',
                        background:'rgba(62,62,62,0.6)',
                      }
                    }}
                    placeholder='Search...'
                    onChange={handleSearch}
                  />
              }

              <SearchableContent searchTerm={search}>
                {menuOpen.options.map((option, index) => (
                  <MenuItem key={index} {...option} clickSounds={menuOpen.clickSounds} hoverSounds={menuOpen.hoverSounds}/>
                ))}
              </SearchableContent>
            </>
          }

          
          {menuOpen && menuOpen.watermark && 
            <>
              <Image src={menuOpen.watermark} w='6.5vh' h='6.5vh' 
                style={{
                  position:'absolute',
                  bottom:'1rem',
                  border:'1px solid var(--mantine-primary-color-9)',
                  borderRadius:'var(--mantine-radius-sm)',
                }}
              />
            </>
          }


        </SideBar>
         
      
      </>

    )
}

{/* <Image src='https://via.placeholder.com/150x150' w='6.5vh' h='6.5vh' 
          
style={{
  position:'absolute',
  bottom:'1rem',
  border:'1px solid var(--mantine-primary-color-9)',
  borderRadius:'var(--mantine-radius-sm)',
}}
/> */}

const test_menu = {
  title:'CALL OF HAGLER',
  description:'This is a test menu',
  icon:'gun',
  canClose:true,
  searchBar:true,
  clickSounds:true, 
  hoverSounds:true,
  // menu:'main',

  // watermark:'https://via.placeholder.com/150x150',

  options:[
    {
      title:'Find Ranked',
      icon:'search',
    },
    {
      title:'Private Game',
      icon:'https://callofdutymaps.com/wp-content/uploads/MW-m16a4.png',
      description:"Allows you to define the rules of the game will not affect your rank",
      image:  'https://callofdutymaps.com/wp-content/uploads/MW-m16a4.png',
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player',
      disabled:true,
    },
    {
      title:'Edit Classes',
      icon:'edit',
      arrow:true,
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player',
      progress:50,
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you cheese the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
    {
      title:'Edit Classes',
      disabled:true,
      backgroundImage: 'https://callofdutymaps.com/wp-content/uploads/MW-m16a4.png', 
      icon:'edit',
      description:'Allows you edit the classes for this player'
    },
  ]
}

internalEvent([
  {
    action:'CONTEXT_MENU_STATE',
    data:{
      action:'OPEN',
      menu:test_menu
    }
  }
])