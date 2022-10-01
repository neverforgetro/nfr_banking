fx_version "adamant"
game "gta5"
dependency "vrp"
author "CheluAkaGrasu#0001"
description "NFR_Banking"
shared_script 'config.lua'

client_scripts {
    "@vrp/client/Proxy.lua",
    "@vrp/client/Tunnel.lua",
    "client/*.lua"
}

server_scripts{
    "@vrp/lib/utils.lua",
    'server/*.lua'
}
ui_page {
    "html/index.html"
}

files {
    "html/*.*"
}