public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) {
    if (result == -1) {
        new string[128];
        format(string, sizeof(string), "[ERROR]: El comando '%s' no existe. Usa /ayuda para ver los disponibles.", cmd);
        SendClientMessage(playerid, COLOR_CMD, string);
        return 0;
    }
    return 1;
}

stock SendClientMessageLong(playerid, const text[], color) {
    new text1[128], text2[144];

    if (strlen(text) <= 128) return SendClientMessage(playerid, color, text);

    strmid(text1, text, 0, 127, sizeof(text1));
    SendClientMessage(playerid, color, text1);
    strmid(text2, text, 127, strlen(text), sizeof(text2));

    
    new finaltext[144];
    format(finaltext, sizeof(finaltext), "...%s", text2);
    SendClientMessage(playerid, color, finaltext);

    return 1;
}