import React, { useState, useEffect } from 'react';
import { Flex, Text } from '@mantine/core';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { IconName } from '@fortawesome/fontawesome-svg-core';

function InfoBox(props: { title: string, icon: string, time?: number, text?: string | number }) {
  const [time, setTime] = useState('00:00');

  // useEffect(() => {
  //   if (props.time) {
  //     // Convert minutes to seconds
  //     let totalSeconds = props.time * 60;
      
  //     const countdown = setInterval(() => {
  //       const minutes = Math.floor(totalSeconds / 60);
  //       const seconds = totalSeconds % 60;

  //       setTime(`${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`);

  //       if (totalSeconds <= 0) {
  //         clearInterval(countdown);
  //       } else {
  //         totalSeconds -= 1;
  //       }
  //     }, 1000);

  //     // Dirkup interval on component unmount
  //     return () => clearInterval(countdown);
  //   }
  // }, [props.time]);

  return (
    <Flex
      flex={0.33}
      direction='column'
      align='center'
      style={{
        borderBottom: '1px solid var(--mantine-primary-color-9)',
        padding: '0 0.5rem'
      }}
    >
      <FontAwesomeIcon icon={['fas', props.icon as IconName]} style={{ color: 'white' }} size='lg' />
      <Text size='xs' style={{ color: 'white' }}>{props.title}</Text>
      {props.time && 
        <Text size='xs' style={{ color: 'white' }}>
          {time}
        </Text>
      }
      {props.text &&
        <Text size='xs' style={{ color: 'white' }}>
          {props.text}
        </Text>
      }
    </Flex>
  );
}

export default InfoBox;