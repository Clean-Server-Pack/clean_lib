import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { Flex, Text, useMantineTheme } from "@mantine/core";
import Progress from "./Progress";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";


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
        borderRadius: theme.radius.xxs,
        overflow: 'hidden',
        border: `0.1vh solid rgba(77,77,77,0.3)`
      }}
      align='center'
      direction='column'
    >

      <Flex
      align='center'
      >
        <Flex
          h='100%'
          p='0.5vh'
          bg='rgba(77,77,77,0.8)'
          direction='row'
          gap='xs'
          justify='center'
          align='center'

        >
          {props.icon && (
            <FontAwesomeIcon icon={props.icon} color='rgba(255,255,255,0.6)' 
              style={{
                fontSize: '1.3vh'
              }}
            />
          )}
          <Text c='lightgrey' size='1.3vh'
            style={{
              fontFamily: 'Akrobat Bold'
            }}>{props.label}</Text>
        </Flex>

        <Flex
          h='100%'
          flex={1}
          p='0.5vh'
          bg='rgba(77,77,77,0.6)'
          direction='column'
          align='center'
          justify='center'
        >
          <Text c='lightgrey' size='1.3vh'
            style={{
              fontFamily: 'Akrobat Bold'
            }}
          >{props.data}</Text>
        </Flex>

      </Flex>

      {props.progress != null && 
        <Progress value={props.progress} />
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
      gap='xs'
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