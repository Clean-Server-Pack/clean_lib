import { Checkbox, ColorInput, Flex, NumberInput, Text, TextInput } from "@mantine/core";
import SideBar from "../Generic/SideBar";
import { Title } from "../Generic/Title";
import { useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { internalEvent } from "../../utils/internalEvent";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { IconProp } from "@fortawesome/fontawesome-svg-core";

type InputProps = 
  | {
      type: 'input';
      label: string;
      description?: string;
      placeholder?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: string;
      password?: boolean;
      min?: number;
      max?: number;
    }
  | {
      type: 'number';
      label: string;
      description?: string;
      placeholder?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: number;
      min?: number;
      max?: number;
      precision?: number;
      step?: number;
    }
  | {
      type: 'checkbox';
      label: string;
      checked?: boolean;
      disabled?: boolean;
      required?: boolean;
    }
  | {
      type: 'color';
      label: string;
      description?: string;
      placeholder?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: string;
      format?: 'hex' | 'hexa' | 'rgb' | 'rgba' | 'hsl' | 'hsla';
    }
  | {
      type: 'date';
      label: string;
      description?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: string | true;
      format?: string;
      returnString?: boolean;
      clearable?: boolean;
      min?: string;
      max?: string;
    }
  | string; // Will just be a normal input with this string as the label


type InfoProps = {
  title: string;
  description?: string;
  icon: string;
  backButton?: string;
  canClose?: boolean;
}

export default function Input(){
  const [opened, setOpened] = useState<boolean>(false)
  const [mainInfo, setMainInfo] = useState<InfoProps>({
    title: 'Input',
    description: 'Enter the description for this input?',
    icon: 'user',
    backButton: 'menu_to_return_to',
    canClose: true,
  })

  const [inputs, setInputs] = useState<InputProps[]>([])


  useNuiEvent('OPEN_INPUT', (data: {info: InfoProps, inputs: InputProps[]}) => {
    setMainInfo(data.info)
    setInputs(data.inputs)
    setOpened(true)
  })

  useNuiEvent('CLOSE_INPUT', () => {
    setOpened(false)
  })

  return (
    <SideBar
      menuOpen={opened}
      setMenuOpen={() => {setOpened(!opened)}}
      escapeClose={mainInfo.canClose}
      w='28vw'
      h='100vh'
      style={{
        // backdropFilter: 'blur(2px)',
        display:'flex',
        flexDirection:'column',
        alignItems:'center',
        gap:'1rem',
        userSelect:'none',

      }} 
    >
      <Title
        mt='14vh'
        title={mainInfo.title}
        description={mainInfo.description || ''}
        icon={mainInfo.icon}
        backButton={true} closeButton={true}
      />
      <Flex
        direction='column'
      >
        {inputs.map((input, index) => (
          typeof input === 'object' ? <CustomInput key={index} {...input} /> : <CustomInput key={index} label={input} type="input" />
        ))}
      </Flex>
    </SideBar>
  )
}

function CustomInput(props: InputProps){
  const isSimple = function(input: InputProps): input is string {
    return typeof input === 'string'
  }

  return (
    <Flex
      direction='column'
      gap='0.5rem'
    >
      <Flex>
        {props.icon && <FontAwesomeIcon icon={props.icon as IconProp} style={{marginRight:'0.5rem'}} />}

        <Text>{isSimple(props) ? props : props.label}</Text>
      </Flex>
      {isSimple(props) ? 
        <TextInput/>
      : props.type === 'input' ?
        <TextInput placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} type={props.password ? 'password' : 'text'} min={props.min} max={props.max} />
      : props.type === 'number' ?
        <NumberInput placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} min={props.min} max={props.max} step={props.step} />
      : props.type === 'checkbox' ?
        <Checkbox checked={props.checked} disabled={props.disabled} required={props.required} />
      : props.type === 'color' ?
        <ColorInput placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} format={props.format} />
      : <></>
      }

    </Flex>
  )
}

internalEvent([
  {
    action: 'OPEN_INPUT',
    data: {
      inputs: [
        'Username',
        'Password',
      ],
      info: {
        title: 'Login',
        description: 'Enter your login information below',
        icon: 'user',
        backButton: 'menu_to_return_to',
        canClose: true,
      }
    }
  }
])
