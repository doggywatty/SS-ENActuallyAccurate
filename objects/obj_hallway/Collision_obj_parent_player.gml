with other.id
{
    other.playerPosX ??= other.x + (other.sprite_width / 2);
    other.playerPosY ??= y;
    x = other.playerPosX;
    y = other.playerPosY;
    if !instance_exists(obj_fadeoutTransition)
    {
        if other.ResetSaveroom
        {
            global.Collect = 0;
            ds_list_clear(global.SaveRoom);
            ds_list_clear(global.BaddieRoom);
        }
        event_play_oneshot("event:/SFX/general/door");
        obj_parent_player.targetDoor = other.targetDoor;
        obj_parent_player.targetRoom = other.targetRoom;
        obj_parent_player.hallway = true;
        obj_parent_player.hallwaydirection = sign(other.image_xscale);
        obj_parent_player.x = obj_parent_player.x;
        obj_parent_player.y = obj_parent_player.y;
        other.showDoorLight = 1;
        image_index = 0;
        instance_create(x, y, obj_fadeoutTransition);
    }
}
