import { Flex } from "@mantine/core";
import { useEffect, useState } from "react";
import Cart from "./Cart/main";
import { Categories } from "./Categories";
import StoreContainer from "./ShopItems/ShopContainer";
import { useStore } from "../store";


export default function Content() {
  const [category, setCategory] = useState<string>('Category 1');
  const categories = useStore(state => state.categories);
  
  useEffect(() => {
    setCategory(categories[0].name);
  }, [categories]);

  return (
    <Flex
      w='100%'
      flex={1}
      gap='xs'
    >
      <Categories category={category} setCategory={setCategory} />
      <StoreContainer category={category} />
      <Cart />
      
    </Flex>
  )
}