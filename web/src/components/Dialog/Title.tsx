import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useMantineTheme, Flex, Text } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";
import Button from "../Generic/Button";
import BorderedIcon from "../Generic/BorderedIcon";



type TitleProps = {
  title: string
  description?: string;
  icon: string;
  backButton?: boolean;
  onBack?: () => void;
  fontSize?: string;

  closeButton?: boolean;
  onClose?: () => void;
};

export function Title(props: TitleProps) {
  
  const theme = useMantineTheme();
  return (
    <Flex
      align='center'
      gap='1vh'
    >
      {props.backButton && (
        <Button icon='fa-arrow-left' onClick={props.onBack} />
      )}

      <Flex
        align='center'
        gap='1vh'
      >
        <BorderedIcon
          icon={props.icon as IconName}
          fontSize={props.fontSize}
        />
        <Flex
          direction='column'
        >
          <Text p='0' size='2vh' style={{
            fontFamily: 'Akrobat Black'
          }}>{props.title}</Text>
          <Text 
            size='1.5vh'
            c='grey'
          >{props.description}</Text>
        </Flex>


      </Flex>
      {props.closeButton && (
        <Button ml='auto' icon='fa-times' onClick={props.onClose} />
      )}
    </Flex>
  );
}
