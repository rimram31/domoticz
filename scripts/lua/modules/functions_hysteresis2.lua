package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'

--
-- Hysteresis with multiple confort temperature
--
--  sensors: list, sensors (dz name) to measure temperature, the average is calculated
--  thermostats: array (dict) - the idea is to have a on/off switch for "confort" temperature, having several thermostat
--               with several "confort" temperature allow some exception (I'm using this for bathrooms)
--  radiators: list, radiators (dz name) of switches to set on/off when needed
--  eco: eco temperature
--  hyst: hysteresis margin
--
function hysteresis(zone, sensors, thermostats, radiators, active, present, eco, hyst, resend)
    commands = {}
    
    time=os.time()
    minutes=tonumber(os.date('%M',time))
    hours=tonumber(os.date('%H',time))
    
    local consigne = eco
    if (present == nil or (otherdevices[present]=='On')) then
        for thermostat,value in pairs(thermostats) do
            if (otherdevices[thermostat]=='On') then
                if (value > consigne) then
                    consigne = value
                end
            end
        end
    end		
    
    -- Manage a sensor list -> make the average
    local sum = 0
    local count = 0
    for _, sensor in pairs(sensors) do
        -- uptodate ? (15mn)
        if (lastupdate(sensor) < 900) then
            sum = sum + tonumber(string.sub(otherdevices_svalues[sensor],1,4))
            count = count + 1
        end
    end
    local temperature = 0
    local disable = true
    if (count > 0) then
        temperature = (sum / count)
        disable = (otherdevices[active]=='Off')
    end

    if ( (not disable) and (temperature < (consigne - hyst)) ) then
        for _, radiator in pairs(radiators) do
            if (otherdevices[radiator]=='Off' or (resend == 0 or minutes%resend==0)) then
                commands[radiator]='On'
            end
        end    
    elseif ((disable) or (temperature >= (consigne + hyst))) then
        for _, radiator in pairs(radiators) do
            if (otherdevices[radiator]=='On' or (resend == 0 or minutes%resend==0)) then
                commands[radiator]='Off'
            end
        end    
    end	
    return commands

end
function hysteresisWithAdjustment(zone, sensors, thermostats, radiators, active, present, eco, hyst, resend)

    commands = {}

    print ("------------------")
    print (zone)
    print ("------------------")
    
    time=os.time()
    minutes=tonumber(os.date('%M',time))
    hours=tonumber(os.date('%H',time))
    
    local consigne = eco
    if (present == nil or (otherdevices[present]=='On')) then
        for thermostat,value in pairs(thermostats) do
            if (otherdevices[thermostat]=='On') then
                if (value > consigne) then
                    consigne = value
                end
            end
        end
    end		
    
    -- Manage a sensor list -> make the average
    local sum = 0
    local count = 0
    for _, sensor in pairs(sensors) do
        -- uptodate ? (15mn)
        if (lastupdate(sensor) < 900) then
            sum = sum + tonumber(string.sub(otherdevices_svalues[sensor],1,4))
            count = count + 1
        end
    end
    local temperature = 0
    local disable = true
    if (count > 0) then
        temperature = (sum / count)
        disable = (otherdevices[active]=='Off')
    end

    -- 0.01 degree adjustment every mn but max 1.0
    local adjustment = 0.01 * (lastupdate(zone) / 60)
    if (adjustment > 1.0) then adjustment = 1.0 end
    adjustment = 0.0

    if ( (not disable) and ((temperature - adjustment) < (consigne - hyst)) ) then
        -- used to track last On/Off whatever happen to true heaters (where we resend 433 commands)
        if (otherdevices[zone]=='Off') then commands[zone]='On' end
        for _, radiator in pairs(radiators) do
            if (otherdevices[radiator]=='Off' or (resend == 0 or minutes%resend==0)) then
                commands[radiator]='On'
            end
        end    
    elseif ((disable) or ((temperature + adjustment) >= (consigne + hyst))) then
        if (otherdevices[zone]=='On') then commands[zone]='Off' end
        for _, radiator in pairs(radiators) do
            if (otherdevices[radiator]=='On' or (resend == 0 or minutes%resend==0)) then
                commands[radiator]='Off'
            end
        end    
    end	
    return commands

end
