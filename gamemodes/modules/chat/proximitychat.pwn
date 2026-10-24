hook OnPlayerText(playerid, text[]) {
    new Float:pos_x, Float:pos_y, Float:pos_z;
    GetPlayerPos(playerid, pos_x, pos_y, pos_z);

    ProximityDetector(playerid, pos_x, pos_y, pos_z, text);
    return 0;
}

stock ProximityDetector(playerid, Float:posx, Float:posy, Float:posz, message[]) {
    new string[200], name[MAX_PLAYER_NAME]; // ESTE STRRING DEPENDE DE UN CONCENSO PARA DEFINIR LA CANTIDAD MAXIMA DE LETRAS DE UN NOMBRE RP
    GetPlayerRPName(playerid, name, sizeof(name));

    format(string, sizeof(string), "%s dice: %s", name, message);

    foreach(new i: Player) {
        if (IsPlayerInRangeOfPoint(i, 5.0, posx, posy, posz)) SendClientMessageLong(i, string, COLOR_CHAT1); //cercano
    }
}