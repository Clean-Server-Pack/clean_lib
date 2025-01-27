import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import { create } from "zustand";

type localeType = (key: string, ...args: string[]) => string;

type LocalesProps = {
  [key: string]: string;
}

type LocaleStoreProps = {
  locale: localeType;
  fetchLocales: () => void;
  locales: LocalesProps;
};

export const localeStore = create<LocaleStoreProps>((set) => {
  return {
    locales: {
      'items_to_sell': 'Items to Sell',
      'shopping_cart': 'Shopping Cart',
      'add_to_cart': 'Add to Cart',
      'payment': 'Payment',
      'total_price': 'Total Price',
    },
    locale: (key: string, ...args: string[]): string => {
      let translation = localeStore.getState().locales[key] || key;
      if (args.length) {
        translation = translation.replace(/%s/g, () => args.shift() || '');
      }
      return translation;
    },
    fetchLocales: () => {
      if (!isEnvBrowser()) {
        fetchNui<LocalesProps>('GET_LOCALES')
          .then((data) => {
            set({ locales: data });
          })
          .catch((error) => {
            console.error('Failed to fetch locales:', error);
          });
      }
    },
  };
});

// export locale as a standalone function 
export const locale = localeStore.getState().locale;