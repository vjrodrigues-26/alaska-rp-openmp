stock MySQL:g_SQL;

hook OnGameModeInit() {
    mysql_tquery(g_SQL, "SET NAMES 'utf8mb4'");
    g_SQL = mysql_connect("localhost", "openmp_user", "password123", "openmp_rp");

    if (mysql_errno(g_SQL) != 0) {
        new error_string[128];//depurando
        mysql_error(error_string, sizeof(error_string), g_SQL);

        print("[MYSQL ERROR]: No se pudo conectar a la base de datos 'openmp_rp'.");
        printf("[MYSQL ERROR:” DEBUG]: Código: %d | Mensaje: %s", mysql_errno(g_SQL), error_string);
    }
    else {
        mysql_set_charset("utf8mb4", g_SQL);
        print("[MYSQL] Conexión establecida exitosamente con la base de datos 'openmp_rp'.");
    }

    return 1;
}

hook OnGameModeExit() {
    mysql_close(g_SQL);

    return 1;
}

stock MySQL:getDbHandle() {
    return g_SQL;
}