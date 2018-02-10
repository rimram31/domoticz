--
-- /domoticz/scripts/lua/script_device_poopeye.lua
--

commandArray = {}

--local real = 'le nom de ton device reel'
local real = 'Test'
--local virtual = 'le nom de ton device virtuel'
local virtual = 'Test 2'

if (devicechanged[real]) then
    if (devicechanged[real] ~= otherdevices[virtual]) then
        commandArray[virtual] = devicechanged[real]
    end
end

return commandArray
