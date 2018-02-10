--
-- script test
--
commandArray = {}

local device = 'Test'
local target = 'Phenix B (sapin)'

tc=next(devicechanged)
if tostring(tc) == 'Test' then
   commandArray[1]={[target]='On'}
   commandArray[2]={[target]='Off AFTER 30'}
end

return commandArray
