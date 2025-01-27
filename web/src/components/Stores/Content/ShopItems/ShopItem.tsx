import { Flex, useMantineTheme } from "@mantine/core";
import { useHover } from "@mantine/hooks";

import StoreItemBottomBar from "./ShopItemBottomBar";
import { StoreItemImage } from "./ShopItemImage";
import { StoreItemTopBar } from "./ShopItemTopBar";
import { useEffect, useMemo, useState } from "react";
import CenterIconWrapper from "./ShopItemWrapper";
import { useStore } from "../../store";
import colorWithAlpha from "../../../../utils/colorWithAlpha";
import { ItemProps } from "../../types";




export default function StoreItem(props: ItemProps) {
  const info = useStore(state => state.info);
  const existsInCart = useStore(state => state.existsInCart);
  const addToCart = useStore(state => state.addToCart);
  const theme = useMantineTheme();
  const {hovered, ref} = useHover();
  const [isHovered, setIsHovered] = useState(false);

  const inCart = useMemo(() => existsInCart(props.listing_id), [props.listing_id, existsInCart]);


  // Stop hover if props.disabled
  useEffect(() => {
    if (props.disableMessage || info.canManage) {
      setIsHovered(false);
      return 
    }
    setIsHovered(hovered);
  }, [hovered, props.disableMessage, info.canManage]);


  return (
    <CenterIconWrapper
      icon={props.disableIcon}
      message={props.disableMessage}
      hovered={isHovered}
      inCart={inCart}
    >

      <Flex
        onClick={
          props.disableMessage || info.canManage ? undefined : !inCart ? () => addToCart(props.listing_id) : undefined
        }
        ref={ref}
        flex={1}
        bg={!inCart ? 
          isHovered ? 'rgba(77,77,77,0.6)': 'rgba(77,77,77,0.3)':
          colorWithAlpha(theme.colors[theme.primaryColor][9], 0.25)
        }
        w="100%"
        h="fit-content" // Set each item to take up 50% of the grid's height
        style={{
          transition: 'all ease-in-out 0.1s',
          borderRadius: '0.25rem',
          backdropFilter: 'blur(5px)',
          cursor: info.canManage || props.disableMessage ? 'default' : 'pointer',
          outline: isHovered ? `2px solid ${theme.colors[theme.primaryColor][9]}` : 'none',
          filter: props.disableMessage && 'blur(3px)' || 'none',
        }}
        direction='column'
      >
        <Flex
          direction='column'
          bg='rgba(77,77,77,0.7)'
          style={{
            backdropFilter: 'blur(5px)',
          }}
        >
          <StoreItemTopBar {...props} hovered={isHovered || inCart} />
          <StoreItemImage {...props} />


        </Flex>

          <StoreItemBottomBar {...props} hovered={isHovered || inCart} />

      </Flex>
    </CenterIconWrapper>
  )
}