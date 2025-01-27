import { Text, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";

type KeyProps = {
  _key: string | number;
  pressed?: boolean;
};

const KeyIcon = function (props: KeyProps) {
  const theme = useMantineTheme();
  
  const convertKey = (key: string | number) => { 
    key = key.toString().toUpperCase(); // Convert key to uppercase
    switch (key) {
      case "ARROW UP":
        return "↑";
      case "ARROW DOWN":
        return "↓";
      case "ARROW LEFT":
        return "←";
      case "ARROW RIGHT":
        return "→"; 
      case "ENTER":
        return "↵";
      case "ESCAPE":
        return "ESC";
      case "BACKSPACE":
        return "⌫";
      case "TAB":
        return "⇥";
      case "CAPSLOCK":
        return "⇪";
      case "SHIFT":
        return "⇧";
      case " ":
        return "␣";
      case "CONTROL":
        return "CTRL";
      default:
        return key; // Return the key itself if no match is found
    }
  };
  
    
  return (
    <Text
      bg="rgba(0,0,0,0.5)"
      w="3.8vh"
      size='sm'
      style={{
        aspectRatio: 1,
        
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        borderRadius: theme.radius.xxs,
        transition: "all ease-in-out 0.2s",
        boxShadow: props.pressed ? `inset 0 0 2.9vh ${colorWithAlpha(
          theme.colors[theme.primaryColor][theme.primaryShade as number],
          0.8
        )}` : 'none',
        outline: `2px solid ${
          props.pressed
            ? colorWithAlpha(
                theme.colors[theme.primaryColor][theme.primaryShade as number],
                0.8
              )
            : "rgba(255,255,255,0.1)"
        }`,
        fontFamily: 'Akrobat Bold',
      }}
    
    >

      {typeof props._key === "number" ? props._key :
        convertKey(props._key) ?? props._key.toUpperCase()
      }

    </Text>
  );
};

export default KeyIcon;
