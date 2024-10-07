// import { Flex, Title, alpha } from "@mantine/core";
// import { useState, useEffect } from "react";
// import { CustomProgress } from "./CustomProgress";

// export type StatusProps = {
//   id: string;
//   title: string;
//   time?: number;
//   content: string[];
// };
// export function Status({ status }: { status: StatusProps; }) {
//   const [timeLeft, setTimeLeft] = useState<number | null>(status?.time ?? null); // Added null check for status
//   const [opened, setOpened] = useState<boolean>(true);

//   useEffect(() => {
//     if (timeLeft === null) return;

//     const interval = setInterval(() => {
//       setTimeLeft((prev) => {
//         if (prev === null) return null;
//         if (prev <= 0) {
//           clearInterval(interval);
//           // setOpened(false)
//           return 0;
//         }
//         return prev - 1;
//       });
//     }, 1000);

//     return () => clearInterval(interval);
//   }, [timeLeft]);

//   const formatTime = (time: number) => {
//     const minutes = Math.floor(time / 60);
//     const seconds = time % 60;
//     return `${minutes}:${seconds < 10 ? `0${seconds}` : seconds}`;
//   };

//   const getBarValue = (time: number) => {
//     return (time / (status.time || 0)) * 100;
//   };

//   return opened && (
//     <Flex direction={'column'} pb='xs' align={'center'} style={{ overflow: 'hidden', borderRadius: 'var(--mantine-radius-sm)' }} gap='xs'>


//       <Flex direction='column' w='90%' align={'center'} p='xs'
//         style={{
//           borderRadius: 'var(--mantine-radius-sm)',
//         }}
//       >
//         <Title fw='900' p='0.25rem' c={'white'} order={4}
//           style={{
//             textShadow: '0 0 0.2rem var(--mantine-color-dark-9)',
//           }}
//         >{status.title}</Title>
//         {timeLeft !== null && (
//           <CustomProgress value={getBarValue(timeLeft)} timeLeft={formatTime(timeLeft)} />
//         )}
//       </Flex>



//       <Flex direction='column' gap='0.25rem' w='14vw' p='xs' bg={alpha('dark.9', 0.5)} style={{ borderRadius: 'var(--mantine-radius-sm)' }}>
//         {/* {status.content.map((content, index) => (
//           // <StatusContent key={index} content={content} />
//         ))} */}
//       </Flex>

//     </Flex>

//   );
// }
