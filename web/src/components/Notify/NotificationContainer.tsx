import { Flex } from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import Notification, { NotificationProps } from "./Notification";

export type NotificationContainerProps = {
  position: 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right';
}

function NotificationContainer(props: NotificationContainerProps) {
  const [notifications, setNotifications] = useState<NotificationProps[]>([]);

  useNuiEvent('ADD_NOTIFICATION', (data: NotificationProps) => {
    if (data.position !== props.position) return;

    const existingNotification = notifications.find((n) => n.title === data.title && n.description === data.description && props.position === data.position && n.icon === data.icon);
    if (existingNotification) {
      existingNotification.count = (existingNotification.count || 1) + 1;
      setNotifications([...notifications]);
      return;
    }

    setNotifications([...notifications, data]);
  });

  useNuiEvent('CLEAR_NOTIFICATIONS', () => {
    setNotifications([]);
  });

  useEffect(() => {
    // Create an array of timers for each notification
    const timers = notifications.map((notification) => {
      const hideTimer = setTimeout(() => {
        notification.hide = true;
        setNotifications((prevNotifications) => [...prevNotifications]);

        const removeTimer = setTimeout(() => {
          // remove by matching rather than index in case index changes
          setNotifications((prevNotifications) => prevNotifications.filter((n) => n !== notification));
        }, 100);

        return () => clearTimeout(removeTimer);
      }, notification.duration || 5000);

      return () => clearTimeout(hideTimer); // Cleanup for hide timer
    });

    // Cleanup timers on unmount or when notifications change
    return () => {
      timers.forEach((clearTimer) => clearTimer());
    };
  }, [notifications]);

  return (
    <Flex
      direction="column"
      gap="xs"
      w="20%"
      h="fit-content"
      pos="absolute"
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
  );
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
//         icon: 'exclamation-triangle',
//         iconColor: 'rgba(255,0,0,0.8)',
//         position: 'top-right',
//         duration: 50000,
//       }
//     }
//   ])
  
// },500)

