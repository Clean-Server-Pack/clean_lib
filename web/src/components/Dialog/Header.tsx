import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text } from "@mantine/core";
import MetadataContainer, { MetadataProps } from "./Metadata";
import { Title } from "./Title";
import { fetchNui } from "../../utils/fetchNui";

type HeaderProps = {
  icon: IconProp;
  title: string;
  dialog: string;
  metadata?: MetadataProps[];
  prevDialog?: string;
}

function Header(props: HeaderProps) {

  return (
    <Flex 
      direction='column'
      mb='xxs'
      // bg='red'
    >
      <Flex
        direction='row'
        align='center'
        justify='space-between'
      >
        <Title  icon={props.icon as string} title={props.title.toUpperCase()} 
          backButton={props.prevDialog ? true : false} 
          onBack={() => {
            fetchNui('DIALOG_GO_BACK') 
          }}
          // description={props.prevDialog}
        />
        {props.metadata && <MetadataContainer metadata={props.metadata} />}
      </Flex>
      <Text
        pt='1vh'
        pb='1vh'
        c='rgba(255,255,255,0.6)'
        size='xs'
        style={{
          // fontStyle : 'italic',
          // fontFamily: 'Akroba',
        }}
      >{props.dialog}</Text>
    </Flex>
  )

}


export default Header;