import { Text } from "@mantine/core";
import SideBar from "../Generic/SideBar";
import { Title } from "../Generic/Title";

export default function Input(){
  return (
    <SideBar
      menuOpen={true}
      setMenuOpen={() => {}}
      escapeClose={true}
      w='28vw'
      h='100vh'
    >
      <Title
      
        title={'Input'} 
        description={''} 
        icon={'user'}
        backButton={true} closeButton={true}
      />

    </SideBar>
  )
}