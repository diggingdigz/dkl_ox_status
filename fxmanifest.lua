fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
}
server_scripts {
    '@ox_core/imports/server.lua',
}
client_scripts {
    '@ox_core/imports/client.lua',
    'ontick.lua',
    'drunk.lua',
    'stress.lua'
}
