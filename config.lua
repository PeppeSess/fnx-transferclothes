
c = {
    useMarkers = true,
    useCommand = true,

    markers = { -- Work if useMarkers = true
        type = 27,
        dir = {0,0,0},
        rot = {0,0,0},
        scale = {0.7, 0.7, 0.7},
        color = {255, 255, 255, 255},
        upAndDown = false,
        rotate = false,
        extraTexture = {nil, nil}
    },

    command = "openClothesTransferMenu",


    locations = { -- Work if useMarkers = true
        vec3(429.6643371582,-811.60498046875,29.491115570068-0.97)
    },


    blips = {
        active = true,
        sprite = 12,
        color = 11,
        scale = 0.7,
        name = "Clothes Trader"
    },

    customize = {
        getFramework = function()
            ESX = exports.es_extended:getSharedObject()
        end,

        openMenu = function(infoClothes)
            local menu = {}
            for i, v in pairs(infoClothes) do
                table.insert(menu, {label="Dress: "..v.label, skin=v})
            end    
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
                title = 'FnX Transfer Clothes',
                align = 'top-left',
                elements = menu
            }, function(data, menu)
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu', {
                    title = "ID To Trade:",
                }, function(data2, menu2)
                    TriggerServerEvent('FnX_TransferClothes:addClothes', tonumber(data2.value), data.current.skin)
                    menu2.close()
                    menu.close()
                end, function(data2, menu2)
                    menu2.close()
                end)
            end, function(data, menu)
                menu.close()
            end)
        end,

        notify_c = function(text)
           TriggerEvent("esx:showNotification",text)
        end,

        notify_s = function(source, text)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = text, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        end,

        getClothes = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local clothes = exports.oxmysql:executeSync("SELECT data FROM datastore_data WHERE owner=?",{xPlayer.identifier})
            return(json.decode(clothes[1].data).dressing)
        end,

        addClothes = function(bySource, source, clothesTable)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer then
                local clothes = exports.oxmysql:executeSync("SELECT data FROM datastore_data WHERE owner=?",{xPlayer.identifier})
                clothes = json.decode(clothes[1].data)
                local dressing = clothes.dressing
                clothesTable.label = clothesTable.label.." (Gived)"
                table.insert(dressing, clothesTable)
                clothes.dressing = dressing
                exports.oxmysql:executeSync("UPDATE datastore_data SET data=? WHERE owner=?",{json.encode(clothes),xPlayer.identifier})
                c.customize.notify_s(bySource, c.lang["completeTrade_1"])
                c.customize.notify_s(source, (c.lang["completeTrade_2"]):format(GetPlayerName(bySource)))
            else
                c.customize.notify_s(bySource, c.lang["noPlayer"])
            end
        end
    },

    lang = {
        ["notify"] = "Press ~INPUNT_CONTEXT~ to open the menu",
        ["noPlayer"] = "This player is offline",
        ["completeTrade_1"] = "Trade completed",
        ["completeTrade_2"] = "You recive a new clothes by %s",
    }
}
c.customize.getFramework()