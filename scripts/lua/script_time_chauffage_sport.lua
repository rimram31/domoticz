package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'
require 'functions_hysteresis'

commandArray = {}

local confort = tonumber(otherdevices_svalues['Confort'])
local confort_bains = tonumber(otherdevices_svalues['Consigne Bains'])
local eco = tonumber(otherdevices_svalues['Eco'])

--print ("=== Chambre sport ===")
commands = hysteresis('Zone Chambre sport',
                        { 'Sonde Chambre sport'}, 
                        { ['Mode confort Nuit'] = confort },
                        { 'Radiateur Chambre sport'}, 
                          'Actif Chambre sport', 'Presence Chambre sport',
                           eco, 0.15, 30)

commandArray = merge(commandArray,commands)
return commandArray
