import { Flex, Title, Text } from "@mantine/core";

function Notification(){
  
  return (
    <Flex
      bg='rgba(0,0,0,0.8)'
      w='25%'
      h='25%'
    >
      <Title order={1} ta='center'>Notification</Title>
      <Text>This is our notification</Text>

    </Flex>
  )
}

function NotificationContainer(){
  return (
    <Flex
      pos='absolute'
      right='5%'
      top='5%'
      w='25%'
      h='25%'
    >
      <Notification />
      <Notification /> 
      <Notification />
    </Flex>
  )
}

export default NotificationContainer;


