fx_version "adamant"
game "gta5"
dependency "vrp"
author "NFR#1824 gush3l#6016"
description "NFR_Banking - A banking system inspired by a Behance project. Made for vRP."
shared_script "config.lua"

client_scripts {
    "client/*.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server/*.lua"
}
ui_page {
    "html/index.html"
}

files {
    "html/*.*"
}