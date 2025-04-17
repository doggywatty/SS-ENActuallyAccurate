if (sprite_index == spr_fredturn && sprite_animation_end())
{
    sprite_index = spr_fredturnidle;
    
    with obj_parent_player
    {
        if (state == States.minecart)
        {
            hsp *= -0.8;
            movespeed *= 0.8;
            xscale *= -1;
        }
    }
}

if (switchcooldown >= 0)
    switchcooldown--;

