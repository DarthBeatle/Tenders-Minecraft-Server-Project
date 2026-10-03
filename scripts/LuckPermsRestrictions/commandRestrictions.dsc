## The LuckPerms plugin is required to use this script!

#TODO: log the command if the player does not have permission

# Hide commands from players tab completion if they don't have the required permissions
hide_commands:
    type: world
    debug: true
    events:
        on player receives commands:
            - define commands <script[restricted_server_commands_list]>
            - define bukkit <[commands].parsed_key[bukkit_commands]>
            - define fawe <[commands].parsed_key[fawe_commands]>
            - define luckperms <[commands].parsed_key[luckperms_commands]>
            - define worldguard <[commands].parsed_key[worldguard_commands]>
            - define chat <[commands].parsed_key[chat_commands]>
            - define minecraft_chat <[commands].parsed_key[minecraft_chat_commands]>
            - define allow_all <context.commands>
            - define restrict_all <context.commands.exclude[<[bukkit]>].exclude[<[fawe]>].exclude[<[luckperms]>].exclude[<[worldguard]>].exclude[<[minecraft_chat]>]>
            # If player is an admin, hide nothing
            - if <player.has_permission[server.commands.see_all_commands]>:
                - determine <[allow_all]>
            - else:
                - determine <[restrict_all]>

# Hide the list of plugins on the server from players
hide_plugins:
    type: world
    debug: true
    events:
        on plugins|pl|bukkit&coplugins|bukkit&copl command:
            - if <context.source_type> == PLAYER && !<player.has_permission[server.commands.plugins]>:
            # Show custom /plugins message to player
                - narrate "<gold>This server is powered by Denizen ... and a few other plugins :)"
                - determine FULFILLED

# Hide fawe version from players
hide_fawe:
    type: world
    debug: true
    events:
        on fastasyncworldedit|fastasyncworldedit&cofastasyncworldedit|fastasyncworldedit&cofawe|fastasyncworldedit&cowe|fastasyncworldedit&coworldedit|fawe|we|worldedit command:
            - if <context.source_type> == PLAYER && !<player.has_permission[server.commands.fawe]>:
                - narrate "<red>Unknown or incomplete command."
                - determine FULFILLED

# Hide luckperms version from players
hide_luckperms:
    type: world
    debug: true
    events:
        on lp|luckperms|luckperms&colp|luckperms&coluckperms|luckperms&coperm|luckperms&copermission|luckperms&copermissions|luckperms&coperms|perm|permission|permissions|perms command:
            - if <context.source_type> == PLAYER && !<player.has_permission[server.commands.luckperms]>:
                - narrate "<red>Unknown or incomplete command."
                - determine FULFILLED

# Hide worldguard version from players
hide_worldguard:
    type: world
    debug: true
    events:
        on worldguard|worldguard&cogod|worldguard&coheal|worldguard&coregion|worldguard&coregions|worldguard&corg|worldguard&coslay|worldguard&coungod|god|ungod|heal|slay|rg|region|regions command:
            - if <context.source_type> == PLAYER && !<player.has_permission[server.commands.worldguard]>:
                - narrate "<red>Unknown or incomplete command."
                - determine FULFILLED

# Below are commands that all players have access to by default. Many of these show up in the command list regardless of their respective plugin permission nodes
# For example: /lp has no built-in permission node and simply returns the version of LuckPerms running on the server
# I will use Denizen to hide the majority, if not all, of these commands from players who don't need them
restricted_server_commands_list:
    type: data
    debug: true
    # In some cases, I want the player to only see 1 or 2 forms of an available command
    # For example: I want the player to be able to see /? or /help. But I feel that /bukkit:? and /bukkit:help are both redundant and clutter the command list. They won't appear in the command list, but the player can still use them if they so choose
    bukkit_commands:
        - bukkit:?
        - bukkit:help
        - icanhasbukkit
        - bukkit:plugins
        - bukkit:pl
        - bukkit:about
        - bukkit:ver
        - bukkit:version
    fawe_commands:
        - fastasyncworldedit
        - fastasyncworldedit:fastasyncworldedit
        - fastasyncworldedit:fawe
        - fastasyncworldedit:we
        - fastasyncworldedit:worldedit
        - fawe
        - we
        - worldedit
    luckperms_commands:
        - lp
        - luckperms
        - luckperms:lp
        - luckperms:luckperms
        - luckperms:perm
        - luckperms:perms
        - luckperms:permission
        - luckperms:permissions
        - perm
        - permission
        - permissions
        - perms
    # Some commands, like /god, the player does not have access to by default but the command still shows up in the command list. The player can run it and get the message "You don't have permission to do that." I will use Denizen to hide this and similar commands.
    worldguard_commands:
        - god
        - heal
        - ungod
        - region
        - regions
        - rg
        - slay
        - worldguard:god
        - worldguard:heal
        - worldguard:region
        - worldguard:regions
        - worldguard:rg
        - worldguard:slay
        - worldguard:ungod
    # Just in case I need to revoke someone's private messaging permissions. I will use LuckPerms permissions and a group for that
    chat_commands:
        - me
        - msg
        - tell
        - w
    # Again, I want the player to be able to see /me, /msg, /tell, and /w. But I want only 1 form of each command available in the command list to prevent clutter. The players can still use the commands if they so choose
    minecraft_chat_commands:
        - minecraft:me
        - minecraft:msg
        - minecraft:tell
        - minecraft:w