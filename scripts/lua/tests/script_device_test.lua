--
-- script test
--
local h = require "socket.http"
local json = require "json"

commandArray = {}

local units = { ['Radiateur Chambre Julien'] = 1000, 
                ['Heures Creuses'] = 500 }

tc=next(devicechanged)
if units[tostring(tc)] then
    print (tostring(tc))
end

return commandArray
