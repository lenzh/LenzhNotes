local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

RegisterNetEvent('LenzhNotes:client:CreateNote', function()
    ExecuteCommand("e notepad") -- Triggers notepad event
    local dialog = nil
    dialog = exports.ox_lib:inputDialog("Make a note", {
        {type = "textarea", label = "", placeholder = "Enter your message", required = true, autosize = true},
        -- {type = 'date', label = 'Date input', icon = {'far', 'calendar'}, default = true, format = "DD/MM/YYYY"},
        {type = 'checkbox', label = 'Anon message'},
    })
    if not dialog then return end

    TriggerServerEvent("LenzhNotes:server:CreateNote", dialog)
    exports.scully_emotemenu:cancelEmote()
end)

