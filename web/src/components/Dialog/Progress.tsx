import { Flex, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";

type ProgressProps = {
  size?: string;
  w?: string;
  value: number;
}

export default function Progress(props: ProgressProps ) {
  const theme = useMantineTheme();
  return ( 
    <Flex
      w={props.w || '100%'}
    >
      <Flex
        w={`${props.value}%`}
        bg={colorWithAlpha(theme.colors[theme.primaryColor][9], 0.5)} 
        h={props.size || '5px'}
        style={{
          transition: 'all ease-in-out 0.3s'
        }}
      />
    </Flex>
  )
}