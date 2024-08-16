import {Flex} from '@mantine/core';
import React from 'react';

export default function SearchableContent({children, searchTerm}: {children: React.ReactNode, searchTerm: string}) {

  if (!searchTerm) {
    return (
      <Flex
        w='100%'
        h='100%'
        direction={'column'}
        align='center'
        gap='xs'
        style={{
          overflowX:'hidden',
          overflowY:'auto',
          maxHeight:'60vh',
        }}
      >
        {children}
      </Flex>
    )
  }


  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const filtered = React.Children.toArray(children).filter((child: any) => {

    //  CHECK AGAINST DESCRIPTION AND TITLE AND METADATA?
    if (child.props.title && child.props.title.toLowerCase().includes(searchTerm.toLowerCase())) {
      return true;
    }
    if (child.props.description && child.props.description.toLowerCase().includes(searchTerm.toLowerCase())) {
      return true;
    }
    if (child.props.metadata && JSON.stringify(child.props.metadata).toLowerCase().includes(searchTerm.toLowerCase())) {
      return true;
    }
    return false;
  });

  if (filtered.length === 0) {
    return (
      <Flex
        w='95%'
        h='100%'
        direction={'column'}
        align='center'
        style={{
          overflowX:'hidden',
          overflowY:'auto',
          maxHeight:'60vh',
        }}
      >
        <p>No results found</p>
      </Flex>
    )
  }

  return (
    <Flex
      w='100%'
      h='100%'
      direction={'column'}
      gap = '1rem'
      align='center'
      style={{
        overflowX:'hidden',
        overflowY:'auto',
        maxHeight:'60vh',

      }}
    
    >
      {filtered}
    </Flex>
  )
}