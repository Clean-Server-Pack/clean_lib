import { IconName } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import { useHover } from "@mantine/hooks";
import { fetchNui } from "../../utils/fetchNui";
import { ResponseProps } from "./Responses";
import { Title } from "./Title";
import colorWithAlpha from "../../utils/colorWithAlpha";

export function Response(props: ResponseProps) {
  const { hovered, ref } = useHover();
  const is_empty = props.actionid == 'empty';
  const theme = useMantineTheme();
  return (
    <Flex
      ref={ref}
      bg={is_empty ? 'rgba(77,77,77,0.0)' : !props.disabled ? hovered ? 'rgba(77,77,77,0.8)' : 'rgba(77,77,77,0.6)' : 'rgba(77,77,77,0.4)'}
      p='0.75vh'
      style={{
        borderRadius: theme.radius.xs,
        cursor: !props.disabled? is_empty ? 'default' : 'pointer': 'not-allowed',
        outline: !props.disabled ? is_empty ? '2px solid rgba(0,0,0,0.00)' : hovered ? `2px solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : '2px solid rgba(0,0,0,0.2)': '2px solid rgba(0,0,0,0.2)',
      }}
      direction='column'

      justify='center'
      h='9vh'
      onClick={() => {
        if (is_empty) return;
        fetchNui("dialogSelected", { actionid: props.actionid });
      }}
      gap='0.5vh'
    >
      <Flex
        gap='sm'
        align='center'
      >
        <Title icon={props.icon as IconName} title={props.label} fontSize="1vh"/>
      </Flex>
      <Text size='1.5vh' style={{
        // italic 
        fontStyle: 'italic',
        // textOverflow: 'ellipsis',
        overflowY: 'auto',
      }}>{props.description}</Text>
    </Flex>
  );
}
