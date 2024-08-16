import { Flex } from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { internalEvent } from "../../utils/internalEvent";
import Notification, { NotificationProps } from "./Notification";



export type NotificationContainerProps = {
  position: 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right'  
}

function NotificationContainer(props: NotificationContainerProps) {
  const [notifications, setNotifications] = useState<NotificationProps[]>([])

  useNuiEvent('ADD_NOTIFICATION', (notification: NotificationProps) => {
    if (notification.position !== props.position) return
    // if everything in the notification is the same as another then update the count
    const existingNotification = notifications.find((n) => n.title === notification.title && n.message === notification.message && props.position === notification.position && n.icon === notification.icon)
    if (existingNotification) {
      existingNotification.count = (existingNotification.count || 1) + 1
      setNotifications([...notifications])
      return
    } 

    setNotifications([...notifications, notification])
  })

  useNuiEvent('CLEAR_NOTIFICATIONS', () => {
    setNotifications([])
  })

  // timers for duration
  useEffect(() => {
    notifications.forEach((notification, index) => {

    setTimeout(() => {
      notification.hide = true
      setNotifications([...notifications])
      setTimeout(() => {
        // remove the notification
        setNotifications(notifications.filter((n, i) => i !== index))
      }, 500)
    }, notification.duration || 5000)
  
    })
  }, [notifications])

  return (
    // <></>
    <Flex      
      direction='column'
      gap='xs'
      w='20%'
      h='fit-content'

      pos='absolute'
      
      style={{
        top: props.position?.includes('top') ? '1rem' : 'unset',
        bottom: props.position?.includes('bottom') ? '1rem' : 'unset',
        left: props.position?.includes('left') ? '1rem' : 'unset',
        right: props.position?.includes('right') ? '1rem' : 'unset',
      }}

    > 
      {notifications.map((notification, index) => (
        <Notification {...notification} key={index} />
      ))}
    </Flex>
  )
}

export default NotificationContainer;


// internalEvent([
//   {
//     action: 'ADD_NOTIFICATION',
//     data: {
//       title: 'Item Removed',
//       description: '1 x Marked Bills has been removed from your inventory',
//       icon: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/illegal/markedbills.png',
//       iconColor: 'rgba(255,255,255,0.4)',
//       position: 'top-right',
//       duration: 50000,
//     }
//   }
// ])

// setTimeout(() => {
//   internalEvent([
//     {
//       action: 'ADD_NOTIFICATION',
//       data: {
//         title: 'Item Removed',
//         message: '1 x Marked Bills has been removed from your inventory',
//         icon: 'https://raw.githubusercontent.com/fazitanvir/items-images/main/illegal/markedbills.png',
//         iconColor: 'rgba(255,255,255,0.4)',
//         position: 'top-right',
//         duration: 50000,
//       }
//     }
//   ])
  
// },500)

