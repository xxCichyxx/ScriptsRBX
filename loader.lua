local PlaceIds = {
    ["Backrooms Drift"] = {id = 138365924124161, url = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/BackroomDrift.lua"},
    ["Troll is a pinning tower 2"] = {id = 83312952548612, url = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/xxxx.txt"}
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
wait(0.5)
local bb = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()
    bb:ClickButton2(Vector2.new())
end)
