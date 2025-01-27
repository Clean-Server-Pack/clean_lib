import { Flex, Image } from "@mantine/core";
import { ItemProps } from "../../types";


export function StoreItemImage(props: ItemProps) {
  return (
    <Flex
      h='15vh'
      justify={'center'}
    >
      <Image
        src={props.image}
        alt='Image Not Found'
        style={{
          fontSize: '1.5vh',
        }}
        fit='contain' />
    </Flex>
  );
}
