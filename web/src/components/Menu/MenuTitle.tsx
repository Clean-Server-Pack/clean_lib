import { IconName } from "@fortawesome/fontawesome-svg-core";
import { fetchNui } from "../../utils/fetchNui";
import { Title } from "../Generic/Title";
import { MenuProps } from "./main";
import { useState } from "react";
import hoverSound from './soundfx.mp3';
import clickSound from './click_sound.mp3';


type MenuTitleProps = {
  title: string;
  icon: IconName | string; 
  description?: string;
  dialog?: string;
  hoverSounds?: boolean;
  clickSounds?: boolean;

  canClose?: boolean;
  setMenuOpen: (menu: false | MenuProps) => void;
  menu?: string;
};
export function MenuTitle(props: MenuTitleProps) {
  // const is_icon = useMemo(() => {
  //   //  CHECK IF IS A HTTPS STRING
  //   if (typeof props.icon === 'string' && props.icon.startsWith('https')) {
  //     return false;
  //   }
  //   return true;
  // }, [props.icon]);
  const [sound] = useState(new Audio(hoverSound));
  const [sound_click] = useState(new Audio(clickSound));

  const onBack = function(){
    if (props.menu) {
      fetchNui('openContext', {
        back:true, 
        id: props.menu
      })
    }

    if (props.dialog) {
      fetchNui('openDialog', {
        id: props.dialog,
        back:true,
      })
    }
  }

  const onClose = function(){
    props.setMenuOpen(false)
    fetchNui('closeContext')
  }

  return (
    <>
      <Title 
        title={props.title} 
        description={props.description || ''} 
        icon={props.icon as IconName} 
        
        backButton={props.menu != null || props.menu != false} 
        onBack={onBack}
      
        closeButton={props.canClose}
        onClose={onClose}
      />

    </>
  );
}
