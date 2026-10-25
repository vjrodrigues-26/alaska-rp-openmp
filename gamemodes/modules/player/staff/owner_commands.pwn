forward PC_GetPlayerFlags(playerid);
public PC_GetPlayerFlags(playerid) {
    return PlayerData[playerid][p_AdminPerm];
}

cmd:darflag(playerid, params[]) {
    new targetid, flag_lvl;

    if (sscanf(params, "ui", targetid, flag_lvl)) return SendClientMessage(playerid, COLOR_CMD, "/darflag id flag");
    if (!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: El jugador no se encuentra conectado.");

    PlayerData[targetid][p_AdminPerm] = flag_lvl;

    SendClientMessage(playerid, COLOR_CMD, "Haz asignado la flag correctamente.");
    SendClientMessage(targetid, COLOR_CMD, "Haz sigo asignado a una flag.");

    return 1;
}

// Testing commands
cmd:owner(playerid) {
    PlayerData[playerid][p_AdminPerm] = 8;
    
    SendClientMessage(playerid, COLOR_CMD, "Owner dado.");
    return 1;
}