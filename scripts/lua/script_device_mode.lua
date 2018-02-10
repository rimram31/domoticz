--
-- 
commandArray = {}
if (devicechanged['Planning confort Jour Travail'] or devicechanged['Planning confort Jour Vacances']) then
    local planningWork = 'Planning confort Jour Travail'
    local planningHoliday = 'Planning confort Jour Vacances'
    local workday = (otherdevices['Jour ferie']=='Off' and otherdevices['Vacances']=='Off')
    local target = 'Mode confort Jour'
    if (devicechanged[planningWork] and workday) then
        commandArray[target]=devicechanged[planningWork]
    elseif (devicechanged[planningHoliday] and (not workday)) then
        commandArray[target]=devicechanged[planningHoliday]
    end
elseif (devicechanged['Planning confort Nuit Travail'] or devicechanged['Planning confort Nuit Vacances']) then
    local planningWork = 'Planning confort Nuit Travail'
    local planningHoliday = 'Planning confort Nuit Vacances'
    local workday = (otherdevices['Jour ferie']=='Off' and otherdevices['Vacances']=='Off')
    local target = 'Mode confort Nuit'
    if (devicechanged[planningWork] and workday) then
        commandArray[target]=devicechanged[planningWork]
    elseif (devicechanged[planningHoliday] and (not workday)) then
        commandArray[target]=devicechanged[planningHoliday]
    end
elseif (devicechanged['Planning confort Bain Travail'] or devicechanged['Planning confort Bain Vacances']) then
    local planningWork = 'Planning confort Bain Travail'
    local planningHoliday = 'Planning confort Bain Vacances'
    local workday = (otherdevices['Jour ferie']=='Off' and otherdevices['Vacances']=='Off')
    local target = 'Mode confort Bain'
    if (devicechanged[planningWork] and workday) then
        commandArray[target]=devicechanged[planningWork]
    elseif (devicechanged[planningHoliday] and (not workday)) then
        commandArray[target]=devicechanged[planningHoliday]
    end
end
return commandArray
