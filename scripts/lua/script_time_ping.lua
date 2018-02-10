commandArray = {}

debug=false

time=os.time()
minutes=tonumber(os.date('%M',time))
hours=tonumber(os.date('%H',time))

-- Uniquement toutes les 5mn
if (minutes%5 == 1) then
    return {}
end

-- Tests ...
--local sonde = 'Sonde Tel'
--local svalues = otherdevices_svalues[sonde]
--print(svalues)
--print(otherdevices_svalues['Sonde Oregon'])
--otherdevices_svalues['Sonde Oregon']:match("([^;]+);([^;]+)")

--Tableau des périphériques à "pinguer"
-- Key = adresse ip à pinguer
-- Value = périphérique virtuel à switcher
local ping={}
ping['192.168.1.100']='TV'
--ping['192.168.1.120']='openelec'
ping['192.168.1.121']='osmc'
--ping['192.168.1.31']='minilan'
--ping['mobile-didier']='Presence Didier'
ping['192.168.1.51']='mp970'

--pour chaque entree du tableau
for ip, switch in pairs(ping) do
 
  --Le Ping ! : -c1 = Un seul ping  ,   -w1 délai d'une seconde d'attente de réponse
  ping_success=os.execute('ping -c1 -w1 '..ip)
 
  --Si le ping à répondu 
  if ping_success then
    if(debug==true)then
      print("PING".."ping success "..switch)
    end
    --si le switch etait sur off on l'allume
    if(otherdevices[switch]=='Off') then
      commandArray[switch]='On'
    end
  else
    if(debug==true)then
      print("PING".."ping failed "..switch)
    end
    --Si pas de réponse
    if(otherdevices[switch]=='On') then
      commandArray[switch]='Off'
    end
  end
end

return commandArray
