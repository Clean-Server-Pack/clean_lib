import { Flex, Text, useMantineTheme } from "@mantine/core";

import { locale } from "../../../../stores/locales";
import colorWithAlpha from "../../../../utils/colorWithAlpha";
import { useStore } from "../../store";

type TotalPriceProps = {
  total: number;
};

export default function TotalPrice(props: TotalPriceProps) {
  const theme = useMantineTheme();
  const info = useStore(state => state.info);

  return (
    <Flex
      align={'center'}
    >
      <Flex
        direction='column'
        w='100%'
        gap='0.25vh'
      >
        <Text
          size='sm'
          c={colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}
          style={{
            lineHeight: theme.fontSizes.xxs,
            fontFamily: 'Akrobat Bold'
          }}
        >{locale('payment')}</Text>
        <Text size='xs' c='grey'>{locale('total_price')}</Text>
      </Flex>
      <Text
        size='md'
        c={colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}
        style={{
          fontFamily: 'Akrobat Bold'
        }}
      >{info.currency}{props.total}</Text>
    </Flex>
  )

}