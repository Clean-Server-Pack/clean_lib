import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Progress, Text } from "@mantine/core";
import { useHover } from "@mantine/hooks";
import { useEffect, useMemo, useState } from "react";
import hoverSound from './soundfx.mp3';
import clickSound from './click_sound.mp3';
import { fetchNui } from "../../utils/fetchNui";



export type MenuItemProps = {

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
  icon?: IconName | string;
  iconColor?: string;
  iconAnimation?: string;
  progress?: number;
  colorScheme?: string;
  arrow?: boolean;
  image?: string;
  metadata: object; 
};
export function MenuItem(props: MenuItemProps) {
  const { hovered, ref } = useHover();
  const [sound] = useState(new Audio(hoverSound));
  const [sound_click] = useState(new Audio(clickSound));
  // adjust volume 
  sound.volume = 0.1;
  sound_click.volume = 0.1;

  const handleClick = () => {

    if (props.onSelect) {
      fetchNui('contextClicked', props.id) 
    }

    if (props.menu) {
      fetchNui('openContext', {
        back: false,
        id: props.menu,
      })
    }

    if (props.dialog) { 
      fetchNui('openDialog', {
        id: props.dialog,
      })
    }

    if (props.readOnly || props.disabled) {
      return;
    }

    if (props.willClose == null || props.willClose && !props.disabled && !props.readOnly) {
      fetchNui('closeContext')
    }

    if (props.disabled || props.readOnly || !props.clickSounds) {
      return;
    }
    sound_click.play();


  };

  useEffect(() => {
    if (props.disabled || props.readOnly || !props.hoverSounds) {
      return;
    }
    if (hovered) {
      sound.play();
    }
  }, [hovered, props.disabled, props.readOnly, props.hoverSounds, sound]);

  const is_icon = useMemo(() => {
    //  CHECK IF IS A HTTPS STRING
    if (typeof props.icon === 'string' && props.icon.startsWith('https')) {
      return false;
    }
    return true;
  }, [props.icon]);


  return (
    <Flex
      ref={ref}
      bg={props.disabled ? 'rgba(45,45,45,0.5)' : 'rgba(0,0,0,0.5)'}
      w='90%'
      p='sm'
      gap='xs'
      direction='column'
      style={{

        backgroundImage: props.backgroundImage ? `url(${props.backgroundImage})` : 'none',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        borderRadius: 'var(--mantine-radius-sm)',
        cursor: (!props.readOnly && !props.disabled) ? 'pointer' : 'default',
        border: (!props.readOnly && !props.disabled && hovered) ? '1px solid var(--mantine-primary-color-9)' : '1px solid transparent',
        justifyContent: 'center',
        transition: 'all ease-in-out 0.1s',
        // transform: (!props.readOnly && !props.disabled && hovered) ? 'scale(1.025)' : 'scale(1)',
      }}


      onClick={handleClick}
    >
      <Flex
        direction='row'
        gap='sm'
        align='center'

      >
        {props.icon && is_icon ? (
          <FontAwesomeIcon icon={['fas', props.icon as IconName]} style={{ color: 'white' }} size='lg' />  
        ) : (
          <img src={props.icon} alt='icon' style={{ width: '1.5rem', height: '1.5rem' }} />
        )}

        <Text fw='bold' size='lg' style={{ color: 'white' }}>{props.title}</Text>
      </Flex>
      {props.description && <Text size='sm' style={{ color: 'rgba(255,255,255,0.8)', whiteSpace: 'pre-line' }}>
        {props.description}
      </Text>}
      {props.progress && 
        <Progress value={props.progress} 
        />
      }

      {props.image && 
        <img src={props.image} alt='user_image'/>
      }
    </Flex>
  );
}
