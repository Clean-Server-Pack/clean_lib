import { IconProp } from "@fortawesome/fontawesome-svg-core";
import { Flex, SimpleGrid, useMantineTheme } from "@mantine/core";
import { useEffect, useState } from 'react';

import { Response } from "./Response";
import Button from "../Generic/Button";


export type ResponseProps = {
  label: string,
  icon?: IconProp,
  description?: string,
  dontClose?: boolean,
  actionid?: string,
  colorScheme?: string
  
}

type ResponsesContainerProps = {
  responses: ResponseProps[]
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
      
      gap={theme.spacing.xs}
    >
      <Button
        mt="auto"
        mb='auto'
        icon='fas fa-chevron-left' 

        disabled={currentPage === 1}

        onClick={() => {
          if (currentPage === 1) return;
          setCurrentPage(currentPage - 1);
        }} 
      />
      <SimpleGrid
        cols={2}
        flex={1}
      >
        {currentResponses.map((response, index) => {
          return (
            <Response key={index} {...response} />
          )
        })}
      </SimpleGrid>

      <Button
        mt="auto"
        mb='auto'
        icon='fas fa-chevron-right' 
        disabled={currentPage === pages}
        onClick={() => {
          if (currentPage === pages) return;
          setCurrentPage(currentPage + 1);
        }}  
      />
    </Flex>
  )
}

export default ResponsesContainer;