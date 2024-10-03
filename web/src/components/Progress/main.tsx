import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Flex, Text, Transition, useMantineTheme } from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { useSettings } from "../../providers/settings/settings";
import colorWithAlpha from "../../utils/colorWithAlpha";
import { getPositionProps, getTranslate, PositionProps } from "../../utils/positioning";
import { fetchNui } from "../../utils/fetchNui";

type ProgressProps = {
  position: PositionProps 
  icon?: string
  label: string
  description?: string
  duration: number
}

export default function Progress() {
  const settings = useSettings()
  const theme = useMantineTheme()
  const [display, setDisplay] = useState(false)
  const [progress, setProgress] = useState(0)
  const [options, setOptions] = useState<ProgressProps>({
    position: 'bottom-center',
    icon: 'fa fa-bars',
    description: 'This is a progress bar',
    label: 'Progress',
    duration: 8000
  })

  // timer for the progress bar
  useEffect(() => {
    if (!display) return

    const interval = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          clearInterval(interval)
          setDisplay(false)
          fetchNui('PROGRESS_COMPLETE')
          return 0
        }
        return prev + 1
      })
    }, options.duration / 100)
    return () => clearInterval(interval)
  }, [display])

  useNuiEvent('SHOW_PROGRESS', (data: ProgressProps) => {
    setOptions(data)
    setDisplay(true)
  })

  useNuiEvent('CANCEL_PROGRESS', () => {
    setOptions((prev) => ({ ...prev, label:settings.locales.CancelProgress, duration: 0 }))
    setTimeout(() => {
      setDisplay(false)
    }, 500)

  })

  return (
    <Transition
      mounted={display}
      transition="fade"
      duration={400}
      timingFunction="ease"
     
    >
      {(styles) => (
        <Flex
          m='xs'
          p='xs'
          pos='absolute'
          {...getPositionProps(options.position)}
          bg='rgba(0,0,0,0.5)'
          style={{
            borderRadius: theme.radius.sm,
            transform: getTranslate(options.position),
            ...styles
          }}
          direction={'column'}
          gap='xs'
        >
          <Flex
            direction='column'
          >
            <Flex
              gap='xs'
              align='center'
              mb='xs'
            >
              {options.icon && (
                <FontAwesomeIcon
                  color='rgba(255,255,255,0.8)'
                  icon={options.icon as IconProp} 
                  style={{
                    fontSize: '1.8vh'
                  }}
                />  
              )}
              <Text
                size='1.8vh'
                style={{
                  fontFamily: 'Akrobat Bold'
                }}
              >{options.label}</Text>
            </Flex>
            {options.description && (
              <Text
                size='1.4vh'
                c='rgba(255,255,255,0.8)'
              >
                {options.description}
              </Text>
            )}

          </Flex>

          <CustomProgress
            value={progress}
          />
        </Flex>
      
      )}
    </Transition>
  )
}

type CustomProgressProps = {
  value: number // Progress value in percentage
}

function CustomProgress({ value }: CustomProgressProps) {
  const theme = useMantineTheme()

  // Number of boxes in the progress bar
  const boxCount = 8
  const filledBoxes = Math.floor((value / 100) * boxCount) // Fully filled boxes
  const partialFill = ((value / 100) * boxCount) - filledBoxes // The remaining fraction of the current box

  return (
    <Flex
      w='28vh'
      gap='0.5vh'
      style={{
        borderRadius: theme.radius.sm,
        overflow: 'hidden',
        
      }}
    >
      {Array.from({ length: boxCount }).map((_, index) => {
        // Determine if the current box should be fully filled, partially filled, or empty
        let fillPercentage = 0
        if (index < filledBoxes) {
          fillPercentage = 100 // Fully filled box
        } else if (index === filledBoxes) {
          fillPercentage = partialFill * 100 // Partially filled box
        }

        return (
          <Flex
            key={index}
            w={`${100 / boxCount}%`} // Divide width equally among boxes

            h='2vh'
            style={{
              position: 'relative',
              backgroundColor: 'rgba(0, 0, 0, 0.2)', // Default empty box color
              transition: 'background-color 0.3s ease', // Smooth transition for filling
              borderRadius: theme.radius.xs,
            }}
          >
            {/* Inner fill box that represents the progress */}
            <div
              style={{
                width: `${fillPercentage}%`,
                height: '100%',
                // backgroundColor: theme.colors[theme.primaryColor][theme.primaryShade as number],
                backgroundColor: 'rgba(0, 0, 0, 0.5)', // Fill color
                boxShadow: fillPercentage > 0 
                  ? `inset 0 0 2.5vh ${colorWithAlpha(theme.colors[theme.primaryColor][theme.primaryShade as number], 0.9)}`
                  : 'none',
                transition: 'width 0.1s ease', // Smooth transition for the width change
              }}
            />
          </Flex>
        )
      })}
    </Flex>
  )
}

