
# CLEAN LIB
A useful library for script developement, includes all the standards set by ox_lib and improves on them with support for multiple types of target, inventory, framework, vehicle keys and more. 

[📖Documentation](https://docs.dirkscripts.com/resources/clean-lib)
[🦜Discord](discord.gg/dirkscripts)
# Credits 
Thank you for a few of the modules and the loading method. big brayn ox
  - [ox_lib](https://github.com/overextended/ox_lib)
# Convars
```properties

# The theme below will apply to all UI created by DirkScripts utilising the lib themes. 
# Theme starts at 0 and goes to 9 
# 0 is the lightest color and 9 is the darkest
# You can set the primary color to custom and set the customTheme to your own colors
# Use this generator in order to make your own custom color palettes https://mantine.dev/colors-generator/?color=7b36b5 
# Default mantine colors can be found here https://mantine.dev/theming/colors/#default-colors
setr clean_lib:primaryColor clean # Set to custom to use customTheme
setr clean_lib:primaryShade 9 # 0-9
setr clean_lib:customTheme [
  "#e5f8ff",
  "#d0ecff",
  "#a0d7fc",
  "#6dc1fa",
  "#47aef9",
  "#32a2f9",
  "#259cfa",
  "#1888df",
  "#0179c8",
  "#0068b1"
]


setr clean_lib:language en
setr clean_lib:debug true
setr clean_lib:currency $
setr clean_lib:serverName CleanRP
setr clean_lib:logo https://via.placeholder.com/150

# Configure the resources you want to use
setr clean_lib:framework qbx_core
setr clean_lib:inventory clean_inventory
setr clean_lib:itemImgPath nui://clean_inventory/web/images/
setr clean_lib:primaryIdentifier license
setr clean_lib:target ox_target
setr clean_lib:interact sleepless_interact
setr clean_lib:time clean_weather
setr clean_lib:phone lb-phone

setr clean_lib:keys clean_keys
setr clean_lib:garage clean_vehicles
setr clean_lib:fuel clean_fuel


setr clean_lib:ambulance clean_ambulance
setr clean_lib:prison clean_prison
setr clean_lib:dispatch clean_dispatch


# NOTIFICATIONS
setr clean_lib:notify clean_lib
setr clean_lib:notifyPosition top-right
setr clean_lib:notifyAudio true

# Context Menu 
setr clean_lib:contextMenu clean_lib
setr clean_lib:contextClickSounds true
setr clean_lib:contextHoverSounds true

# Dialog
setr clean_lib:dialog clean_lib
setr clean_lib:dialogClickSounds true
setr clean_lib:dialogHoverSounds true

# showTextUI 
setr clean_lib:showTextUI clean_lib
setr clean_lib:showTextPosition bottom-center

# progressBar 
setr clean_lib:progress clean_lib
setr clean_lib:progBarPosition bottom-center

# Groups 
setr clean_groups:maxMembers 5
setr clean_groups:maxDistanceInvite 5
setr clean_groups:inviteValidTime 5
setr clean_groups:maxLogOffTime 5


```









setr clean_lib:showTextPosition bottom-center

