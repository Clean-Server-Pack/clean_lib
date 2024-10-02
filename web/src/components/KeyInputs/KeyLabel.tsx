import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useMantineTheme, Flex, Text } from "@mantine/core";
import { useState, useEffect } from "react";
import colorWithAlpha from "../../utils/colorWithAlpha";
import { fetchNui } from "../../utils/fetchNui";
import { KeyInputProps } from "./main";

export function KeyLabel(props: KeyInputProps) {
  const theme = useMantineTheme();
  const [progress, setProgress] = useState(0);


  // while the key is pressed, increase the progress bar until 100% (time is props.delay (seconds))
  useEffect(() => {

    if (props.pressed && !props.delay) {
      setProgress(100)
      return  
    }

    if (props.pressed && props.delay) {
      const interval = setInterval(() => {
        setProgress((prev) => {
          if (prev >= 100) {
            clearInterval(interval)
            fetchNui('KEY_INPUT', {
              qwerty: props.qwerty,
            })
            return 0
          }
          return prev + 1
        })
      }, props.delay ? props.delay / 100 : 10)
      return () => clearInterval(interval)
    } else {
      setProgress(0)
    }
  }, [props.pressed]) 

  return (
    <Flex
      align="center"
      gap="xs"
      pos="relative" // Enable absolute positioning for the progress bar
      p="xs"
 
      style={{
        borderRadius: theme.radius.xs,
        overflow: "hidden", // Prevent overflow for the progress bar
        backgroundColor: "rgba(0,0,0,0.5)", // Background for the container
        
      
      }}
    >
      {/* Progress Bar */}
      <div
        style={{
          position: "absolute",
          top: 0,
          left: 0,
          height: "100%",
          width: !props.delay ? '100%' : `${progress}%`, // Set the width to the progress
          background: !props.delay ? props.pressed ? 
            colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.05) : 'transparent' : 
            'transparent',
            boxShadow: props.pressed ? `inset 0 0 2.9vh ${colorWithAlpha(
              theme.colors[theme.primaryColor][theme.primaryShade as number],
              0.9
            )}` : 'none',

          zIndex: 0, // Behind the text and icon
          transition: !props.delay ? 'all ease-in-out 0.2s' : 'none',
          
        }}
      />
      {/* Icon and Label */}
      <FontAwesomeIcon
        icon={props.icon as IconProp}
        style={{ zIndex: 1 }} // Ensure the icon is above the progress bar
      />
      <Text size="1.8vh" style={{ zIndex: 1 }}> {/* Ensure text is above the progress bar */}
        {props.label}
      </Text>
    </Flex>
  );
}
