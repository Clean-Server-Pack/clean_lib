import { useClipboard } from '@mantine/hooks';
import { useNuiEvent } from '../../hooks/useNuiEvent';

export default function Clipboard(){
  const clipboard = useClipboard({ timeout: 250})

  useNuiEvent('COPY_TO_CLIPBOARD', (data: string) => {
    clipboard.copy(data)
  })

  return <></>
}