import { Flex } from "@mantine/core";
import { StoreItemIcon } from "./ShopItemIcon";


type StoreItemTopBarProps = {
  price: number;
  stock?: number;
  hovered: boolean;
};
export function StoreItemTopBar(props: StoreItemTopBarProps) {
  return (
    <Flex
      direction='row-reverse'
      p='xs'
      gap='xs'
    >
      <StoreItemIcon icon='dollar-sign' value={props.price} hovered={props.hovered} />
      {props.stock && props.stock > 0 && (
        <StoreItemIcon icon='box' value={props.stock} hovered={props.hovered} />
      )}
    </Flex>
  );
}
