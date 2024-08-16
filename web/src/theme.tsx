import { createTheme, alpha } from "@mantine/core";

const theme = createTheme({
  primaryColor: "clean",
  primaryShade: 7,
  defaultRadius: "sm",
  fontFamily: "Akshar, sans-serif",
  colors: {
    dark:[
      "#ffffff",
      "#e2e2e2",
      "#c6c6c6",
      "#aaaaaa",
      "#8d8d8d",
      "#717171",
      "#555555",
      "#393939",
      "#1c1c1c",
      "#000000",
    ],
    clean:[
      "#ffffff",
      "#f3fce9",
      "#dbf5bd",
      "#c3ee91",
      "#ace765",
      "#94e039",
      "#7ac61f",
      "#5f9a18",
      "#29420a",
      "#446e11",
    ],
  },
  components: {
    Fieldset:{
      styles:{
        legend : { textAlign:'left', transition:'all 0.3s ease-in-out', fontSize:'1.5rem'},
        root:{
          border:'2px solid var(--mantine-color-dark-7)',
          background:alpha('var(--mantine-color-dark-9)', 0.4),
        } 
      }
    },

    TextInput:{
      styles:{
        input:{
          border:'2px solid var(--mantine-color-dark-7)',
          background:alpha('var(--mantine-color-dark-9)', 0.4),
        },
        
      },
    },



    

    DatePickerInput:{
      defaultProps:{
        

      },
      styles:{
        
        root:{bg:'red'},
        body:{bg:'blue'},
        day:{bg:'green'},
        month:{bg:'green'},
        calendarHeader:{

          background:alpha('var(--mantine-color-dark-9)', 0.8),
        },
        input:{
          border:'2px solid var(--mantine-color-dark-7)',
          background:alpha('var(--mantine-color-dark-9)', 0.4),
          cursor:'pointer',
        },
        
        
      },
    }
  },
});


export default theme;