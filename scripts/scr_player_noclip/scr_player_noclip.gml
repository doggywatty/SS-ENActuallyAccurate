function state_player_noclip()
{
    vsp = 0;
    hsp = 0;
    prevVsp = 0;
    prevHsp = 0;
    hspCarry = 0;
    vspCarry = 0;
    move = key_left + key_right;
    sprite_index = spr_noclip;
    if key_attack
        movespeed = 18;
    else if (key_slap)
        movespeed = 6;
    else
        movespeed = 12;
    if key_jump
        state = States.normal;
    
    x += (move * movespeed);
    if key_up
        y -= movespeed;
    else if key_down
        y += movespeed;
	global.ComboFreeze = 2;
}

function state_player_freeflight()
{
    move = key_left + key_right;
    move2 = key_down - key_up;
    sprite_index = spr_noclip;
    if !key_slap
    {
        if key_attack
            movespeed = 18;
        else if key_slap
            movespeed = 6;
        else
            movespeed = 12;
        hsp = move * movespeed;
        vsp = move2 * movespeed;
    }
    else
    {
        move = key_left2 + key_right2;
        move2 = key_down2 - key_up2;
        hsp = move;
        vsp = move2;
    }
    if key_jump
        state = States.normal;
}
