function state_player_actor()
{
    global.ComboFreeze = 15;
    if (sprite_index == spr_gotTreasure)
    {
        vsp = 0;
        image_speed = 0.35;
    }
}

function state_player_titlescreen()
{
    image_speed = 0.35;
}

function state_player_gotkey()
{
    cutscene = true;
    global.ComboFreeze = 15;
    hsp = approach(hsp, 0, 0.2);
    movespeed = 0;
    if (sprite_index == spr_player_PZ_freeFall_1 || sprite_index == spr_fall)
    {
        if grounded
        {
            hsp = 0;
            sprite_index = spr_land;
            image_index = 0;
        }
    }
    
    if (sprite_index == spr_land && sprite_animation_end())
    {
        sprite_index = spr_player_PZ_gotKey;
        image_index = 0;
    }
    
    if (sprite_index == spr_player_PZ_gotKey && sprite_animation_end())
    {
        hsp = approach(hsp, 0, 4);
        vsp = 0;
        state = States.normal;
        with obj_spookey
        {
            if (x == xprevious)
                sprite_index = spr_spookey;
            else
                sprite_index = spr_spookey_move;
        }
        move = key_right + key_left;
        if (move != 0)
            xscale = sign(move);
    }
    image_speed = 0.35;
}

