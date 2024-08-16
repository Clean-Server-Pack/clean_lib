import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import Progress from "./Progress";


export type MetadataProps = {
  icon?: IconProp,
  label: string,
  data: string,
  type?: string,
  progress?: number
}


function Metadata(props: MetadataProps) {
  const theme = useMantineTheme();


  return (
    <Flex
      w='fit-content'
      h='60%'
      style={{
        borderRadius: theme.radius.xs,
        overflow: 'hidden',
        border: `1px solid rgba(77,77,77,0.6)`
      }}
      align='center'
      direction='column'
    >

      <Flex
      align='center'
      >
        <Flex
          p='xs'
          bg='rgba(77,77,77,0.2)'
          direction='column'
          justify='center'
          align='center'
        >
          <Text c='lightgrey' size='xs'
            style={{
              fontFamily: 'Akrobat Bold'
            }}>{props.label}</Text>
        </Flex>

        <Flex
          p='xs'
          bg='rgba(77,77,77,0.5)'
          direction='column'
          align='center'
          justify='center'
        >
          <Text c='lightgrey' size='xs'
            style={{
              fontFamily: 'Akrobat Bold'
            }}
          >{props.data}</Text>
        </Flex>

      </Flex>

      {
        props.progress && (
          <Progress value={props.progress} />
        )
      }

    </Flex>
  );
}




export type MetadataContainerProps = {
  metadata: MetadataProps[];
}

function MetadataContainer(props: MetadataContainerProps) {
  return (
    <Flex
      p='sm'
    >
      {props.metadata.map((meta, index) => {
        return (
          <Metadata key={index} {...meta} />
        )
      })}
    </Flex>
  )
}


export default MetadataContainer;