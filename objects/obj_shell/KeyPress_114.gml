if (global.DebugMode == debugmode.off)
    exit;

if (obj_parent_player.state != states.noclip)
    obj_parent_player.state = states.noclip;
else
    obj_parent_player.state = states.normal;