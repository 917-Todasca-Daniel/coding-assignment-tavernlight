void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    bool createdNewPlayerInstance = false;

    Player* player = g_game.getPlayerByName(recipient);

    if (!player) {
        player = new Player(nullptr);
        createdNewPlayerInstance = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            // cleanup local player instance in case of faliure
            delete player;
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        /* 
        Only delete the player if it was created within this function.
        Deleting a player obtained from g_game may yield side effects,
            as managing its lifecycle is not the responsibility of this function
        As a guideline, for every 'new' keyword in a function, we should have an equivalent 'delete' keyword 
            (here we have 3 because of multiple exit points).
        */
        if (createdNewPlayerInstance && player) {
            delete player; 
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (createdNewPlayer) {
        delete player; 
        // assumption: we do not delete the item because that would break the reference inside the player inbox
    }
}
