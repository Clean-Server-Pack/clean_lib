import NotificationContainer from "./NotificationContainer";

export default function Notifications(){
  return ( 
    <>
      <NotificationContainer position="bottom-right" />
      <NotificationContainer position="top-right" />
      <NotificationContainer position="top-left" />
      <NotificationContainer position="bottom-left" />
    </>
  )
}