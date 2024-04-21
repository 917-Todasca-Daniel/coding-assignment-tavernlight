function removeMemberFromPlayerParty(playerId, membername)
    -- create player reference using id --
    local player = Player(playerId)
    if not player then
        error(string.format("Cannot remove member %s because player with id %d could not be found", membername, playerId))
        -- return false i.e. member was not found in the party
        return false
    end

    local party = player:getParty()
    if not party then
        error(string.format("Cannot remove member %s because player with id %d is not in a party", membername, playerId))
        return false
    end
    
    for _,member in pairs(party:getMembers()) do
        -- do no create a new instance of Player, but compare membernames explicitly --
        if member:getMembername() == membername then
            -- we normally shouldn't remove values while iterating, but it is fine in this case since we exit immediately after --
            -- assumption: we will not find duplicate references to the member, so we can only remove once --
            party:removeMember(member)
            return true
        end
    end

    return false
end