if (instance_exists(obj_creamThief) && ds_list_find_index(global.SaveRoom, id) == -1)
{
    with obj_creamThief
    {
        movespeed = 0;
        hsp = 0;
        state = States.stun;
        sprite_index = spr_creamthief_startRace;
        image_index = 0;
    }
    ds_list_add(global.SaveRoom, id);
}

