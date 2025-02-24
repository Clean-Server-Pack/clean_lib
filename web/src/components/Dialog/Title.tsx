import { IconName } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import BorderedIcon from "../Generic/BorderedIcon";
import Button from "../Generic/Button";



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
        gap='sm'
      >
        <BorderedIcon
          icon={props.icon as IconName}
          fontSize={theme.fontSizes.sm}
        />
        <Flex
          direction='column'
        >
          <Text p='0' size='sm' style={{
            fontFamily: 'Akrobat Black'
          }}>{props.title}</Text>
          <Text 
            size='xs'
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
