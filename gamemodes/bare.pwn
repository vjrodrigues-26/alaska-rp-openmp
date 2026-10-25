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
#include "modules/player/staff/owner_commands.pwn"
#include "modules/player/staff/helper_commands.pwn"
// FIN MODULES //

//DEFINES FLAGS //
#define FLAG_NONE   0
#define FLAG_OWNER  (1 << 3)
#define FLAG_HELPER (1 << 0)
// FIN DEFINES FLAGS //

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