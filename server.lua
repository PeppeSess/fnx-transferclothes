exports.cb_belli:RegisterServerCallback("FnX_TransferClothes:getClothes", function(src)
    return c.customize.getClothes(src)
end)

RegisterServerEvent("FnX_TransferClothes:addClothes", function(toSrc, skinTable)
    local src = source
    c.customize.addClothes(src, toSrc, skinTable)
end)