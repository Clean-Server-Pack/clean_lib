export type StoreInfoProps = {
  name: string;
  hasCategories: boolean;
  description: string;
  type: 'sell' | 'buy';
  icon: string;
  currency: string;
  canManage?: boolean;
  paymentMethods: {
    id: string;
    name: string;
    icon: string;
  }[];
}

export type MetadataProps = {
  [key: string | number]: unknown;
 }
 
 export type ItemProps = {
   listing_id: string;
 
   name: string;
   price: number;
   label: string;
   image: string; // url
   disableIcon?: string;
   disableMessage?: string;
   metadata: MetadataProps[];
   
   description?: string;
   category?: string;
   stock?: number;
 }
 
 export type CategoryProps = {
  name: string;
  icon: string;
  description: string; 
}

 
export type CartItemProps = {
  label: string;
  amount: number; 
  price: number;
  listing_id: string;
  image: string;
}

export type CategoriesProps = {
  category: string;
  setCategory: (category: string) => void;
};

export type CategoryComponentProps = {
  selected: boolean;
  setCategory: (category: string) => void;
} & CategoryProps;