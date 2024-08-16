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
      bg={is_empty ? 'rgba(77,77,77,0.0)' : hovered ? 'rgba(77,77,77,0.8)' : 'rgba(77,77,77,0.6)'}
      p='5px'
      style={{
        borderRadius: theme.radius.xs,
        cursor: is_empty ? 'default' : 'pointer',
        outline: is_empty ? '2px solid rgba(0,0,0,0.00)' : hovered ? `2px solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.8)}` : '2px solid rgba(0,0,0,0.2)',
      }}
      direction='column'

      justify='center'
      h='9vh'
      onClick={() => {
        if (is_empty) return;
        console.log(JSON.stringify(props, null, 2));
        fetchNui("dialogSelected", { actionid: props.actionid });
      }}
    >
      <Flex
        gap='sm'
        align='center'
      >
        <Title icon={props.icon as IconName} title={props.label} />
      </Flex>
      <Text size='xs' style={{
        // italic 
        fontStyle: 'italic',
        // textOverflow: 'ellipsis',
        overflowY: 'auto',
      }}>{props.description}</Text>
    </Flex>
  );
}
