import { IconName } from "@fortawesome/fontawesome-svg-core";
import { Box, Image, Input } from "@mantine/core";
import { useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { internalEvent } from "../../utils/internalEvent";
import './Menu.module.css';
import { MenuItem, MenuItemProps } from "./MenuItem";
import { MenuTitle } from "./MenuTitle";
import SearchableContent from "./Searchable";
import { fetchNui } from "../../utils/fetchNui";
import SideBar from "../Main/SideBar";

type MenuEventProps = {
  action: string
  menu: MenuProps
}

export type MenuProps = {
  title: string
  icon: IconName | string
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



    return (
      <>

        <SideBar 
          menuOpen={menuOpen} 
          setMenuOpen={setMenuOpen}
          escapeClose={menuOpen ? menuOpen.canClose : false}
          onClose={() => {
            fetchNui('closeContext')
          }}
          w='23vw' 
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
              <MenuTitle title={menuOpen.title} icon={menuOpen.icon} menu={menuOpen.menu} canClose={menuOpen.canClose} setMenuOpen={setMenuOpen} dialog={menuOpen.dialog}/>
              {menuOpen.searchBar &&
                  <Input 
                    w='65%'
                    bg='rgba(0,0,0,0.5)'
                    styles={{
                      input:{
                        background:'rgba(0,0,0,0.5)',
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
  icon:'gun',
  canClose:true,
  searchBar:true,
  clickSounds:true, 
  hoverSounds:false,
  menu:'main',

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
      description:'Allows you edit the classes for this player'
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

// internalEvent([
//   {
//     action:'CONTEXT_MENU_STATE',
//     data:{
//       action:'OPEN',
//       menu:test_menu
//     }
//   }
// ])