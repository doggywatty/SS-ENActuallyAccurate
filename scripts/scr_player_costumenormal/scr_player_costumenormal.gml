function state_player_costumenormal()
{
    sprite_index = spr_costume_idle;
    move = key_left + key_right;
    hsp = movespeed;
    
    if (substate != 2)
    {
        if grounded
        {
            substate = 0;
            jumpStop = false;
        }
        
        if (movespeed != 0)
            xscale = sign(movespeed);
        
        movespeed = approach(movespeed, move * 8, 0.8);
        if key_jump
        {
            if grounded
                vsp = -12;
            else if (substate == 0)
            {
                vsp = -8;
                substate = 1;
            }
        }
        
        if (!key_jump2 && !jumpStop && vsp < 0.5 && !stompAnim)
        {
            vsp /= 20;
            jumpStop = true;
        }
        
        if key_shoot2
        {
            state = States.costumebreeze;
            breezeCooldown = 25;
            instance_create(x, y, obj_breezehitbox);
            movespeed = 12 * xscale;
            if !grounded
                vsp = -6;
        }
        
        chuckCooldown = approach(chuckCooldown, 120, 1);
        if (key_attack && chuckCooldown >= 30)
        {
            if (move != 0)
                xscale = move;
            
            state = States.costumechuck;
            sprite_index = spr_swingDing;
        }
        
        if (key_slap2 && grounded && place_meeting(x, y + 64, obj_iceblock))
        {
            substate = 2;
            costumegrabdelay = 15;
            with instance_place(x, y + 82, obj_iceblock)
            {
                hsp = 0;
                vsp = 0;
            }
        }
    }
    
    if (substate == 2)
    {
        hsp = 0;
        vsp = 0;
        costumegrabdelay--;
        with instance_place(x, y + 64, obj_iceblock)
        {
            shake = 1;
            hsp = 0;
            vsp = 0;
        }
        if (costumegrabdelay <= 0)
        {
            with instance_place(x, y + 64, obj_iceblock)
            {
                state = icestate.grabbed;
                other.costumeBlockDetails = details;
                other.costumeBlock = id;
                shake = 0;
            }
            state = States.costumegrab;
            substate = 0;
        }
    }
}
