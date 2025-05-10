local PlaceIds = {
    ["Backrooms Drift"] = {id = 138365924124161, url = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/BackroomDrift.lua"}
}

local found = false

for _, data in pairs(PlaceIds) do
    if data.id == game.PlaceId then
        found = true
        loadstring(game:HttpGet(data.url))()
        break
    end
end
    
if not found then
    for _, data in pairs(PlaceIds) do
        if data.id == 0 then
            found = true
            loadstring(game:HttpGet(data.url))()
            break
        end
    end
end