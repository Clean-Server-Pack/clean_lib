import { IconName } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";
import BorderedIcon from "./BorderedIcon";
import Button from "./Button";


type TitleProps = {
  title: string
  description: string;
  icon: string;
  backButton?: boolean;
  onBack?: () => void;
  mt?: string;
  closeButton?: boolean;
  removeBorder?: boolean;
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
      
      pb={!props.removeBorder ? 'md': '0'}
      style={{
        borderBottom: !props.removeBorder ? `0.2vh solid ${colorWithAlpha(theme.colors[theme.primaryColor][9], 0.5)}`: 'none',
      }}
    >
      <Flex
   
        align='center'
        justify={'center'}
        w='90%'
      >

        <Flex
          align='center'
          gap='sm'
        >
          <BorderedIcon
            icon={props.icon as IconName}
            fontSize={theme.fontSizes.md}
          />
          <Flex
            direction='column'
            gap='0.25vh'
          >
            <Text p='0' size='md' style={{
              lineHeight: theme.fontSizes.md,
              fontFamily: 'Akrobat Bold'
            }}>{props.title}</Text>
            <Text 
              size='xs'
              c='grey'
            >{props.description}</Text>
          </Flex>


        </Flex>
        
        <Flex
          ml='auto'
          align='center'
          gap='xs'
        >
        {props.backButton && (
          <Button icon='fa-arrow-left' onClick={props.onBack}/> 
        )}

        {props.closeButton && (
          <Button icon='fa-times' onClick={props.onClose} 
        hoverColor='red'
          />
        )}

        </Flex>
      </Flex>
    </Flex>
  );
}
