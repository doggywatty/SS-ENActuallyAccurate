if (other.state != States.actor && sprite_index == spr_lappingportal_idle && global.panic)
{
    with other
    {
        x = other.x;
        y = other.y;
        targetDoor = other.targetDoor;
        targetRoom = other.targetRoom;
        image_index = 0;
        sprite_index = spr_lappingportal_enter;
    }
    event_play_oneshot("event:/SFX/general/lapenter", x, y);
    global.ComboTime = 60;
    global.Collect += 3000;
    create_small_number(x, y, "3000");
    ds_list_add(global.SaveRoom, id);
    cutscene_create([cutscene_lapPortal_start, cutscene_lapPortal_middle, cutscene_lapPortal_end]);
    instance_destroy();
}

