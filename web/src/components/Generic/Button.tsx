import { IconName, SizeProp } from "@fortawesome/fontawesome-svg-core";
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
  onClick?: () => void;
  color?: string;
  hoverColor?: string;
  fontSize?: string;
  iconSize?: string;
  
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
      

      
      bg={ !props.disabled && hovered ? colorWithAlpha(props.hoverColor || theme.colors[theme.primaryColor][9], 0.4) : 'rgba(66, 66, 66, 0.5)'}


      style={{
        aspectRatio: '1/1',
        borderRadius: props.radius || theme.radius.xs,
        cursor: !props.disabled ? 'pointer' : 'not-allowed',
        padding: props.p || '0.5rem',
        outline: !props.disabled && hovered? `0.1rem solid ${colorWithAlpha(props.hoverColor || theme.colors[theme.primaryColor][9], 0.8)}`: "0.25rem solid transparent",
        transition: 'all 0.1s ease-in-out',
        ...props.style,
      }}
      align='center'
      justify='center'
      onClick={props.onClick}
    >
      {props.icon && (
        <FontAwesomeIcon icon={props.icon as IconName || 'fa-play'} style={{ 
          color: hovered && !props.disabled ? colors.iconColor.hovered : colors.iconColor.normal,
          fontSize: props.iconSize || '2vh',
          aspectRatio: '1/1',
        }} 
        
        />

      )}

      {props.text && (
        <Text
          style={{
            fontFamily: 'Akrobat Bold',
            color: !props.disabled && hovered ? colors.textColor.hovered : colors.textColor.normal,
            fontSize: props.fontSize || '0.8rem',
            marginLeft: props.icon ? '0.5rem' : '0',
          }}
        >{props.text}</Text>
      )}

    </Flex>
  )
}