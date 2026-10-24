hook OnPlayerText(playerid, text[]) {
    new Float:pos_x, Float:pos_y, Float:pos_z;
    GetPlayerPos(playerid, pos_x, pos_y, pos_z);

    ProximityDetector(playerid, pos_x, pos_y, pos_z, text);
    return 0;
}

//Función de chat local (proximal)
stock ProximityDetector(playerid, Float:posx, Float:posy, Float:posz, message[]) {
    new string[128], name[MAX_PLAYER_NAME];
    GetPlayerRPName(playerid, name, sizeof(name));

    format(string, sizeof(string), "%s dice: %s", name, message);

    foreach(new i: Player) {
        if (IsPlayerInRangeOfPoint(i, 5.0, posx, posy, posz)) SendClientMessage(i, COLOR_CHAT1, string); //cercano
    }
}
//FIN