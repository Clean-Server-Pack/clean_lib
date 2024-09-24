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
  mt?: string;
  closeButton?: boolean;
  onClose?: () => void;
};

export function Title(props: TitleProps) {
  
  const theme = useMantineTheme();
  return (
    <Flex
      mt={props.mt}
      direction='column'
      align='center'
      gap='xs'
      w='90%'
      
      pb='sm'
      style={{
        borderBottom: `1px solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.5)}`,
      }}
    >
      <Flex
   
        align='center'
        justify={'center'}
        w='90%'
      >
        {props.backButton && (
          <Button mr='xs' icon='fa-arrow-left' onClick={props.onBack} />
        )}

        <Flex
          align='center'
          gap='xs'
        >
          <FontAwesomeIcon
            icon={props.icon as IconName}
            style={{
              boxShadow: 'inset 0 0 1.75vh 0.5vh rgba(0, 0, 0, 0.8)',
              backgroundColor: colorWithAlpha(theme.colors[theme.primaryColor][9], 0.5),
              padding: theme.spacing.xs,
              borderRadius: theme.radius.xs,
              border: `1px solid var(--mantine-primary-color-9)`,
              fontSize: '2.5vh'
            }} 
          />
          <Flex
            direction='column'
            gap='0.25vh'
          >
            <Text p='0' size='2.25vh' style={{
              fontFamily: 'Akrobat Bold'
            }}>{props.title}</Text>
            <Text 
              size='1.8vh'
              c='grey'
            >{props.description}</Text>
          </Flex>


        </Flex>
        {props.closeButton && (
          <Button ml='auto' icon='fa-times' onClick={props.onClose} />
        )}
      </Flex>
    </Flex>
  );
}
