import { Flex, Text, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";

type KeyProps = {
  _key: string | number;
  pressed?: boolean;
};

const KeyIcon = function (props: KeyProps) {
  const theme = useMantineTheme();

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
      <Text
        size="md"
        style={{
          fontFamily: "Akrobat Black",
          color: theme.colors["gray"][1],
        }}
      >
        {props._key}
      </Text>
    </Flex>
  );
};

export default KeyIcon;
