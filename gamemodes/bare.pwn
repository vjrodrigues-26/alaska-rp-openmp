#include <open.mp>

// INCLUDES //
#include <a_mysql>
#include <Pawn.CMD>
#include <sscanf2>
#include <streamer>
#include <YSI_Coding\y_hooks>
#include <easyDialog>
#include <samp_bcrypt>
#include <foreach>
// FIN INCLUDES //

// MODULES //
#include "modules/core/database.pwn"
#include "modules/core/colors.inc"
#include "modules/player/accounts.pwn"
#include "modules/player/commands.pwn"
#include "modules/chat/proximitychat.pwn"
#include "modules/chat/messagemanager.pwn"
// FIN MODULES //

main()
{
    print("\n----------------------------------");
    print("  Mi Servidor RP - Iniciado Correctamente");
    print("----------------------------------\n");
}

public OnGameModeInit()
{
    SetGameModeText("Roleplay v0.1");

    return 1;
}

public OnGameModeExit()
{
    return 1;
}