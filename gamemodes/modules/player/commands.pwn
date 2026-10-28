CMD:me(playerid, params[]) {
    if(isnull(params)) return SendClientMessage(playerid, COLOR_CMD, "/me acción.");
    
    new Float:posx, Float:posy, Float:posz, string[200], name[MAX_PLAYER_NAME];
    GetPlayerPos(playerid, posx, posy, posz);
    GetPlayerRPName(playerid, name, sizeof(name));
    format(string, sizeof(string), "* %s %s", name, params);

    ProximityDetector(posx, posy, posz, string, COLOR_ME, 20, false);
    return 1;
}

CMD:dos(playerid, params[]) {
    if(isnull(params)) return SendClientMessage(playerid, COLOR_CMD, "/do acción.");

    new Float:posx, Float:posy, Float:posz, string[200], name[MAX_PLAYER_NAME];
    GetPlayerPos(playerid, posx, posy, posz);
    GetPlayerRPName(playerid, name, sizeof(name));
    format(string, sizeof(string), "%s (( %s ))", params, name);

    ProximityDetector(posx, posy, posz, string, COLOR_ME, 20, false);

    return 1; 
}
alias:dos("do")

CMD:duda(playerid, params[]) {
    new usermessage[144], string[144], name[MAX_PLAYER_NAME];
    
    if (sscanf(params, "s[144]", usermessage)) return SendClientMessage(playerid, COLOR_CMD, "/duda texto");
    SendClientMessage(playerid, -1, usermessage);

    GetPlayerRPName(playerid, name, sizeof(name));
    format(string, sizeof(string), "[DUDA] %s (%d): %s", name, playerid, usermessage);

    foreach(new i: Player) {
        if (PlayerData[i][p_AdminPerm] > 0) {
            SendClientMessageLong(i, string, COLOR_AMBARYELLOW);
        }
    } 
    return 1;
}

//Testing commands
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