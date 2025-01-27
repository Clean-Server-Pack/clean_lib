import { Flex, Text, useMantineTheme } from "@mantine/core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { IconName } from "@fortawesome/fontawesome-svg-core";
import colorWithAlpha from "../../../../utils/colorWithAlpha";

type StoreItemIconProps = {
  icon: string;
  value: number | string;
  hovered: boolean;
} 

export function StoreItemIcon(props:StoreItemIconProps){
  const theme = useMantineTheme();
  return (
    <Flex
      bg={props.hovered ? 
        colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8):
        colorWithAlpha(theme.colors[theme.primaryColor][9], 0.3)
      }
      align={'center'}
      gap='xxs'
      p='xxs'

      style={{
        transition: 'all ease-in-out 0.1s',
        borderRadius: theme.radius.xxs
      }}
    >
      <FontAwesomeIcon icon={props.icon as IconName} 
        style={{
          fontSize: theme.fontSizes.xs
        }}
      />
      <Text size="xs">{props.value}</Text>
    </Flex>
  )
}