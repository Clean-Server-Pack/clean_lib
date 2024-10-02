import { Flex, Kbd, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";

type KeyProps = {
  _key: string | number;
  pressed?: boolean;
};

const KeyIcon = function (props: KeyProps) {
  const theme = useMantineTheme();
  
  const convertKey = (key: string | number) => { 

    key = key.toString()
    switch (key) {
      case "ArrowUp":
        return "↑";
      case "ArrowDown":
        return "↓";
      case "ArrowLeft":
        return "←";
      case "ArrowRight":
        return "→"; 
      case "Enter":
        return "↵";
      case "Escape":
        return "ESC";
      case "Backspace":
        return "⌫";
      case "Tab":
        return "⇥";
      case "CapsLock":
        return "⇪";
      case "Shift":
        return "⇧";
      case " ":   
        return "␣";
      case "Control":
    } 
  }




    
  return (
    <Flex
      bg="rgba(0,0,0,0.5)"
      direction={"column"}
      align={"center"}
      justify={"center"}
      w="4.2vh"
      style={{
        aspectRatio: 1 / 1,
        borderRadius: theme.radius.sm,
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
            : "gray"
        }`,
        position: "relative",
      }}
    >
      <Kbd
        size="xl"
        style={{
          backgroundColor: "transparent",
          border: "none",
          fontFamily: "Akrobat Black",
          color: theme.colors["gray"][1],
        }}
      >
        {typeof props._key === "number" ? props._key :
          convertKey(props._key) ? convertKey(props._key) : props._key.toUpperCase()
        }
      </Kbd>
    </Flex>
  );
};

export default KeyIcon;
