--
-- script test
--
local h = require "socket.http"
local json = require "json"

commandArray = {}

tc=next(devicechanged)
if tostring(tc) == "Test" then
    print (tostring(tc))
    print (otherdevices_lastupdate[tostring(tc)])
end

return commandArray
