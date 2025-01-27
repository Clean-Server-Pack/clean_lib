import { IconName } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import { useEffect, useState } from "react";
import CartItem from "./CartItem";
import TotalPrice from "./TotalPrice";
import { locale } from "../../../../stores/locales";
import { useStore } from "../../store";
import Button from "../../../Generic/Button";
import { fetchNui } from "../../../../utils/fetchNui";







export default function Cart() {
  const theme = useMantineTheme();
  const cart  = useStore(state => state.cart);
  const items = useStore(state => state.items);
  const info  = useStore(state => state.info);

  const [total, setTotal] = useState(0);
  useEffect(() => {
    // calculate the total price of all items in the cart
    let total = 0;
    cart.forEach((item) => {
      const itemInfo = items.find((i) => i.listing_id === item.listing_id);
      if (itemInfo) {
        total += item.amount * itemInfo.price;
      }
    });
    setTotal(total);
  }, [cart, items]);


  return (
    <Flex  
      m='xs'
      ml='xl'
      flex={0.4} 
      direction='column'
      // bg='red'
      mah='70vh'
      
    >
      <Text
        size='md'
      >
        {info.type == 'buy' ? locale('shopping_cart'): locale('items_to_sell')}

      </Text>
      <Flex
        direction='column'
        flex={1}
        gap='md'
        p='xs'
        style={{
          overflowY: 'auto'
        }}
      >
        {cart.map((item, index) => (
          <CartItem key={index} {...item} />
        ))}

      </Flex>
      <Flex
        mt='auto'
        direction='column'
        gap='sm'
      >
        <TotalPrice total={total} />
        <Flex
          w='100%'
          justify='space-evenly'
          gap='xs'
        >


      
         {info.paymentMethods.map((method: {
            id: string;
            name: string;
            icon: string;
         }, index) => (
            <Button
            key={index}
            text={method.name}  flex={1} icon ={method.icon as IconName} disabled={total === 0} rect
            fontSize={theme.fontSizes.sm}
              onClick={() => {

                type ReturnData = {
                  transaction: boolean;
                  failMessage: string;
                };
                fetchNui<ReturnData>('MAKE_TRANSACTION', {method: method.id, cart: cart}).then(response => {
                  if (response.failMessage) {
                    // notifications.show({
                    //   title: locale('transaction_failed'),
                    //   message: locale(response.fail_message),
                    // })
                  }

                  if (response.transaction) {
                    useStore.setState({
                      cart: []
                    });
                  }
                });
                
              }} 
            />
          ))}
          
        </Flex>
      </Flex>
    </Flex>
  )
}