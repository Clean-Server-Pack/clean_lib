import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Progress, Text, useMantineTheme } from "@mantine/core";
import { useHover } from "@mantine/hooks";
import { useEffect, useMemo } from "react";

import colorWithAlpha from "../../utils/colorWithAlpha";
import getImageType from "../../utils/getImagePath";
import { useAudio } from "../../stores/audio/store";



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
export function MenuItem(props: MenuItemProps) {
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
    if (props.disabled || props.readOnly || !props.hoverSounds) {
      return;
    }
    if (hovered) {
      play('hover');
    }
  }, [hovered, props.disabled, props.readOnly, props.hoverSounds]);


  const iconType = useMemo(() => {
    return getImageType(props.icon);
  } , [props.icon]);

  const imageType = useMemo(() => {
    return getImageType(props.image);
  } , [props.icon]);



  return (
    <Flex
      ref={ref}
      // bg={!props.disabled && hovered ? 'rgba(144, 144, 144, 0.5)' : !props.disabled ? 'rgba(144, 144, 144, 0.5)' : 'rgba(144, 144, 144, 0.5)'}
      w='100%'
      p='sm'
      gap='xs'
      direction='column'
      style={{

        transition: 'all ease-in-out 0.2s',
        boxShadow: hovered ? `inset 0 0 8vh ${colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.8)}` : 'inset 0 0 0.2vh rgba(0,0,0,0.6)', 
        outline: hovered ?  `0.2vh solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : '0.2rem solid transparent',
        backgroundColor: hovered ? 'rgba(77,77,77,0.6)' : 'rgba(77,77,77,0.5)',
        
        visibility: props.hide ? 'hidden' : 'visible',

        
        backgroundImage: props.backgroundImage ? `url(${props.backgroundImage})` : 'none',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        borderRadius: theme.radius.xxs,
        // boxShadow: hovered ? `inset 0 0 3vh ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : 'none',
        cursor: (!props.readOnly && !props.disabled) ? 'pointer' : 'default',
        // outline:  (!props.readOnly && !props.disabled && hovered) ? `0.2vh solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : '0.2vh solid rgba(0,0,0,0.2)',
        justifyContent: 'center',
        // transition: 'all ease-in-out 0.1s',
        // transform: (!props.readOnly && !props.disabled && hovered) ? 'scale(1.01)' : 'scale(1)',
      }}


      onClick={handleClick}
    >
      <Flex
        direction='row'
        gap='xs'
        align='center'

      >
        {iconType && iconType.type == 'icon' ? (
          <FontAwesomeIcon icon={['fas', props.icon as IconName]} style={{ 
            color: 'white',
            fontSize: theme.fontSizes.sm,
          }}  />  
        ) : iconType && (
          <img src={iconType.path} alt='icon' style={{ width: '1.5rem', height: '1.5rem' }} />
        )}


        <Text fw='bold' size='sm' style={{ color: 'white', fontFamily:'Akrobat Bold' }}>{props.title}</Text>
      </Flex>
      {props.description && <Text size='xs' style={{ color: 'rgba(255,255,255,0.8)', whiteSpace: 'pre-line' }}>
        {props.description}
      </Text>}

      {typeof(props.progress) == 'number' ? 
        <Progress value={props.progress} 
        />
      : null}

      {imageType && imageType.type == 'image' && 
        <img src={props.image} alt='user_image'/>
      }

      

    </Flex>
  );
}
