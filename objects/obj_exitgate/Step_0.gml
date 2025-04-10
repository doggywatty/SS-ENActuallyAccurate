if global.panic
    sprite_index = openSpr;

if (place_meeting(x, y, obj_parent_player) && obj_parent_player.state != States.comingoutdoor && sprite_index == openSpr && global.panic == 0 && obj_parent_player.sprite_index != obj_parent_player.spr_lookdoor && sprite_index != closedspr)
{
    ds_list_add(global.SaveRoom, id);
    sprite_index = closingSpr;
    event_play_oneshot("event:/SFX/player/groundpound", (x - sprite_xoffset) + (sprite_width / 2), bbox_bottom);
    camera_shake_add(3, 3);
    obj_parent_player.state = States.comingoutdoor;
    obj_parent_player.image_index = 0;
    obj_parent_player.sprite_index = obj_parent_player.spr_Timesup;
}

if (sprite_index == closingSpr && floor(image_index) == (image_number - 1))
    sprite_index = closedspr;

if (drop && drop_state == 0)
{
    if (!scr_solid(x, y + sign(vsp)))
    {
        y += vsp;
        vsp += grav;
    }
    
    if (y >= drop_y)
    {
        y = drop_y;
        drop_state = 1;
        ds_list_add(global.doorsave, id);
        event_play_oneshot("event:/SFX/player/groundpound", (x - sprite_xoffset) + (sprite_width / 2), bbox_bottom);
        camera_shake_add(15, 30);
    }
}
