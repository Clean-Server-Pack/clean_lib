import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";



type BorderedIconProps = {
  icon: string;
  color?: string;
  fontSize?: string;
  hovered?: boolean;
  hoverable?: boolean;
}

export default function BorderedIcon(props: BorderedIconProps){
  const theme = useMantineTheme();
  return (
    <FontAwesomeIcon
      icon={props.icon as IconName}
      color={colorWithAlpha(props.color ? props.color : theme.colors[theme.primaryColor][theme.primaryShade as number], props.hovered ? 0.9: 0.9)}
      style={{
        backgroundColor: colorWithAlpha(props.color ? props.color : theme.colors[theme.primaryColor][7 as number], (props.hoverable ? (props.hovered ? 0.3 : 0.2) : 0.2)),
        padding: theme.spacing.xs,
        transition: 'all 0.2s ease-in-out',
        aspectRatio: '1/1', 
        fontSize: props.fontSize ? props.fontSize: '2.5vh',
        borderRadius: theme.radius.xxs,
        // border: `2px solid var(--mantine-primary-color-9)`,
        outline: `0.2vh solid ${colorWithAlpha(props.color ? props.color : theme.colors[theme.primaryColor][9], 0.8)}`,
        boxShadow: 'inset 0 0 10px rgba(0,0,0,0.6)',
      }}
    />
  )
}