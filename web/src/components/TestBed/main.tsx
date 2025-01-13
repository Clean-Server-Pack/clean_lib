import { useEffect, useState } from "react"
import { isEnvBrowser } from "../../utils/misc"
import { Checkbox, Flex, Text, useMantineTheme } from "@mantine/core"
import { useNuiEvent } from "../../hooks/useNuiEvent"
import { internalEvent } from "../../utils/internalEvent"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { IconProp } from "@fortawesome/fontawesome-svg-core"
import { useHover } from "@mantine/hooks"
import colorWithAlpha from "../../utils/colorWithAlpha"
import { defaultTestItems, TestItemProps } from "./testItems"
import { fetchNui } from "../../utils/fetchNui"




export default function TestBed() {
  const theme = useMantineTheme() 
  const [rawDisplay, setRawDisplay] = useState(false)
  const [testMode, setTestMode] = useState(isEnvBrowser())
  const [expanded, setExpanded] = useState(false)
  const [testItems, setTestItems] = useState<TestItemProps[]>(defaultTestItems)


  useEffect(() => {
    if (testMode) {
      setTimeout(() => {
        setRawDisplay(true)
      }, 200)
    }
  }, [testMode])

  useNuiEvent('OPEN_TEST_UI', () => {
    setTestMode(!testMode)
  })

  // listen for escape key
  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === "Escape" && testMode) {
        for (const item of testItems) {
          if(item.active){
            item.toggleActive()
          }
        } 

        setRawDisplay(false)
        setTimeout(() => {
          setTestMode(false)
        }, 200)

        fetchNui('CLOSED_TEST_UI', {})
      }
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  } , [testMode]);


  
  return testMode && (
    <Flex
      direction='column'
      align='center'
      pos='absolute'
      top='1vh'
      left={rawDisplay ? '1vh' : '-25vh'}
      bg='rgba(0,0,0,0.5)'
      w='25vh'
      gap='xxs'
      h='fit-content'
      p='xxs'
      style={{
        userSelect: 'none',
        transition: 'all 0.2s ease-in-out',
        borderRadius: theme.radius.xxs,
      }}
    >
      <Flex
        align='center'
        gap='xs'
        p='xs'
        onClick={() => setExpanded(!expanded)}
        style={{
          cursor: 'pointer'
        }}
        miw='100%'
      >
        <FontAwesomeIcon icon={'fas fa-mouse-pointer' as IconProp} /> 
        <Text size='xs'>{expanded ? 'HIDE' : 'SHOW'} TEST ITEMS</Text>
      </Flex>

      {expanded && testItems.map((item) => (
        <TestItem  {...item} 
        
          toggleActive={() => {
            setTestItems(testItems.map((i) => {
              if(i.index === item.index){
                return {
                  ...i,
                  active: !i.active
                }
              }
              return i
            }))
          }}
        />
      ))}
    </Flex>
  )
}


export function TestItem(props:TestItemProps){
  const {ref, hovered} = useHover()
  const theme = useMantineTheme()
  return (
    <Flex
      ref={ref}
      bg={hovered ? 'rgba(77, 77, 77, 0.8)' : 'rgba(77,77,77,0.5)'}
      w='100%'
      p='xs'
      align='center'
      
      style={{
        borderRadius: theme.radius.xxs,
        transition: 'all 0.2s ease-in-out',
        cursor: 'pointer', 
        outline: hovered ? `0.2vh solid ${colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.9)}` : '0.2vh solid transparent' 
      }}

      onClick={() => {
        props.toggleActive()
        // internalEvent(props.active ? props.onDisable : props.onEnable)  
        internalEvent([
          {
            action: props.active ? props.onDisable.action : props.onEnable.action,
            data: props.active ? props.onDisable.data : props.onEnable.data
          }
        ])
      }}
    >
      <Flex
        gap='xxs'
        align='center'
      >
        <FontAwesomeIcon 
          icon={props.icon as IconProp} 
          style={{
            minWidth: '2vh',
            fontSize: theme.fontSizes.xs,
          }}  
        />

        <Text size='xs'>{props.label}</Text>
      </Flex>
      <Checkbox ml='auto' checked={props.active}  /> 
    </Flex>
  )
}