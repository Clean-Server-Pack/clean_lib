import { Flex, Text, useMantineTheme } from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { internalEvent } from "../../utils/internalEvent";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { IconProp } from "@fortawesome/fontawesome-svg-core";
import colorWithAlpha from "../../utils/colorWithAlpha";
import { fetchNui } from "../../utils/fetchNui";
import { useLocale } from "../../providers/locales/locales";

type Status = {
  id: string; 
  title: string;
  icon?: string;
  description: string;
  time?: number;
  progress?: number;
  progText?: string; 
}

export default function StatusInfo(){
  const [ statuses, setStatuses ] = useState<Status[]>([
    // {
    //   id: '1',
    //   title: 'Sanitation Job',
    //   description: 'Please collect all the trash from the streets marked on your map before the time runs out.',     
    //   icon: 'dumpster',
    //   progress: 50,
    //   time: 5,
    // },

  ]);

  useNuiEvent('ADD_STATUS', (status: Status) => {
    // remove status with the same id
    setStatuses((prev) => prev.filter((s) => s.id !== status.id));
    setStatuses((prev) => [...prev, status]);
  });

  useNuiEvent('REMOVE_STATUS', (id: string) => {
    setStatuses((prev) => prev.filter((status) => status.id !== id));
  });

  useNuiEvent('UPDATE_STATUS', (status: Status) => {
    setStatuses((prev) => prev.map((s) => s.id === status.id ? status : s));
  }); 


  return (

    <Flex 
      direction='column-reverse' 
      pos='absolute' 
      left='2%' 
      top='50%' 
      gap='0.4rem' 
      h='fit-content'
      mah='80vh'
      style={{
        transform: 'translate(2%, -50%)',
        overflow: 'hidden',
        userSelect: 'none',
      }}
    >
      {statuses.map((status) => (
        <Status key={status.id} {...status} />
      ))}
    </Flex>
  );
}

function Status(props: Status){
  const theme = useMantineTheme();
  const locale = useLocale();
  const [timeLeft, setTimeLeft] = useState(props.time || 0);
  const [timeString, setTimeString] = useState(props.time ? `${props.time > 60 ? `${Math.floor(props.time / 60)}m` : ''} ${props.time % 60}s`: '');

  useEffect(() => {
    const interval = setInterval(() => {
      setTimeLeft((prev) => {
        const newTime = prev - 1;

        // Update time string inside the same callback
        setTimeString(() => {
          if (newTime <= 0) return locale('status_time_over');
          return `${newTime > 60 ? `${Math.floor(newTime / 60)}m` : ''} ${newTime % 60}s`;
        });

        // Stop the timer if time reaches zero
        if (newTime <= 0) {
          clearInterval(interval);
          fetchNui('STATUS_TIMER_OVER', {
            id: props.id,
          })
          // Call Lua or perform additional cleanup
        }

        return Math.max(newTime, 0); // Ensure time doesn't go negative
      });
    }, 1000);

    return () => clearInterval(interval); // Cleanup on unmount
  }, [props.time, props.id, locale]);

  return (
    <Flex 
      gap='0.4rem' 
      align='center' 
      bg='rgba(0, 0, 0, 0.5)'
      w='15vw'
      p='xs'
      direction={'column'}
      style={{
        borderRadius: '0.5vh',
        boxShadow: '0 0 1vh rgba(0,0,0,0.5)',
      }}
    >
      <Flex
      justify={'center'}
        align={'center'}
        w='90%'
        gap='0.4rem'
        pb='0.2rem'
        style={{
          borderBottom: `0.15rem solid ${colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.9)}`,
        }}
      >
        {props.icon && (
          <FontAwesomeIcon
            icon={props.icon as IconProp}
            size='1x'
            color='rgba(255,255,255,0.6)'
          />
        )}
        <Text
          size='1.5rem'
          c='rgba(255,255,255,0.9)'
        >{props.title}</Text>
      </Flex>

      <Text
        size='0.9rem'
        c='rgba(255,255,255,1)'
        >{props.description}</Text>

      {props.progress && (
        <ProgressBar
          progress={props.progress}
          icon='tasks'
          text={props.progText || `${props.progress}%`}
        />    
      )}
      {props.time && (
        <ProgressBar
          progress={timeLeft ? (timeLeft / props.time) * 100 : 0}
          icon='clock'
          text={timeString}
        />
      )}

  
      
    </Flex>
  )
}


type ProgressBarProps = {
  progress: number;
  icon: string;
  text: string | number;
}

function ProgressBar(props: ProgressBarProps){
  const theme = useMantineTheme();
  return (
    <Flex
    w='100%'
    direction='column'
    >
    <Flex
      // ml='auto'
      p='0.4rem'
      gap='0.4rem'
      align='center'
    >
      <FontAwesomeIcon 
        icon={props.icon as IconProp}
        size='1x'
        color='rgba(255,255,255,0.6)'
      />
      <Text
        size='1rem'
        c='rgba(255,255,255,0.8)'
      >{props.text}</Text>
    </Flex>
    <Flex 
      mt='0.2rem'
      w='100%' 
      h='0.8rem' 
      bg='rgba(255,255,255,0.2)'
      style={{
        borderRadius: '0.25vh',
        boxShadow: 'inset 0 0 0.5vh rgba(0,0,0,0.2)',
      }}
    >
      <Flex 
        w={`${props.progress}%`} 
        bg={colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.8)}
        style={{
          borderRadius: '0.25vh',
          transition: 'all ease-in-out 0.5s',
        }}
      />
    </Flex>
  </Flex>
  )   
}

internalEvent([
  {
    action: 'ADD_STATUS',
    data: {
      id: '1',
      title: 'Sanitation Job',
      description: 'Please collect all the trash from the streets marked on your map before the time runs out.',     
      icon: 'dumpster',
      progress: 50,
      time: 5,
    }
  }
])