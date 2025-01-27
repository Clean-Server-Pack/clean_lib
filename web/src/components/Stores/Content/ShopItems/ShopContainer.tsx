import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, SimpleGrid, Text, useMantineTheme } from "@mantine/core";
import { useHover } from "@mantine/hooks";

import StoreItem from "./ShopItem";
import { useStore } from "../../store";
import { useMemo } from "react";

type StoreContainerProps = {
  category: string;
};

export default function StoreContainer(props: StoreContainerProps) {
  const theme = useMantineTheme();
  const items = useStore(state => state.items);
  const info = useStore(state => state.info);

  const filteredItems = useMemo(() => {
    return items.filter(item => item.category === props.category || !info.hasCategories);
  }, [items, props.category, info.hasCategories]);

  return (
    <SimpleGrid
      p='xs'
      pr='sm'
      cols={info.hasCategories ? 4 : 5}
      flex={1}
      h={'fit-content'} // Set each item to take up 50% of the grid's height
      mah='80vh' // Set each item to take up 50% of the grid's height
      spacing={theme.spacing.xs}
      verticalSpacing={theme.spacing.xs}
      style={{ height: "100%",
        scrollbarGutter: 'stable',
        overflowY: "auto"
      }} // Ensure SimpleGrid fills the parent's height
    >
       {/* // Map over the items and render each one if it matches the category */}
      {filteredItems.map((item, index) =>  
        <StoreItem key={index} {...item} />
      )}
      {/* {info.canManage && <AddItem />} */}
    </SimpleGrid>
  );
}
// eslint-disable-next-line @typescript-eslint/no-unused-vars
function AddItem(){
  const {hovered, ref} = useHover();
  const theme = useMantineTheme();
  return (

    <Flex
      onClick={
        () => console.log('Add new item')
      }
      ref={ref}
      flex={1}
      p='2em'
      
      bg={hovered ? 'rgba(77,77,77,0.9)': 'rgba(77,77,77,0.6)'}
      // h="fit-content" // Set each item to take up 50% of the grid's height
      style={{
        marginLeft: 'auto',
        marginRight: 'auto',
        alignSelf: 'center',
        transition: 'all ease-in-out 0.2s',
        borderRadius: '0.25rem',
        backdropFilter: 'blur(5px)',
        cursor: 'pointer',
        outline: hovered ? `2px solid ${theme.colors[theme.primaryColor][9]}` : '2px solid rgba(155,155,155,0.6)',
      }}
      direction='column'
    >
      <Flex
        m='auto'
        align={'center'}
        justify={'center'}
        direction={'column'}
      >
        <FontAwesomeIcon 
          icon='plus' 
          
          color={hovered? 'rgba(255,255,255,0.9)': 'rgba(255,255,255,0.7)'}
          style={{
            fontSize: '4em',
            transition: 'all ease-in-out 0.2s',
          }}
        />
        <Text
          c={hovered? 'rgba(255,255,255,0.9)': 'rgba(255,255,255,0.7)'}
          size='2em'
          style={{
            transition: 'all ease-in-out 0.2s',
          }}
        >Add new item</Text>
      </Flex>
    </Flex>

  )
}
