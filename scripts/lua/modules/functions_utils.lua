function merge(dict1,dict2)
    for k,v in pairs(dict2) do dict1[k] = v end
    return dict1
end

function lastupdate(device)
    s = otherdevices_lastupdate[device]
    year = string.sub(s, 1, 4)
    month = string.sub(s, 6, 7)
    day = string.sub(s, 9, 10)
    hour = string.sub(s, 12, 13)
    minutes = string.sub(s, 15, 16)
    seconds = string.sub(s, 18, 19)
    return os.difftime(os.time(),os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds})
end
