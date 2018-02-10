package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'

commandArray = {}

debug=false

time=os.time()
minutes=tonumber(os.date('%M',time))
hours=tonumber(os.date('%H',time))

-- Uniquement toutes les 15mn
if (minutes%15 ~= 0) then
    return {}
end

sensors = { 'Sonde Salle de Bains bas',
            'Sonde Chambre Julien',
            'Sonde Bureau',
            'Sonde Salle de Bains Haut',
            'Sonde Chambre Haut',
            'Sonde Chambre sport'
          }

not_available=0
nsensors=0
for _, sensor in pairs(sensors) do
    if (lastupdate(sensor) > 900) then
        not_available = not_available + 1
    end
    nsensors = nsensors + 1
end

if (not_available > nsensors/2) then
    -- Half of sensors not available, reboot domoticz
    os.execute("/etc/init.d/domoticz.sh restart")
end
