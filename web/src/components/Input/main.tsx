import { Button, Checkbox, ColorInput, Flex, MultiSelect, NumberInput, Select, Slider, Text, Textarea, TextInput, useMantineTheme } from "@mantine/core";
import SideBar from "../Generic/SideBar";
import { Title } from "../Generic/Title";
import { useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { internalEvent } from "../../utils/internalEvent";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { DateInput, DatePicker, DatePickerInput } from "@mantine/dates";
import { useForm } from "@mantine/form";



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
      description?: string;
      icon?: string;
      checked?: boolean;
      disabled?: boolean;
      required?: boolean;
    }
  | {
      type: 'select' | 'multi-select';
      label: string;
      description?: string;
      icon?: string;
      options: { value: string; label?: string }[];
      placeholder?: string;
      required?: boolean;
      disabled?: boolean;
      default?: string | string[]; // string[] for multi-select
      clearable?: boolean;
      searchable?: boolean;
      maxSelectedValues?: number; // Only for multi-select
    }
  | {
      type: 'slider';
      label: string;
      description?: string;
      icon?: string;
      placeholder?: string;
      required?: boolean;
      disabled?: boolean;
      default?: number;
      min?: number;
      max?: number;
      step?: number;
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
      default?: string | true; // true defaults to current date
      format?: string;
      returnString?: boolean;
      clearable?: boolean;
      min?: string; // "01/01/2000"
      max?: string; // "12/12/2023"
    }
  | {
      type: 'date-range';
      label: string;
      description?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: [string, string];
      format?: string;
      returnString?: boolean;
      clearable?: boolean;
    }
  | {
      type: 'time';
      label: string;
      description?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: string;
      format?: '12' | '24';
      clearable?: boolean;
    }
  | {
      type: 'textarea';
      label: string;
      description?: string;
      placeholder?: string;
      icon?: string;
      required?: boolean;
      disabled?: boolean;
      default?: string;
      min?: number;
      max?: number;
      autosize?: boolean; // If true, textarea will grow with content until max rows are reached
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

  const form = useForm()

  const theme = useMantineTheme();

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

      <form
        style={{
          width: '90%',
          display: 'flex',
          flexDirection: 'column',
          gap: '1rem',          
          marginBottom: '2rem',
          padding: theme.spacing.xs,
        }}
      >
        <Flex
          direction='column'
          gap='1rem'
          style={{
            scrollbarGutter: 'stable',
            overflowY: 'auto',
            maxHeight: '70vh',
            padding: theme.spacing.xs,
          }}
        >
          {inputs.map((input, index) => (
            typeof input === 'object' ? <CustomInput key={index} {...input} /> : <CustomInput key={index} label={input} type="input" />
          ))}
        </Flex>

        <Flex
          gap='xs'
          justify='space-between'
        >
          <Button 
            flex={1}
          >Cancel</Button>
          <Button
            type='submit'
            variant='filled'
            flex={1}
          >Submit</Button>
        </Flex>
      </form>

    </SideBar>
  )
}

function CustomInput(props: InputProps & {onChanged?: (value: unknown) => void}){
  const isSimple = function(input: InputProps): input is string {
    return typeof input === 'string'
  }
  const theme = useMantineTheme();
  return (
    <Flex
      direction='column'
      gap='0.5rem'
      w='100%'
      p='xs'
      bg='rgba(77,77,77,0.5)'
      style={{
        borderRadius: theme.radius.sm,
        filter: 'drop-shadow(0px 0px 5px rgba(0,0,0,0.5))',
      }}
    >
      <Flex
        direction='column'
      >
        <Flex
          align='center'
        >
          {typeof props !== 'string' && props.icon && <FontAwesomeIcon icon={props.icon as IconProp} style={{marginRight:'0.5rem'}} />}

          <Text
          
            style={{
              color: 'white',
              fontFamily: 'Akrobat Bold',
              fontSize: '1.8vh',
            }}
          >{isSimple(props) ? props : props.label}</Text>
        </Flex>
        {/* description if there is one */}
        {typeof props !== 'string' && props.description && <Text
          c='rgba(255,255,255,0.8)'
        >{props.description}</Text>}
      </Flex>
      <Flex
        direction={'column'}
        w='100%'
        align='center'

      >
        {isSimple(props) ? 
          <TextInput/>
        : props.type === 'input' ?
          <TextInput w='100%' placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} type={props.password ? 'password' : 'text'} min={props.min} max={props.max} />
        : props.type === 'number' ?
          <NumberInput w='100%' placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} min={props.min} max={props.max} step={props.step} />
        : props.type === 'checkbox' ?
          <Checkbox checked={props.checked} disabled={props.disabled} required={props.required} />
        : props.type === 'color' ?
          <ColorInput placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} format={props.format} />
        : props.type === 'select' ?
          <Select placeholder={props.placeholder} required={props.required} disabled={props.disabled} data={props.options} searchable={props.searchable} clearable={props.clearable} maxSelectedValues={props.maxSelectedValues} />
        : props.type === 'multi-select' ?
          <MultiSelect placeholder={props.placeholder} required={props.required} disabled={props.disabled} data={props.options} searchable={props.searchable} clearable={props.clearable} maxSelectedValues={props.maxSelectedValues} />
        : props.type === 'textarea' ?
          <Textarea placeholder={props.placeholder} required={props.required} disabled={props.disabled} defaultValue={props.default} autosize={props.autosize} resize={'both'} />
        : props.type === 'date-range' ?
          <DateInput 
          
            placeholder={props.placeholder} 
            required={props.required} 
            disabled={props.disabled} 
            clearable={props.clearable} 
            min={props.min} 
            max={props.max}
          />
        : props.type === 'date' ?
          <DateInput 
            placeholder={props.placeholder} 
            required={props.required} 
            disabled={props.disabled} 
            clearable={props.clearable} 
            min={props.min} 
            max={props.max}
          />
        : props.type === 'slider' ?
          <Slider w='100%' defaultValue={props.default} min={props.min} max={props.max} />
        : null}
      </Flex>

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
        {icon:'user', type: 'checkbox', label: 'Remember Me', description: 'Check this box to remember your login information', checked: true},
        {type: 'slider', label: 'Volume', description: 'Adjust the volume of the game', min: 0, max: 100, default: 50},
        {type: 'date', label: 'Date of Birth', description: 'Enter your date of birth', default: true, format: 'MM/DD/YYYY', returnString: true, clearable: true},
        {type: 'color', label: 'Primary Color', description: 'Select your primary color', default: '#7ac61f', format: 'hex'},
        {type: 'select', label: 'Language', description: 'Select your preferred language', options: [{value: 'en', label: 'English'}, {value: 'es', label: 'Spanish'}, {value: 'fr', label: 'French'}], placeholder: 'Select a language', required: true},
        {type: 'multi-select', label: 'Favourite Foods', description: 'Select your favourite foods', options: [{value: 'pizza', label: 'Pizza'}, {value: 'burger', label: 'Burger'}, {value: 'pasta', label: 'Pasta'}, {value: 'salad', label: 'Salad'}], placeholder: 'Select your favourite foods', required: true, clearable: true, maxSelectedValues: 2},
        {type: 'textarea', label: 'Bio', description: 'Enter a short bio about yourself', placeholder: 'Enter your bio here', required: true, autosize: false},
        {type: 'time', label: 'Time', description: 'Select the time', default: '12:00', format: '12', clearable: true},
        {type: 'date-range', label: 'Date Range', description: 'Select a date range', default: ['01/01/2022', '01/02/2022'], format: 'MM/DD/YYYY', returnString: true, clearable: true},
        {type: 'number', label: 'Age', description: 'Enter your age', placeholder: 'Enter your age', required: true, min: 18, max: 100, default: 18, precision: 0, step: 1},
        {type: 'input', label: 'Email', description: 'Enter your email address', placeholder: 'Enter your email address', required: true},
      
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
