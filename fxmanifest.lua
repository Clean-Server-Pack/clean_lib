fx_version 'cerulean'
lua54 'yes'
games { 'rdr3', 'gta5' }

name         'dirk_lib'
author       'DirkScripts'
version      '1.0.0'
description  'A library for FiveM developers to use in their projects, accepting of new features and contributions.'

dependencies {
    '/server:7290',
    '/onesync',
}

files {
  'init.lua',
  'src/settings.lua',
  'modules/**/client.lua',
  'modules/**/server.lua',
  'modules/**/shared.lua',


  --\\ NUI WHEN ADDED \\--
}

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
