import { IconProp } from "@fortawesome/fontawesome-svg-core";
import {
  Flex
} from "@mantine/core";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { fetchNui } from "../../utils/fetchNui";
import { internalEvent } from "../../utils/internalEvent";
import Background from "./Background";
import "./dialog.css";
import Header from "./Header";
import { MetadataProps } from "./Metadata";
import ResponsesContainer, { ResponseProps } from "./Responses";

export type IDialogProps = {
  cantClose?: boolean,
  id: string,
  title: string,
  icon: IconProp,
  audioFile?: string,
  prevDialog?: string,
  metadata: MetadataProps[],
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
        fetchNui("dialogSelected", {actionid: "close"})
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

  const { title, icon, audioFile, metadata, dialog, responses }:IDialogProps = data;

  // useEffect(() => {
  //   const audio = new Audio(audioFile);
  //   audio.play();

  //   return () => {
  //     audio.pause();
  //     audio.currentTime = 0;
  //   };
  // }, [audioFile]);

  while (responses.length % 4 !== 0) responses.push({ label: " ", actionid: "empty" });


  return (
    <Background
      display={openMenu}
    >
      <Flex
        direction='column'
        w='50%'
      >
        <Header title={title} dialog={dialog} icon={icon} prevDialog={data.prevDialog} />
        <ResponsesContainer responses={responses} />
      </Flex>
    </Background>
  );
}

internalEvent([
  {
    action: "DIALOG_STATE",
    data: {
      dialog       : "Is there anything I can do to postpone this?",
      id           : "my_dialogue",
      title        : "Officer",
      icon         : "fa-user-tie",
      audioFile    : "audio.mp3",

      metadata    : [
        {
          icon : "fa-user-tie",
          label : "Officer",
          data  : "Grade 4",
          type  : 'text',
          progress : 75,
        },
        {
          icon : "fa-user-tie",
          label : "Officer",
          data  : "Grade 4",
          type  : 'text',
          progress : 75,
        },
        {
          icon : "fa-user-tie",
          label : "Officer",
          data  : "Grade 4",
          type  : 'text',
        },
      ],


      responses : [
        {
          label     : "Yes",
          icon      : "fa-user-tie",
          description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book.",  
          dontClose : true,
          actionid : "111",
          colorScheme: "#ff0000"
        },
        {
          label     : "No",
          icon      : "fa-user-tie",
          dontClose : true,
          actionid : "222"
        },
        {
          label     : "Maybe So",
          icon      : "fa-user-tie",
          dontClose : true,
          actionid : "333"
        },
        {
          label     : "Yesd",
          icon      : "fa-user-tie",
          description : "This is a description",
          dontClose : true,
          actionid : "444"
        },
        {
          label     : "No",
          icon      : "fa-user-tie",
          dontClose : true,
          actionid : "555"
        },
        {
          label     : "Maybe So",
          icon      : "fa-user-tie",
          dontClose : true,
          actionid : "666"
        },
      ]
    }
  },
]);