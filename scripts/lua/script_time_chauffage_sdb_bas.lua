package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'
require 'functions_hysteresis'

commandArray = {}

local confort = tonumber(otherdevices_svalues['Confort'])
local confort_bains = tonumber(otherdevices_svalues['Consigne Bains'])
local eco = tonumber(otherdevices_svalues['Eco'])

--print ("=== Salle de bains bas ===")
commands = hysteresis('Zone Salle de Bains bas',
                      { 'Sonde Salle de Bains bas'}, 
                      { ['Mode confort Nuit'] = confort, ['Mode confort Bain'] = confort_bains },
                      { 'Radiateur Salle de Bains bas'}, 
                        'Actif Salle de Bains bas', 'Presence Salle de Bains bas',
                        eco, 0.15, 30)

commandArray = merge(commandArray,commands)
return commandArray
