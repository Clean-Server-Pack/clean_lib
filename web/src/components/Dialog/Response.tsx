import { fetchNui } from "../../utils/fetchNui";
import { MenuItem } from "../Generic/MenuItem";
import { ResponseProps } from "./Responses";


export function Response(props: ResponseProps) {
  const is_empty = props.actionid == 'empty';

  const handleClick = () => {
    if (is_empty) return;
    fetchNui("dialogSelected", { actionid: props.actionid });
  }

  return (
    <MenuItem
      clickSounds={props.clickSounds !== false && props.clickSounds !== null && props.clickSounds !== undefined}
      hoverSounds={props.hoverSounds !== false && props.hoverSounds !== null && props.hoverSounds !== undefined}
      title={props.label}
      disabled={is_empty}
      onClick={handleClick}
      hide={is_empty}
      icon={props.icon as string || 'question'}
    />
  );
}
