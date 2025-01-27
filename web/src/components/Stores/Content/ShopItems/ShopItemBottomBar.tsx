import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Text, useMantineTheme } from "@mantine/core";

import { useHover } from "@mantine/hooks";
import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { useStore } from "../../store";
import colorWithAlpha from "../../../../utils/colorWithAlpha";
import { ItemProps } from "../../types";


type StoreItemBottomBarProps = {
  hovered: boolean;
} & ItemProps;

function StoreItemBottomBar(props: StoreItemBottomBarProps) {
  const info = useStore(state => state.info);
  const theme = useMantineTheme();
  const addToCart = useStore(state => state.addToCart);
  return ( 
    <Flex
      flex={1}
      bg='rgba(55,55,55,0.1)'
      // p='xs'
      p='xs'
      align={'center'}
    >
      <Flex
        direction='column'
        p='xs'
        gap='xs'
        h='5.8vh'
      >
        <Text size='sm'
        
          style={{
            lineHeight: theme.spacing.xs,
          }}
        >{props.label}</Text>
        {props.description && (
            <Text size='xs' c='grey' 
            style={{
              overflowY: 'auto',
            }}  

          >{props.description}</Text> 
        )}
      </Flex>

        <Flex
          ml='auto'
          gap='xs'
        >
          {info.canManage &&(
            <StoreItemButton
              hovered={props.hovered}
              disabled={props.disableMessage}
              icon='edit'
            />
          )}

          <StoreItemButton
            hovered={props.hovered}
            icon='cart-plus'
            disabled={props.disableMessage || !info.canManage}
            onClick={() => addToCart(props.listing_id, 1)}
          />

        </Flex>

    </Flex>
  )
}

export default StoreItemBottomBar;

type StoreItemButtonProps = {
  hovered: boolean;
  icon: string; 
  disabled?: string | boolean;
  onClick?: () => void;
}

function StoreItemButton(props: StoreItemButtonProps){
  const {hovered, ref} = useHover();
  const info = useStore(state => state.info);
  const theme = useMantineTheme();
  return ( 
    <Flex
      ref={ref}
    >
      <FontAwesomeIcon 
        icon={props.icon as IconProp}
        color={props.hovered? 
          'rgba(255,255,255,0.9)':
          'rgba(255,255,255,0.6)'
        }
        style={{
          fontSize: theme.fontSizes.xs,

          padding: theme.spacing.xs,
          backgroundColor: props.hovered || (info.canManage && !props.disabled &&  hovered) ? 
            colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8):
            colorWithAlpha(theme.colors[theme.primaryColor][9], 0.3),
          cursor: 'pointer',
          transition: 'all ease-in-out 0.1s',
          borderRadius: theme.radius.xxs,
        }}  
        onClick={() => {
          if (!props.disabled && info.canManage) {
            if (!props.onClick) return;
            props.onClick();
          }
        }}
      />

    </Flex>
  )
}