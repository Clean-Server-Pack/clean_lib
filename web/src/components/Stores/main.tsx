import { useEffect } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { fetchNui } from "../../utils/fetchNui";
import Background from "../Generic/Background";
import Content from "./Content/Content";
import { Header } from "./Header";
import { useStore } from "./store";
import { CategoryProps, ItemProps, StoreInfoProps } from "./types";


export default function StoreUI(){
  const open = useStore(state => state.open);


  useNuiEvent('OPEN_STORE', (data: {
    categories: CategoryProps[];
    items: ItemProps[];
    storeInfo: StoreInfoProps;

  }) => {
    useStore.setState({
      open: true,
      cart: [], 
      info: data.storeInfo,
      categories: data.categories,
      items: data.items
    })

  });

  useNuiEvent('CLOSE_STORE', () => {
    useStore.setState({open: false, cart: []});
  });

  useEffect(() => {
    if (!open) {
      // notifications.dirk();
    } 
  }, [open]);

  // escape key to close the store
  useEffect(() => {
    const handleEsc = (event: KeyboardEvent) => {
      if (event.key === 'Escape' && open) {
        fetchNui('STORE_CLOSED');
        useStore.setState({open: false, cart: []});
      }
    };

    window.addEventListener('keydown', handleEsc);

    return () => {
      window.removeEventListener('keydown', handleEsc);
    };
  }, [open]);


  
  return (
    <Background display={open}>
      <Header/>
      <Content/>

    </Background>
  )

}
