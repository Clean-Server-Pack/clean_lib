


import { create } from "zustand";
import { StoreInfoProps, CategoryProps, ItemProps, CartItemProps } from "./types";
import { isEnvBrowser } from "../../utils/misc";



// Create a context with default values

type StoresStoreProps = {
  open: boolean;
  info: StoreInfoProps;
  categories: CategoryProps[];
  items: ItemProps[];
  cart: CartItemProps[];
  addToCart: (listing_id: string, amount?: number) => void;
  removeFromCart: (listing_id: string, amount: number) => void;
  existsInCart: (listing_id: string) => boolean;
  removeCategory: (category: string) => void;
  addCategory: (category: CategoryProps) => void;
};

export const useStore = create<StoresStoreProps>((set, get) => ({
  open: isEnvBrowser(),
  info: {
    name: 'Test Store',
    hasCategories: true,
    description: 'Test Store Desc',
    icon: 'user',
    type: 'sell', // sell or buy
    currency: '$',
    paymentMethods: [
      {id: 'cash', name: 'Cash', icon: 'money-bill-wave'},
      {id: 'card', name: 'Card', icon: 'credit-card'}
    ] 
  }, 
  cart: [],
  categories: [
    {
      name: 'Health',
      icon: 'user',
      description: 'Health Category'
    },
    {
      name: 'Food',
      icon: 'bread-slice',
      description: 'Food Category'
    },
  ],
  items: [
    {
      listing_id: 'listing_1',
      name: 'drivers_license',
      price: 10,
      label: 'Drivers License',
      image: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/license/driver_license.png',
      metadata: [],
      // description: 'This is a drivers license I mean you could probably drive with it',
      category: 'Health',
      stock: 10
    },
    {
      listing_id: 'listing_1',
      name: 'drivers_license',
      price: 10,
      label: 'Drivers License',
      image: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/license/driver_license.png',
      metadata: [],
      description: 'This is a drivers license I mean you could probably drive with it',
      category: 'Health',
      disableIcon: 'exclamation-triangle',
      disableMessage: 'Out of Stock',
      stock: 1
    },
    {
      listing_id: 'listing_1',
      name: 'drivers_license',
      price: 10,
      label: 'Drivers License',
      image: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/license/driver_license.png',
      metadata: [],
      description: 'This is a drivers license I mean you could probably drive with it',
      category: 'Health',
      stock: 10
    },
    {
      listing_id: 'listing_1',
      name: 'drivers_license',
      price: 10,
      label: 'Drivers License',
      image: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/license/driver_license.png',
      metadata: [],
      description: 'This is a drivers license I mean you could probably drive with it',
      category: 'Health',
      stock: 10
    },
    {
      listing_id: 'listing_1',
      name: 'drivers_license',
      price: 10,
      label: 'Drivers License',
      image: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/license/driver_license.png',
      metadata: [],
      description: 'This is a drivers license I mean you could probably drive with it',
      category: 'Health',
      stock: 10
    },
    {
      listing_id: 'listing_3',
      name: 'drivers_license',
      price: 10,
      label: 'Drivers License',
      image: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/license/driver_license.png',
      metadata: [],
      description: 'This is a drivers license I mean you could probably drive with it',
      category: 'Food',
      stock: 10
    },
  ],


  addToCart: (listing_id: string, amount?: number) => {
    // add to cart if it exists and if there is enough stock
    const item = get().items.find((item) => item.listing_id === listing_id);
    if (!item) return;
    const cartItem = get().cart.find((item) => item.listing_id === listing_id);
    if (!cartItem) {
      set((state) => ({
        cart: [...state.cart, {
          label: item.label,
          amount: amount || 1,
          price: item.price,
          listing_id: item.listing_id,
          image: item.image
        }]
      }));
    } else {
      if (!item.stock || (item.stock - (cartItem.amount + (amount || 1)) >= 0)) {
        set((state) => ({
          cart: state.cart.map((item) => {
            if (item.listing_id === listing_id) {
              return {
                ...item,
                amount: item.amount + (amount || 1)
              };
            }
            return item;
          })
        }));
      }
    } 
  },

  removeFromCart: (listing_id: string, amount:number) => {
    // remove x item from the cart if it exists and if it gets to 0 completely remove it
    const item = get().cart.find((item) => item.listing_id === listing_id);
    if (item) {
      if (item.amount - amount <= 0) {
        set((state) => ({
          cart: state.cart.filter((item) => item.listing_id !== listing_id)
        }));
      } else {
        set((state) => ({
          cart: state.cart.map((item) => {
            if (item.listing_id === listing_id) {
              return {
                ...item,
                amount: item.amount - amount
              };
            }
            return item;
          })
        }));
      }
    }
  },

  existsInCart: (listing_id: string) => {
    // check if the item exists in the cart
    return get().cart.some((item) => item.listing_id === listing_id);
  },

  removeCategory: (category: string) => {
    const newCategories = get().categories.filter((cat) => cat.name !== category);
    set(() => ({
      categories: newCategories
    }));
  },

  addCategory: (category: CategoryProps) => { 
    set((state) => ({
      categories: [...state.categories, category]
    }));
  },




}));
