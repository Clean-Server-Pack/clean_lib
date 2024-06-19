import { IconName } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Text } from "@mantine/core";
import { useHover } from "@mantine/hooks";
import { useMemo } from "react";
import { MenuProps } from "./main";
import { fetchNui } from "../../utils/fetchNui";

function Button(props: { icon: IconName, onClick?: () => void}) {
  const { hovered, ref } = useHover();
  return (
    <Flex
      ref={ref}
      bg={hovered ? 'rgba(0,0,0,0.5)' : 'rgba(0,0,0,0.3)'}
      p='0.5vh'
      style={{
        borderRadius: 'var(--mantine-radius-sm)',
        cursor: 'pointer',
        border: hovered ? '1px solid var(--mantine-primary-color-9)' : '1px solid transparent',
        justifyContent: 'center',
        transition: 'all ease-in-out 0.1s',
      }}

      onClick={props.onClick}
    >
      <FontAwesomeIcon icon={['fas', props.icon]} style={{ color: 'white' }} size='lg'/>
    </Flex>
  )
}

type MenuTitleProps = {
  title: string;
  icon: IconName | string; 
  description?: string;
  dialog?: string;
  canClose?: boolean;
  setMenuOpen: (menu: false | MenuProps) => void;
  menu?: string;
};
export function MenuTitle(props: MenuTitleProps) {
  const is_icon = useMemo(() => {
    //  CHECK IF IS A HTTPS STRING
    if (typeof props.icon === 'string' && props.icon.startsWith('https')) {
      return false;
    }
    return true;
  }, [props.icon]);

  return (
    <Flex
      w='80%'
      direction='row'
      gap='sm'
      p='sm'
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        lineHeight: '2rem',
        borderBottom: '1px solid var(--mantine-primary-color-9)',
      }}
    >


      <Flex direction='row' gap='sm' w='100%' style={{ alignItems: 'center'}}>
        {props.menu || props.dialog ? 
          <Button icon='arrow-left' 
            onClick={function(){
              if (props.menu) {
                fetchNui('openContext', {
                  back:true, 
                  id: props.menu
                })
              }

              if (props.dialog) {
                fetchNui('openDialog', {
                  id: props.dialog,
                  back:true,
                })
              }
              

            }}
          />
          :
          <></>
        }
        
        <Flex
          gap='sm'
          style={{
            alignItems: 'center', 

            marginLeft: 'auto',
            marginRight: 'auto',
          }}
        >
          {props.icon && is_icon ? (
            <FontAwesomeIcon icon={['fas', props.icon as IconName]} style={{ color: 'white' }} size='lg' />  
          ) : (
            <img src={props.icon} alt='icon' style={{ width: '1.5rem', height: '1.5rem' }} />
          )}

          <Text size='1.8rem' style={{ color: 'white' }}>{props.title}</Text>

        </Flex>
      
        {props.canClose && 
          <Button icon='times'
            onClick={function(){
              props.setMenuOpen(false)
              fetchNui('closeContext')
            }}
          />
        }
      </Flex>

      {props.description && (
        <Text size='sm' style={{ color: 'rgba(255,255,255,0.8)' }}>
          {props.description}
        </Text>
      )}
    </Flex>
  );
}
