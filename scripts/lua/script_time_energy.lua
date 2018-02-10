--
-- script energy
--
commandArray = {}

function updateCounter(device, idx, power, energy, i)
    commandArray[i] = {['UpdateDevice'] = idx .. "|0|" .. power .. ";" .. energy}
    return
end

-- Units to be checked
local units = { ['Radiateur Chambre Haut'] = 1500, 
                ['Radiateur Salle de Bains Haut'] = 1500,
                ['Radiateur Chambre sport'] = 750,
                ['Radiateur Chambre Julien'] = 750,
                ['Radiateur Salle de Bains bas'] = 500,
                ['Radiateur Bureau'] = 1500
              }

local hcSwitch = 'Heures Creuses'

local gCounter = 'Compteur General'
local gCounterId = 153
local hpCounter = 'Compteur HP'
local hpCounterId = 154
local hcCounter = 'Compteur HC'
local hcCounterId = 155

local hc_kwh_price = 0.0623
local hp_kwh_price = 0.1019

--
-- Determine instant power delivered and enerdy from last update (one minute as this is a time script)
--
local iEnergy = 0.0
local iPower = 0.0
local iTimeHours = 60/3600
for unit, power in pairs(units) do
    if (otherdevices[unit]=='On') then
        iPower = iPower + power
        iEnergy = iEnergy + power * iTimeHours
    end
end

if 1 then
--if (iEnergy > 0) then
    -- Counter HC/HP to be updated
    local counter = hpCounter
    local counterId = hpCounterId
    if otherdevices[hcSwitch]=='On' then
        counter = hcCounter
        counterId = hcCounterId
    end

    -- Update HC/HP counter
    hPower, hEnergy = string.match(otherdevices_svalues[counter], "(%d+%.*%d*);(%d+%.*%d*)")
    hEnergy = hEnergy + iEnergy
    updateCounter(counter, counterId, iPower, hEnergy, 1)

    -- Update global counter
    gPower, gEnergy = string.match(otherdevices_svalues[gCounter], "(%d+%.*%d*);(%d+%.*%d*)")
    gEnergy = gEnergy + iEnergy
    updateCounter(gCounter, gCounterId, iPower, gEnergy, 2)

end

return commandArray
