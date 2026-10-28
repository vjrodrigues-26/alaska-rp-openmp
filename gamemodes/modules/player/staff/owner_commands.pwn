forward PC_GetPlayerFlags(playerid);
public PC_GetPlayerFlags(playerid) {
    return PlayerData[playerid][p_AdminPerm];
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags) {    
    if (flags > 0) { 
        if (!(flags & PlayerData[playerid][p_AdminPerm])) {
            SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: No tienes los permisos para usar este comando.");
            return 0;
        }
    }
    
    return 1;
}

flags:darflag(FLAG_OWNER)
cmd:darflag(playerid, params[]) {
    new targetid, flag_lvl;

    if (sscanf(params, "ui", targetid, flag_lvl)) return SendClientMessage(playerid, COLOR_CMD, "/darflag id flag");
    if (!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: El jugador no se encuentra conectado.");

    PlayerData[targetid][p_AdminPerm] |= flag_lvl;

    new string[128], name[MAX_PLAYER_NAME];
    GetPlayerRPName(targetid, name, sizeof(name));

    format(string, sizeof(string), "Haz asignado la flag: %d a %s (ID: %d)", flag_lvl, name, targetid);
    SendClientMessage(playerid, COLOR_CMD, string);
    format(string, sizeof(string), "Te han asignado la flag: %d.", flag_lvl);
    SendClientMessage(targetid, COLOR_PASTELYELLOW, string);

    return 1;
}

flags:quitarflag(FLAG_OWNER)
cmd:quitarflag(playerid, params[]) {
    new targetid, flag_lvl, string[128], name[MAX_PLAYER_NAME];
    
    if (sscanf(params, "ui", targetid, flag_lvl)) return SendClientMessage(playerid, COLOR_CMD, "/quitarflag id flag(0 para quitar todas las flags)");
    if (!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: El jugador no se encuentra conectado.");

    if (flag_lvl == 0) {
        PlayerData[targetid][p_AdminPerm] = 0;
        GetPlayerRPName(targetid, name, sizeof(name));
        format(string, sizeof(string), "Haz removido todas las flags de %s (ID: %d)", name, targetid);
        SendClientMessage(playerid, COLOR_CMD, string);
        format(string, sizeof(string), "Haz sido removido de todas tus flags.");
        SendClientMessage(targetid, COLOR_PASTELYELLOW, string);

        return 1;
        }
    
    PlayerData[targetid][p_AdminPerm] &= ~flag_lvl;
    format(string, sizeof(string), "Te han removido el flag %d.", flag_lvl);
    SendClientMessage(targetid, COLOR_PASTELYELLOW, string);
    
    return 1;
}

// Testing commands
cmd:owner(playerid) {
    PlayerData[playerid][p_AdminPerm] = 8;
    
    new string[128];
    format(string, sizeof(string), "[DEBUG]: Flag dado: %d.", PlayerData[playerid][p_AdminPerm]);
    SendClientMessage(playerid, -1, string);
    return 1;
}

cmd:misflags(playerid) {
    new string[128];

    format(string, sizeof(string), "%d", PlayerData[playerid][p_AdminPerm]);
    SendClientMessage(playerid, COLOR_GREEN, string);
    
    return 1;
}