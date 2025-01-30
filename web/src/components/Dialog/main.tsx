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
      id: "main",
      title: "Main Menu",
      icon: "user-tie",
      audioFile: "",
      prevDialog: "sdsd",
      metadata: [],
      dialog: "Welcome to the main menu",
      responses: [
        {
          index     : 0,
          label     : "Yes",
          icon      : "fa-user-tie",
          // description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book.",  
          dontClose : true,
          disabled:true, 
        },
        {
          index     : 1,
          label     : "No",
          icon      : "fa-user-tie",
          // description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book.",  
          dontClose : true,
          disabled:true,
        },
        {
          index     : 2,
          label     : "Maybe",
          icon      : "fa-user-tie",
          description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book.",  
          dontClose : true,
          disabled:true,
        }
      ]
    }
  );
  

  // listen for escape key
  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      console.log('CLOSING CAN CLOSE ', (event.key === "Escape" && openMenu && !data.cantClose))
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
      setData({
        ...data,
        responses: [
          ...responses,
          ...Array(emptyResponses).fill({
            label: "",
            empty: true,
            index: -1
          })
        ]
      }); 
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

