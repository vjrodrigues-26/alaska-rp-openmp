flags:aduda(FLAG_HELPER)
CMD:aduda(playerid, params[]) {
    new targetid, name[MAX_PLAYER_NAME], string[128], targetname[MAX_PLAYER_NAME];

    if (sscanf(params, "i", targetid)) return SendClientMessage(playerid, COLOR_CMD, "/aduda ID");
    if (PlayerData[targetid][p_HasDuda] != 1) return SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: El usuario no tiene una duda activa.");

    GetPlayerRPName(playerid, name, sizeof(name));
    GetPlayerRPName(playerid, targetname, sizeof(targetname));
    format(string, sizeof(string), "La duda de %s (%d) ha sido aceptada por %s.", targetname, targetid, name);

    foreach (new i: Player) {
        if (PlayerData[i][p_AdminPerm] > 0) {
            SendClientMessage(i, COLOR_AMBARYELLOWLIGHT, string);
        }
    }

    format(string, sizeof(string), "Su duda ha sido aceptada por %s (%d). Usa /mp %d para comunicarse.", name, playerid, playerid);
    SendClientMessage(targetid, COLOR_AMBARYELLOWLIGHT, string);

    PlayerData[targetid][p_HasDuda] = 0;
    
    return 1;
}