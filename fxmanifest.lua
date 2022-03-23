-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'Jestar'
description 'Car Extra Menu made with MenuV'
version '1.0.0'

-- What to run
client_scripts {
  '@menuv/menuv.lua',
  'client.lua',
}

server_scripts {
  'server.lua'
}

dependencies {
  'menuv'
}