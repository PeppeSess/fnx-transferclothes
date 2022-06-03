if c.useMarkers then
    CreateThread(function()
        local wait=true
        while true do
            wait=true
            for i, coords in pairs(c.locations) do
                local distanza = Vdist(GetEntityCoords(PlayerPedId()), coords)
                if distanza < 4 then
                    wait=false
                    DrawMarker(c.markers.type, coords.x, coords.y, coords.z, c.markers.dir[1], c.markers.dir[2], c.markers.dir[2], c.markers.rot[1], c.markers.rot[2], c.markers.rot[3], c.markers.scale[1], c.markers.scale[2], c.markers.scale[3], c.markers.color[1], c.markers.color[2], c.markers.color[3], c.markers.color[4], c.markers.upAndDown, false, 0, false, c.markers.extraTexture[1], c.markers.extraTexture[2], false)    
                end
                if distanza < 2 then
                    AddTextEntry('esxHelpNotification', c.lang["notify"])
                    DisplayHelpTextThisFrame('esxHelpNotification', false)

                    if IsControlJustPressed(1, 38) then
                        local vestiti = exports.cb_belli:TriggerServerCallback("FnX_TransferClothes:getClothes")
                        c.customize.openMenu(vestiti)
                    end
                end
            end
            if wait then
                Wait(150)
            end
            Wait(1)
        end
    end)
end

if c.useCommand then
    RegisterCommand(c.command, function()
        local vestiti = exports.cb_belli:TriggerServerCallback("FnX_TransferClothes:getClothes")
        c.customize.openMenu(vestiti)
    end)
end