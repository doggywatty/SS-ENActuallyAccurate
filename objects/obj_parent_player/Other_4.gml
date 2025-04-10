scr_roomStart_SetPosition_player(id);

if (global.Combo <= 0 && room != global.LevelFirstRoom && !instance_exists(obj_exitgate) && !instance_exists(obj_lapPortal))
    global.ComboLost = true;

with obj_coneball_timesUp
{
    x = other.x;
    y = other.y;
    image_alpha = 0;
}

with obj_parent_confecti
{
    ds_queue_clear(followQueue);
    x = other.x;
    y = other.y;
    targetx = other.x;
    targety = other.y;
    distance = 0;
    magnitude = 0;
}

with obj_spookey
{
    x = other.x;
    y = other.y;
    hsp = 0;
    vsp = 0;
}

roomName = room_get_name(room);
