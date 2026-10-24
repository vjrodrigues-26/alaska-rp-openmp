//Sistema para enviar mensajes largos
stock SendClientMessageEx(playerid, text[]) {
    new text1[128], text2[128]:

    if (text < 128) return SendClientMessage(playerid, COLOR_WHITE, text);
    
    for (new i = 0; i=< 128) {
        text1[i] = text[i];
    }
    SendClientMessage(playerid, COLOR_WHITE, text1);
    for (i = 128; i =< 144) {
        text2=text[i]
    }
    format(text2, sizeof(text2), "...%s", text2);
    SendClientMessage(playerid, COLOR_WHITE, text2)
}
//FIN