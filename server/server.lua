local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('LenzhNotes:server:CreateNote', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local info = {
        description = data[1],
        type = os.date("%c")
    }
    if data[2] == true then
        info.label = "Written Note"
    elseif data[2] == false then
        info.label = "Written Note by: " ..
        Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    end

    if exports.ox_inventory:CanCarryItem(src, 'note', 1, info) then
        exports.ox_inventory:AddItem(src, 'note', 1, info)
    else
        QBCore.Functions.Notify(src, 'Cannot carry item', 'error', 7500)
    end
end)


QBCore.Functions.CreateUseableItem("notepad", function(source, item)
    local src = source
    local dur = item.metadata.durability or 100

    item.metadata.durability = dur - 5
    if item.metadata.durability <= 0 then
        exports.ox_inventory:RemoveItem(src, 'notepad', 1)
        TriggerClientEvent("LenzhNotes:client:CreateNote", src)
    else
        exports.ox_inventory:SetMetadata(src, item.slot, item.metadata)
        TriggerClientEvent("LenzhNotes:client:CreateNote", src)
    end
end)
