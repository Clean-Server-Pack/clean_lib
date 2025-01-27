import { Flex, useMantineTheme } from "@mantine/core";
import { CartItemProps } from "../../types";

import { useStore } from "../../store";
import Button from "../../../Generic/Button";


export default function CartItemButtons(props: CartItemProps) {
  const theme = useMantineTheme();
  const removeFromCart = useStore(state => state.removeFromCart);
  const addToCart = useStore(state => state.addToCart);

  return (
    <Flex
      align='center'
      gap='xs'
      ml='auto'
    >
      <Button icon='fa-minus' hoverColor='red' iconSize={theme.fontSizes.xs} onClick={() => removeFromCart(props.listing_id, 1)} />
      <Button icon='fa-plus' hoverColor='green' iconSize={theme.fontSizes.xs} onClick={() => addToCart(props.listing_id, 1)} />
      <Button icon='fa-trash' hoverColor='red' iconSize={theme.fontSizes.xs} onClick={() => removeFromCart(props.listing_id, props.amount)} />
    </Flex>
  )
}