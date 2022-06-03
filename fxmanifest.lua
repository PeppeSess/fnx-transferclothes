fx_version 'cerulean'
game 'gta5'

author '𝗠att𝟯#0702'


client_script 'client.lua'

server_script 'server.lua'

shared_script 'config.lua'

dependencies {
    'cb_belli', -- https://github.com/Matt3-RaR/cb_belli
    'oxmysql', -- https://github.com/overextended/oxmysql
}

lua54 'yes'
escrow_ignore {
    'config.lua'
}