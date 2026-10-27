enum E_PLAYER_DATA {
    bool:p_isLogged,
    p_sqlid,
    Float:p_posx,
    Float:p_posy,
    Float:p_posz,
    Float:p_hp,
    p_AdminPerm, //Flags
    p_AdminDuty
}
new PlayerData[MAX_PLAYERS][E_PLAYER_DATA];

forward OnPlayerSaveData(playerid);
public OnPlayerSaveData(playerid) {

    GetPlayerPos(playerid, PlayerData[playerid][p_posx], PlayerData[playerid][p_posy], PlayerData[playerid][p_posz]);
    GetPlayerHealth(playerid, PlayerData[playerid][p_hp]);

    new query[285];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE accounts SET pos_x=%f, pos_y=%f, pos_z=%f, hp=%f WHERE id=%d", 
    PlayerData[playerid][p_posx], 
    PlayerData[playerid][p_posy], 
    PlayerData[playerid][p_posz], 
    PlayerData[playerid][p_hp], 
    PlayerData[playerid][p_sqlid]);
    mysql_tquery(g_SQL, query);

    return 1;
}

forward OnPlayerLoadData(playerid);
public OnPlayerLoadData(playerid){
    new query[258];
    
    mysql_format(g_SQL, query, sizeof(query), "SELECT pos_x, pos_y, pos_z, hp FROM accounts WHERE id=%d", PlayerData[playerid][p_sqlid]);
    mysql_tquery(g_SQL, query, "OnPlayerLoadDataFromDB", "i", playerid);

    return 1;
}

forward OnPlayerLoadDataFromDB(playerid);
public OnPlayerLoadDataFromDB(playerid) {
    if (cache_num_rows() > 0) {
        cache_get_value_name_float(0, "pos_x", PlayerData[playerid][p_posx]);
        cache_get_value_name_float(0, "pos_y", PlayerData[playerid][p_posy]);
        cache_get_value_name_float(0, "pos_z", PlayerData[playerid][p_posz]);
        cache_get_value_name_float(0, "hp", PlayerData[playerid][p_hp]);
    }

    TogglePlayerSpectating(playerid, false);
    SpawnPlayer(playerid);
    SetPlayerHealth(playerid, PlayerData[playerid][p_hp]);
    SetPlayerPos(playerid, Float:PlayerData[playerid][p_posx], Float:PlayerData[playerid][p_posy], Float:PlayerData[playerid][p_posz]);
    
    return 1;
}

stock IsValidRpName(playerid) {
    new name[MAX_PLAYER_NAME], i, aux=0;
    GetPlayerName(playerid, name, sizeof(name));

    for (i = 0; i < MAX_PLAYER_NAME; i++) {
        if (name[i] == '\0' || aux > 1) break;
        if (name[i] == '_') {
            aux++;
        }
    }

    if (aux != 1) return false;

    return true;
}

stock CheckUserAccountDB(playerid) {
    if (!PlayerData[playerid][p_isLogged] && PlayerData[playerid][p_sqlid] == 0) {

        new query[128], username[MAX_PLAYER_NAME];
        GetPlayerName(playerid, username, sizeof(username));

        mysql_format(g_SQL, query, sizeof(query), "SELECT id FROM accounts WHERE username = '%e' LIMIT 1", username);
        mysql_tquery(g_SQL, query, "OnPlayerCheckAccount", "i", playerid);
    }

    return 1;
}

hook OnPlayerConnect(playerid) {
    PlayerData[playerid][p_isLogged] = false;
    PlayerData[playerid][p_sqlid] = 0;
    PlayerData[playerid][p_AdminPerm] = 0;
    SetPlayerColor(playerid, -1);
    TogglePlayerSpectating(playerid, true);

    if (!IsValidRpName(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: El nombre no cumple con el estándar Nombre_Apellido."), Kick(playerid);
    CheckUserAccountDB(playerid);

    return 1;
}

hook OnPlayerDisconnect(playerid) {
    OnPlayerSaveData(playerid);

    return 1;
}

forward OnPlayerCheckAccount(playerid);
public OnPlayerCheckAccount(playerid) {
    //Acá va la lógica de chequeo en BD. Guardo esa ID para usarlo en mis dialogs de registro o login
    if (cache_num_rows() > 0) {
        cache_get_value_name_int(0, "id", PlayerData[playerid][p_sqlid]); //Guarda el p_sqlid de una vez

        Dialog_Show(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "Inicio de Sesión", "Ingrese su contraseña a continuación", "Aceptar", "");
        
        return 1;
    } else {
        Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "Registro de Cuenta", "Ingrese una contraseña para su cuenta", "Aceptar", "");
    }
    return 1;
}

new passwordReg[MAX_PLAYERS][15];
Dialog:Dialog_Register(playerid, response, listitem, inputtext[]) {
    if (isnull(inputtext)) {
        Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "Registro de Cuenta", "Ingrese una contraseña para su cuenta", "Aceptar", "");
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: Escribe la contraseña en el campo.");
    } else {
        format(passwordReg[playerid], sizeof(passwordReg[]), "%s", inputtext);
        Dialog_Show(playerid, Dialog_Register2, DIALOG_STYLE_PASSWORD, "Registro de Cuenta", "Ingrese nuevamente la contraseña", "Aceptar", "");
    }
}

Dialog:Dialog_Register2(playerid, response, listitem, inputtext[]) {
    if (isnull(inputtext)) {
        Dialog_Show(playerid, Dialog_Register2, DIALOG_STYLE_PASSWORD, "Registro de Cuenta", "Ingrese una contraseña para su cuenta", "Aceptar", "");
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: Escribe la contraseña en el campo.");
    } else {
        if (strcmp(inputtext, passwordReg[playerid], false) == 0) {
            bcrypt_hash(playerid, "OnRegisterHash", passwordReg[playerid], 12);
            
        } else {
            passwordReg[playerid][0] = '\0'; //Vací­o la contraseña del primer dialog por si acaso
            SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: Las contraseñas no coinciden.");
            Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "Registro de Cuenta", "Ingrese una contraseña para su cuenta", "Aceptar", "");
        }
    }
}

forward OnRegisterHash(playerid);
public OnRegisterHash(playerid) {
    new query[256], name[MAX_PLAYER_NAME], passwordHash[BCRYPT_HASH_LENGTH];
    bcrypt_get_hash(passwordHash);

    GetPlayerName(playerid, name, sizeof(name));
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO accounts (username, password) VALUES ('%e', '%e')", name, passwordHash);
    mysql_tquery(g_SQL, query, "OnPlayerRegister", "i", playerid);
    passwordReg[playerid][0] = '\0'; //Limpio por seguridad
}

Dialog:Dialog_Login(playerid, response, listitem, inputtext[]) {
    if (isnull(inputtext)) {
        Dialog_Show(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "Inicio de Sesión", "Ingrese su contraseña a continuación", "Aceptar", "");
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: Escribe la contraseña en el campo.");
    } else {
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "SELECT password FROM accounts WHERE id = %d", PlayerData[playerid][p_sqlid]);
        mysql_tquery(g_SQL, query, "OnPlayerLogin", "is", playerid, inputtext);
    }
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid) {
    PlayerData[playerid][p_sqlid] = cache_insert_id();
    PlayerData[playerid][p_isLogged] = true;
    TogglePlayerSpectating(playerid, false);

    SendClientMessage(playerid, COLOR_GREEN, "[Éxito]: ¡Cuenta registrada correctamente!");
    SpawnPlayer(playerid);
    SetPlayerPos(playerid, 1714.8829,-1871.3917,13.5666);
}

forward OnPlayerLogin(playerid, pass[]);
public OnPlayerLogin(playerid, pass[]) {
    new password[BCRYPT_HASH_LENGTH];

    cache_get_value_name(0, "password", password, sizeof(password));
    bcrypt_verify(playerid, "OnLoginHash", pass, password);

    return 1;
}

forward OnLoginHash(playerid, bool:success);
public OnLoginHash(playerid, bool:success) {
    if (success) {
        PlayerData[playerid][p_isLogged] = true;
        SendClientMessage(playerid, 0x00FF00FF, "¡Bienvenid@ de vuelta!");

        OnPlayerLoadData(playerid);

        return 1;
    } else return SendClientMessage(playerid, COLOR_ERROR, "[ERROR]: Contraseña incorrecta"), Kick(playerid);
}

stock GetPlayerRPName(playerid, name[], len = MAX_PLAYER_NAME) {
    new i;
    GetPlayerName(playerid, name, len);

    for (i = 0; i < len; i++) {
        if (name[i] == '\0') break;
        if (name[i] == '_') {
            name[i] = ' ';
            break;
        }
    }
    return 1; //TEST
}

hook OnPlayerSpawn(playerid) {
    SetPlayerColor(playerid, -1);
}