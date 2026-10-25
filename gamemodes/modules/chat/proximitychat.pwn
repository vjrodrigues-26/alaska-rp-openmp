hook OnPlayerText(playerid, text[]) {
    new string[200], name[MAX_PLAYER_NAME], Float:pos_x, Float:pos_y, Float:pos_z;
    GetPlayerPos(playerid, pos_x, pos_y, pos_z);
    GetPlayerRPName(playerid, name, sizeof(name));

    format(string, sizeof(string), "%s dice: %s", name, text);
    ProximityDetector(playerid, pos_x, pos_y, pos_z, string, -1 , 15, true); //For IC chats
    
    return 0;
}

stock ProximityDetector(playerid, Float:posx, Float:posy, Float:posz, const message[], color, Float:range, bool:isPlayerChat) { 
    foreach (new i: Player) {
        new Float:dist = GetPlayerDistanceFromPoint(playerid, posx, posy, posz);

        if (dist <= range) {
            if (isPlayerChat) {
                if (dist <= 3) color = COLOR_CHAT1;
                else if (dist <= 5) color = COLOR_CHAT2;
                else if (dist <= 8) color = COLOR_CHAT3;
                else if (dist <= 11) color = COLOR_CHAT4;
                else color = COLOR_CHAT5;
            }
            SendClientMessageLong(playerid, message, color);
        }
    }
}