import { Flex, SimpleGrid, useMantineTheme } from "@mantine/core";
import { useEffect, useState } from 'react';

import Button from "../Generic/Button";
import { Response } from "./Response";


export type ResponseProps = {
  label: string,
  icon?: string,
  description?: string,
  disabled?: boolean,
  empty?: boolean;
  dontClose?: boolean,
  index: number,
  hoverSounds?: boolean,
  clickSounds?: boolean,
}

type ResponsesContainerProps = {
  responses: ResponseProps[]
  hoverSounds?: boolean
  clickSounds?: boolean
}


function ResponsesContainer(props : ResponsesContainerProps) {
  const theme = useMantineTheme();
  const pages = Math.ceil(props.responses.length / 4);
  const [currentPage, setCurrentPage] = useState(1);
  const currentResponses = props.responses.slice((currentPage - 1) * 4, currentPage * 4);

  useEffect(() => {
    setCurrentPage(1);
  }, [props.responses])

  return (
    <Flex
      mt='auto'
      mb='auto'
      // h='100%'
      gap={'xs'}
    >
      <Button
        mt="auto"
        mb='auto'
        icon='fas fa-chevron-left' 

        disabled={currentPage === 1}

        style={{
          visibility: currentPage === 1 ? 'hidden' : 'visible'
        }}

        onClick={() => {
          if (currentPage === 1) return;
          setCurrentPage(currentPage - 1);
        }} 
      />
      <SimpleGrid
        cols={2}
        flex={1}
        verticalSpacing={theme.spacing.xs}
        spacing={theme.spacing.xs}
        mih='100%'
        p='xs'
      >
        {currentResponses.map((response, index) => {
          return (
            <Response key={index} {...response} hoverSounds={props.hoverSounds} clickSounds={props.clickSounds} 
              index={index + 1}
            />
          )
        })}
      </SimpleGrid>

      <Button
        mt="auto"
        mb='auto'
        icon='fas fa-chevron-right' 
        disabled={currentPage === pages}

        style={{
          visibility: currentPage === pages ? 'hidden' : 'visible'
        }}

        onClick={() => {
          if (currentPage === pages) return;
          setCurrentPage(currentPage + 1);
        }}  
      />
    </Flex>
  )
}

export default ResponsesContainer;