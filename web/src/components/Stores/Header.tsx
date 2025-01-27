import { Flex } from "@mantine/core";
import { locale } from "../../stores/locales";
import { useStore } from "./store";
import { Title } from "../Generic/Title";
import InfoBox from "../Generic/InfoBox";



export function Header() {

  const info = useStore(state => state.info);
  return (
    <Flex
      justify='space-between'
      align={'center'}
      // bg='red'
      w='100%'
      p='xs'
      mb='sm'
    >
      <Title
        removeBorder
        title={info.name}
        description={info.description}
        icon={info.icon}
      />
      <InfoBox  
        leftSide={locale('ESCAPE')} 
        rightSide={locale('CLOSE')}
      />
    </Flex>
  );
}
