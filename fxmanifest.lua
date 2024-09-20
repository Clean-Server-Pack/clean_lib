fx_version 'cerulean'
lua54 'yes'
games { 'rdr3', 'gta5' }
use_experimental_fxv2_oal 'yes'
name         'clean_lib'
author       'DirkScripts'
version      '1.0.17'
description  'A library for FiveM developers to use in their projects, accepting of new features and contributions.'

dependencies {
    '/server:7290',
    '/onesync',
}

ui_page 'web/build/index.html'

files {
  'init.lua',
  'modules/**/client.lua',
  'modules/**/server.lua',
  'modules/**/shared.lua',
  'bridge/**/client.lua',
  'bridge/**/server.lua',
  'bridge/**/shared.lua',
  'src/modelNames.lua',
  'src/settings.lua',
  'src/compat.lua',

  --\\ NUI WHEN ADDED \\--
  'web/build/index.html',
  'web/build/**/*',
}


shared_script 'src/settings.lua'
shared_script 'src/init.lua'

shared_scripts {
  'src/**/shared.lua',
  
}

client_scripts {
  'src/**/client.lua',
  'src/**/client/*.lua'
}

server_scripts {
  'modules/callback/server.lua',
  'src/**/server.lua',
  'src/**/server/*.lua',
}

