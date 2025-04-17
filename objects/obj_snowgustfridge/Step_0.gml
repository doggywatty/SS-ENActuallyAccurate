if (place_meeting(x, y, obj_parent_player))
{
    with obj_parent_player
    {
        if (place_meeting(x, y, other) && state != States.noclip && state != States.oldtaunt && !cutscene)
        {
            if (state != States.frostburnjump && state != States.frostburnnormal && state != States.frostburnstick)
            {
                state = States.frostburnnormal;
                movespeed = clamp(movespeed, 0, 8);
                other.sprite_index = spr_fridge_attack;
                other.image_index = 0;
            }
        }
    }
}

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 300, y - 100, x + 300, y + 100))
{
    if (sprite_index == spr_fridge_idle)
    {
        sprite_index = spr_fridge_opening;
        image_index = 0;
    }
    
    if (sprite_index == spr_fridge_opening && sprite_animation_end())
        sprite_index = spr_fridge_open;
}
else
{
    if ((sprite_index != spr_fridge_closing && sprite_index != spr_fridge_idle && sprite_index != spr_fridge_attack) || (sprite_index == spr_fridge_attack && sprite_animation_end()))
    {
        sprite_index = spr_fridge_closing;
        image_index = 0;
    }
    
    if (sprite_index == spr_fridge_closing && sprite_animation_end())
        sprite_index = spr_fridge_idle;
}

