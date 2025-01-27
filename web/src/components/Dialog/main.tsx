import { IconProp } from "@fortawesome/fontawesome-svg-core";
import {
  Flex
} from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { fetchNui } from "../../utils/fetchNui";
import Background from "./Background";
import Header from "./Header";
import { MetadataProps } from "./Metadata";
import ResponsesContainer, { ResponseProps } from "./Responses";

export type IDialogProps = {
  cantClose?: boolean,
  clickSounds?: boolean,
  hoverSounds?: boolean,
  id: string,
  title: string,
  icon: IconProp,

  audioFile?: string,
  prevDialog?: string,
  metadata?: MetadataProps[],
  dialog: string,
  responses: ResponseProps[]
}

export default function Dialog(){

  const [openMenu, setOpenMenu] = useState(false);
  const [data, setData] = useState<IDialogProps >(
    {
      id: "",
      title: "",
      icon: "user-tie",
      audioFile: "",
      metadata: [],
      dialog: "",
      responses: []
    }
  );
  

  // listen for escape key
  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === "Escape" && openMenu && !data.cantClose) {
        setOpenMenu(false);
        fetchNui("DIALOG_SELECTED", {index: "close"})
      }
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  });
  

  useNuiEvent("DIALOG_STATE", (data: IDialogProps) => {
    setOpenMenu(data ? true : false);
    if (data) {
      setData(data);
    }
  });

  const { title, icon, dialog, responses, hoverSounds, clickSounds }:IDialogProps = data;

  useEffect(() => {
   if (responses.length % 4 !== 0) {
      const emptyResponses = 4 - (responses.length % 4);
      for (let i = 0; i < emptyResponses; i++) {
        responses.push({ label: " ", empty: true, index: -1, hoverSounds: false, clickSounds: false });
      }
    }

  }, [responses]);


  return (
    <Background
      display={openMenu}
    >
      <Flex
        direction='column'
        w='50%'
        h='100%'
      >
        <Header title={title} dialog={dialog} icon={icon} prevDialog={data.prevDialog} metadata={data.metadata} />
        <ResponsesContainer responses={responses} hoverSounds={hoverSounds} clickSounds={clickSounds} />
      </Flex>
    </Background>
  );
}

