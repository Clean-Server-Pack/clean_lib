import { Flex, Text } from '@mantine/core';
import React from 'react';

export default function SearchableContent({ children, searchTerm }: { children: React.ReactNode, searchTerm: string }) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const filtered = React.Children.toArray(children).filter((child: any) => {
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

  return (
    <Flex
      w='100%'
      p='xs'
      flex={1}
      direction={'column'}
      align='center'
      gap='xs'
      style={{
        overflowX: 'hidden',
        overflowY: 'auto',
        maxHeight: '60vh',
      }}
    >
      {searchTerm ? (
        filtered.length > 0 ? (
          filtered
        ) : (
          <Text
            c='rgba(255,255,255,0.6)'
            size='xs'
          >No Results Found</Text>
        )
      ) : (
        children
      )}
    </Flex>
  );
}