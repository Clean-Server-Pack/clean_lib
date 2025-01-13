import { IconName } from "@fortawesome/fontawesome-svg-core";
import { fetchNui } from "../../utils/fetchNui";
import { MenuItem } from "../Generic/MenuItem";




export type ContextItemProps = {

  id: string; 
  clickSounds: boolean;
  hoverSounds: boolean;
  title: string;
  backgroundImage?: string;
  disabled?: boolean;
  willClose?: boolean;
  description?: string;
  readOnly?: boolean;
  menu?: string; 
  dialog? : string;
  onSelect?: string; 

  serverEvent?: string;
  clientEvent?: string;
  icon?: IconName | string;
  iconColor?: string;
  iconAnimation?: string;
  progress?: number;
  colorScheme?: string;
  arrow?: boolean;
  image?: string;
  metadata: object; 
};
export function ContextItem(props: ContextItemProps) {
  const handleClick = () => {

    if (props.readOnly || props.disabled) {
      return;
    }

    if (props.onSelect || props.serverEvent || props.clientEvent || props.menu || props.dialog) {
      fetchNui('CONTEXT_CLICKED', props.id) 
      return 
    }
  };




  return (
    <MenuItem
      clickSounds={props.clickSounds}
      hoverSounds={props.hoverSounds}
      title={props.title}
      backgroundImage={props.backgroundImage}
      disabled={props.disabled}
      willClose={props.willClose}
      description={props.description}
      readOnly={props.readOnly}
      onClick={handleClick}
      icon={props.icon}
      iconColor={props.iconColor}
      iconAnimation={props.iconAnimation}
      progress={props.progress}
      colorScheme={props.colorScheme}
      arrow={props.arrow}
      image={props.image}
      metadata={props.metadata} 
    />
  );
}
