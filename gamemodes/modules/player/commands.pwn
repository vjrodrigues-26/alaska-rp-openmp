CMD:ls(playerid, params[]) {
    SetPlayerPos(playerid, 2494.0, -1683.0, 14.0);
    
    return 1;
}

CMD:givehealth(playerid, params[]) {
    new Float:health;
    
    if (sscanf(params, "f", health)) return SendClientMessage(playerid, COLOR_CMD, "/givehealth vida");
    SetPlayerHealth(playerid, Float:health);
    
    return 1;
}

CMD:myrpname(playerid) {
    new string[128], name[MAX_PLAYER_NAME];
    GetPlayerRPName(playerid, name, sizeof(name));
    format(string, sizeof(string), "%s", name);
    SendClientMessage(playerid, -1, string);
    return 1;
}