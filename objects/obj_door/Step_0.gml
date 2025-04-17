if (escapeBlockedDoor && global.panic)
{
    showDoorLight = false;
    sprite_index = spriteDoorEscape;
    if spriteDoorEscape == spr_tutorialdoor
        image_index = 1;
    if !place_meeting(x, y, obj_doorblocked)
        instance_create(x, y, obj_doorblocked);
    exit;
}

with obj_parent_player
{
    if (place_meeting(x, y, other.id) && !instance_exists(obj_fadeoutTransition) && key_up && grounded && (state == States.normal || state == States.Sjumpprep || state == States.mach2 || state == States.mach3 || state == States.run) && state != States.door && state != States.victory && state != States.comingoutdoor)
    {
        image_index = 0;
        state = States.door;
        targetDoor = other.targetDoor;
        targetRoom = other.targetRoom;
        obj_camera.chargeCameraX = 0;
        if (ds_list_find_index(global.SaveRoom, other.id) == -1)
            ds_list_add(global.SaveRoom, other.id);
    }
}
