import { fetchNui } from "../../utils/fetchNui";
import { ResponseProps } from "./Responses";

import { IconName, IconProp } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Progress, Text, useMantineTheme } from "@mantine/core";
import { useHover } from "@mantine/hooks";
import { useEffect, useMemo } from "react";


import { useAudio } from "../../stores/audio/store";
import colorWithAlpha from "../../utils/colorWithAlpha";
import getImageType from "../../utils/getImagePath";



export type MenuItemProps = {


  clickSounds?: boolean;
  hoverSounds?: boolean;
  title: string;
  backgroundImage?: string;
  disabled?: boolean;
  willClose?: boolean;
  description?: string;
  readOnly?: boolean;
  onClick?: () => void; 
  empty?: boolean;
  icon?: IconName | string;
  iconColor?: string;
  iconAnimation?: string;
  progress?: number;
  colorScheme?: string;
  arrow?: boolean;
  image?: string;
  metadata?: object; 
  hide?: boolean;
};

function MenuItem(props: MenuItemProps) {
  const { hovered, ref } = useHover();
  const theme = useMantineTheme();
  const play = useAudio((state) => state.play);

  const handleClick = () => {
    if (props.disabled || props.readOnly) {
      return;
    }
    if (props.clickSounds) play('click');
    if (props.onClick) {
      props.onClick();
    }
  };

  useEffect(() => {
    if (props.disabled || props.readOnly || !props.hoverSounds || props.empty) {
      return;
    }
    if (hovered) {
      play('hover');
    }
  }, [hovered, props.disabled, props.readOnly, props.hoverSounds, props.empty]);


  const iconType = useMemo(() => {
    return getImageType(props.icon);
  } , [props.icon]);

  const imageType = useMemo(() => {
    return getImageType(props.image);
  } , [props.image]);



  return (
    <Flex
      flex={1}
      // bg='red'
      
      align='center'
      
    >
      <Flex
        ref={ref}
        bg={!props.disabled && hovered ? 'rgba(144, 144, 144, 0.5)' : !props.disabled ? 'rgba(144, 144, 144, 0.5)' : 'rgba(77, 77, 77, 0.4)'}
        w='100%'
        p='2vh'
        mah='12vh'
        gap='1vh'
        direction='column'
        style={{
          visibility: props.hide ? 'hidden' : 'visible',
          backgroundImage: props.backgroundImage ? `url(${props.backgroundImage})` : 'none',
          backgroundSize: 'cover',
          backgroundPosition: 'center',
          borderRadius: '0.4vh',
          boxShadow: (!props.readOnly && !props.disabled && hovered) ? `inset 0 0 3vh ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : 'none',
          cursor: (!props.readOnly && !props.disabled) ? 'pointer' : 'default',
          outline:  (!props.readOnly && !props.disabled && hovered) ? `0.2vh solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : '0.2vh solid rgba(0,0,0,0.2)',
          justifyContent: 'center',
          transition: !props.hide? 'all ease-in-out 0.1s' : 'none',
          // transform: (!props.readOnly && !props.disabled && hovered) ? 'scale(1.01)' : 'scale(1)',
        }}


        onClick={handleClick}
      >
        <Flex
          direction='row'
          gap='1vh'
          align='center'

        >
          {iconType && iconType.type == 'icon' ? (
            <FontAwesomeIcon icon={props.icon as IconProp} style={{
              color: 'rgba(255,255,255,0.8)',
              fontSize: '2vh',
            }}  />  
          ) : iconType && (
            <img src={iconType.path} alt='icon' style={{ width: '1.5rem', height: '1.5rem' }} />
          )}


        <Text fw='bold' size='1.8vh' style={{ color: 'white', fontFamily:'Akrobat Bold' }}>{props.title}</Text>
        </Flex>
        {props.description && <Text size='1.5vh' 
          
          style={{ 
            overflowX: 'hidden',
            overflowY: 'auto',
            color: 'rgba(255,255,255,0.8)', 
            whiteSpace: 'pre-line' 


          }}>
          {props.description}
        </Text>}

        {props.progress != null && 
          <Progress value={props.progress} />
        }

        {imageType && imageType.type == 'image' && 
          <img src={props.image} alt='user_image'/>
        }

        

      </Flex>

    </Flex>
  );
}


export function Response(props: ResponseProps) {


  const handleClick = () => {
    if (props.empty) return;
    fetchNui("DIALOG_SELECTED", { index: props.index });
  }

  return (
    <MenuItem
      clickSounds={props.clickSounds}
      hoverSounds={props.hoverSounds}
      title={props.label}
      disabled={props.empty || props.disabled}
      onClick={handleClick}
      empty={props.empty}
      description={props.description}
      hide={props.empty}
      icon={props.icon as string || 'question'}
    />
  );
}
