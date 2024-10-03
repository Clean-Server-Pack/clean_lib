import { Flex } from "@mantine/core"
import { useState } from "react"

type MenuItemProps = {
  id: string, // ID of the menu item
  icon: string, // Icon of the menu item
  label: string, // Label of the menu item
  subMenu?: MenuItemProps[], // Submenu of the menu item
}


type RadialMenuProps = {
  size: number, // Size of the radial menu
  radius: number, // Radius of the radial menu
  innerRadius: number, // Inner radius of the radial menu
  sectorSpace: number, // Space between sectors
  sectorCount: number, // Number of sectors
  scale: number, // Scale of the radial menu
  minSectors: number, // Minimum number of sectors
  

  onClick: (id: string) => void, // Callback function when an item is clicked
  menuItems: MenuItemProps[], // List of menu items
}

export default function Radial(){
  const [currentItems, setCurrentItems] = useState<MenuItemProps[]>([])
  const [radialSettings, setRadialSettings] = useState<RadialMenuProps>({
    size: 150,
    radius: 55,
    innerRadius: 18,
    sectorSpace: 3.5,
    minSectors: 3,
    sectorCount: Math.max(currentItems.length, 3),
    scale: 1,
    onClick: (id: string) => {},
    menuItems: []
  })  
  
  return (
    <Flex
      bg='red'
      w='25%'
      h='25%'
      pos='absolute'
      left='50%'
      top='50%'
      style={{
        transform: 'translate(-50%, -50%)'
      }}
    >

    </Flex>
  )
}