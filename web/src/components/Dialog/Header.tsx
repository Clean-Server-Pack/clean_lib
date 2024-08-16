import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text } from "@mantine/core";
import MetadataContainer from "./Metadata";
import { Title } from "./Title";

type HeaderProps = {
  icon: IconProp;
  title: string;
  dialog: string;
  prevDialog?: string;
}

function Header(props: HeaderProps) {

  return (
    <Flex 
      direction='column'
    >
      <Flex
        direction='row'
        align='center'
        justify='space-between'
      >
        <Title  icon={props.icon as string} title={props.title.toUpperCase()}  />
        <MetadataContainer metadata={[{label: 'Dialog', data: 'testing something'}]} />
      </Flex>
      <Text
        pt='xs'
        pb='xs'
        c='lightgrey'
        style={{
          fontStyle : 'italic',
          fontFamily: 'Akrobat Bold',
        }}
      >{props.dialog}</Text>
    </Flex>
  )

}


export default Header;