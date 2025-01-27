import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import { useHover } from "@mantine/hooks";
import colorWithAlpha from "../../utils/colorWithAlpha";

type ButtonProps = {
  disabled?: boolean;
  text?: string;
  icon?: string;
  h?: string;
  w?: string;
  p?: string;
  pt?: string;
  pr?: string;
  pb?: string;
  pl?: string;
  mr?: string;
  mb?: string;
  mt?: string;
  ml?: string;
  bg?: string;
  radius?: string;
  rect?: boolean;
  onClick?: () => void;
  color?: string;
  hoverColor?: string;
  fontSize?: string;
  iconSize?: string;
  selected?: boolean;
  align?: string;
  flex?: number;
  
  // style css properties 
  style?: React.CSSProperties;

}

export default function Button(props: ButtonProps) {
  const theme = useMantineTheme();
  const {hovered, ref} = useHover();
  const colors = {
    iconColor: {
      hovered: 'rgba(255,255,255,0.8)',
      normal: 'rgba(255,255,255,0.5)',
    },

    textColor: {
      hovered: 'rgba(255,255,255,0.8)',
      normal: 'rgba(255,255,255,0.5)',
    },

    borderColor: {
      hovered: colorWithAlpha(theme.primaryColor, 0.3),
      normal: theme.primaryColor,
    },
  }

  return (
    <Flex
      ref={ref}
      w={props.w || 'fit-content'}
      h={props.h || 'fit-content'}
      mr={props.mr || '0'}
      mb={props.mb || '0'}
      mt={props.mt || '0'}
      ml={props.ml || '0'}
      flex={props.flex}
    
      
      bg={ !props.disabled && (hovered || props.selected) ? colorWithAlpha(props.hoverColor || theme.colors[theme.primaryColor][9], 0.4) : !props.disabled ? 'rgba(66, 66, 66, 0.5)' : 'rgba(44, 44, 44, 0.3)'} 


      style={{
        aspectRatio: !props.rect ? '1/1' : 'unset',
        borderRadius: props.radius || theme.radius.xxs,
        cursor: !props.disabled ? 'pointer' : 'not-allowed',
        padding: props.p || theme.spacing.xs,
        outline: !props.disabled && (hovered || props.selected) ? `0.2vh solid ${colorWithAlpha(props.hoverColor || theme.colors[theme.primaryColor][9], 0.8)}`: !props.disabled ? "0.2vh solid transparent" : '0.2vh solid rgba(77, 77, 77, 0.3)',  
        transition: 'all 0.1s ease-in-out',
        ...props.style,
      }}
      align='center'
      justify='center'
      onClick={() => {
        if(!props.disabled && props.onClick){
          props.onClick()
        }
      }}
    >
      {props.icon && (
        <FontAwesomeIcon icon={props.icon as IconName || 'fa-play'} style={{ 
          color: (hovered || props.selected) && !props.disabled ? colors.iconColor.hovered : colors.iconColor.normal,
          fontSize: props.iconSize || theme.fontSizes.xs,
          aspectRatio: '1/1',
        }} 
        
        />

      )}

      {props.text && (
        <Text
          style={{
            fontFamily: 'Akrobat Bold',
            color: !props.disabled && (hovered || props.selected) ? colors.textColor.hovered : colors.textColor.normal,
            fontSize: props.fontSize || theme.fontSizes.xs,
            marginLeft: props.icon ? '0.5rem' : '0',
          }}
        >{props.text}</Text>
      )}

    </Flex>
  )
}