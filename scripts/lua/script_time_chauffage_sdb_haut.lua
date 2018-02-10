package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'
require 'functions_hysteresis'

commandArray = {}

local confort = tonumber(otherdevices_svalues['Confort'])
local confort_bains = tonumber(otherdevices_svalues['Consigne Bains'])
local eco = tonumber(otherdevices_svalues['Eco'])

--print ("=== Salle de bains haut ===")
commands = hysteresis('Zone Salle de Bains Haut',
                      { 'Sonde Salle de Bains Haut'}, 
                      { ['Mode confort Nuit'] = confort },
                      { 'Radiateur Salle de Bains Haut'}, 
                        'Actif Salle de Bains Haut', 'Presence Salle de Bains Haut',
                         eco, 0.15, 15)

commandArray = merge(commandArray,commands)
return commandArray
