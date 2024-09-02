import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useMantineTheme, Flex, Text } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";
import Button from "./Button";


type TitleProps = {
  title: string
  description: string;
  icon: string;
  backButton?: boolean;
  onBack?: () => void;

  closeButton?: boolean;
  onClose?: () => void;
};

export function Title(props: TitleProps) {
  
  const theme = useMantineTheme();
  return (
    <Flex
    
      align='center'
      gap='xs'
      w='80%'
    >
      {props.backButton && (
        <Button icon='fa-arrow-left' onClick={props.onBack} />
      )}

      <Flex
        align='center'
        gap='xs'
      >
        <FontAwesomeIcon
          icon={props.icon as IconName}
          style={{
            backgroundColor: colorWithAlpha(theme.colors[theme.primaryColor][9], 0.5),
            padding: theme.spacing.xs,
            borderRadius: theme.radius.xs,
            border: `1px solid var(--mantine-primary-color-9)`,
            fontSize: '2vh'
          }} 
        />
        <Flex
          direction='column'
        >
          <Text p='0' size='lg' style={{
            fontFamily: 'Akrobat Bold'
          }}>{props.title}</Text>
          <Text 
            size='md'
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
