import { Flex, Text, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../../../utils/colorWithAlpha";
import { useStore } from "../../store";
import { CartItemProps } from "../../types";

export default function CartItemInfo(props:CartItemProps){ 
  const theme = useMantineTheme();
  const info = useStore(state => state.info);
  return (
    <Flex
      direction='column'
    >
      <Text size='sm'
        style={{
          fontFamily: 'Akrobat Bold'
        }}
      >{props.label}</Text>
      <Text
        size='sm'
        c={colorWithAlpha(theme.colors[theme.primaryColor][9], 0.9)}
      >{info.currency}{props.price}</Text>
    </Flex>
  )
}