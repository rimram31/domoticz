package.path = package.path..";/home/pi/domoticz/scripts/lua/modules/?.lua"
require 'functions_utils'
require 'functions_hysteresis'

commandArray = {}

local confort = tonumber(otherdevices_svalues['Confort'])
local confort_bains = tonumber(otherdevices_svalues['Consigne Bains'])
local eco = tonumber(otherdevices_svalues['Eco'])

--print ("=== Chambre du Haut ===")
commands = hysteresis('Zone Chambre Haut',
                      { 'Sonde Chambre Haut'}, 
                      { ['Mode confort Nuit'] = confort },
                      { 'Radiateur Chambre Haut'}, 
                        'Actif Chambre Haut', 'Presence Chambre Haut',
                         eco, 0.15, 15)                                       

commandArray = merge(commandArray,commands)
return commandArray
