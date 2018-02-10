package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'
require 'functions_hysteresis'

commandArray = {}

local confort = tonumber(otherdevices_svalues['Confort'])
local confort_bains = tonumber(otherdevices_svalues['Consigne Bains'])
local eco = tonumber(otherdevices_svalues['Eco'])

--print ("=== Chambre Julien ===")
commands = hysteresis('Zone Chambre Julien',
                         { 'Sonde Chambre Julien'}, 
                         { ['Mode confort Nuit'] = confort },
                         { 'Radiateur Chambre Julien'}, 
                           'Actif Chambre Julien', 'Presence Chambre Julien',
                           eco, 0.15, 30)

commandArray = merge(commandArray,commands)
return commandArray
