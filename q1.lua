local PLAYER_STORAGE_KEY = 1000
local PLAYER_STORAGE_VALUE_USED = 1
local PLAYER_STORAGE_VALUE_RELEASED = -1
local RELEASE_STORAGE_DELAY_MS = 1000

local function releaseStorage(player)
    player:setStorageValue(PLAYER_STORAGE_KEY, PLAYER_STORAGE_VALUE_RELEASED)
end
    
function onLogout(player)
    if not player then
        print("Player reference was nil on logout operation")
        -- adding boolean value for the success value of the logout operation --
        return
    end

    if player:getStorageValue(PLAYER_STORAGE_KEY) == PLAYER_STORAGE_VALUE_USED then
        -- assumption: the second parameter here is a delay of miliseconds for the event --
        addEvent(releaseStorage, RELEASE_STORAGE_DELAY_MS, player)
    end
    
    return true
end