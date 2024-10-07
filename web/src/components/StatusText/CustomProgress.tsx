// import { useMantineTheme, Flex, Text } from "@mantine/core";
// import { useState, useEffect } from "react";

// // Custom Progress component
// // eslint-disable-next-line @typescript-eslint/no-unused-vars
// export function CustomProgress({ value, timeLeft, ...props }: { value: number;[key: string]: any; timeLeft?: string; }) {
//   const [displayValue, setDisplayValue] = useState(value);
//   const theme = useMantineTheme();
//   useEffect(() => {
//     // Debounce the updates to the display value
//     const timer = setTimeout(() => {
//       setDisplayValue(value);
//     }, 1000); // Adjust the debounce duration as needed

//     return () => clearTimeout(timer);
//   }, [value]);

//   return (
//     <Flex direction='column' h='fit-content' w='90%' justify='center' align='center' style={{
//       borderRadius: 'var(--mantine-radius-xs)',
//     }}>
//       <Flex
//         w={`${displayValue > 0 && displayValue + '%' || 'fit-content'}`}
//         bg={`${theme.colors[theme.primaryColor][7]}`}
//         h='100%'
//         style={{
//           transition: 'width ease 0.5s',
//           borderRadius: 'var(--mantine-radius-xs)',
//           overflow: 'hidden',
//           boxShadow: `0 0rem 1rem ${theme.colors[theme.primaryColor][7]}`,
//         }}
//         direction='column'
//         align='center'
//         p='0.02rem'
//         justify='center'
//       >
//         <Text
//          m='auto' fw='bold' size='0.7rem' ta='center' c='lightgrey' style={{ color: 'var(--mantine-color-dark-1)', textShadow: '0 0 0.1rem var(--mantine-color-dark-9)' }}>{displayValue > 0 && timeLeft || 'Finished'}</Text>

//       </Flex>
//     </Flex>
//   );
// }
