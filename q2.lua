function printSmallGuildNames(memberCount)
    -- this method prints the names of all guilds that have less than memberCount max members in separate lines
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))

    -- add error handling --
    if resultId == false then
        print(string.format("No guilds found with max_members less than %d", memberCount))
        return
    end

    repeat
        local guildName = db.getResult(resultId, "name")
        if guildName then
            print(guildName)
        end
    until not db.next(resultId)

    db.freeResult(resultId)
end