function state_player_cottondrill()
{
    image_speed = 0.35;
    
    if (dir != xscale)
    {
        dir = xscale;
        movespeed = 0;
    }
    
    move = key_left + key_right;
    if (move != 0)
        xscale = move;
    
    if (sprite_index == spr_player_PZ_werecotton_drill_down)
    {
        if (verticalMovespeed < 9)
        {
            verticalMovespeed = approach(verticalMovespeed, 20, 2);
            hsp = move * 8;
        }
        else
        {
            verticalMovespeed = approach(verticalMovespeed, 20, 0.5);
            hsp = move;
        }
        vsp = verticalMovespeed;
    }
    else
    {
        if (vsp > 0.5 && !grounded)
        {
            movespeed = 0;
            vsp = 0;
            hsp = 0;
            sprite_index = spr_cottonDoubleJumpFall;
            state = States.cotton;
        }
        hsp = move;
    }
    
    if (grounded && vsp > 0.5 && !place_meeting(x, y + 1, obj_destructibles) && !place_meeting(x, y + 1, obj_chocofrog))
    {
        doubleJumped = false;
        grav = 0.025;
        if (slopeCheck(x, y))
        {
            movespeed = (verticalMovespeed > 15) ? 12 : 8;
            vsp = 3;
            state = States.cottonroll;
            image_index = 0;
            sprite_index = spr_player_PZ_werecotton_roll;
            if (scr_slope_ext(x, y + 1) && !scr_solid_slope(x, y + 1))
            {
                with instance_place(x, y + 1, obj_slope)
                    other.xscale = -sign(image_xscale);
                with instance_place(x, y + 1, obj_slopePlatform)
                    other.xscale = -sign(image_xscale);
            }
        }
        else if !place_meeting(x, y, obj_cottonsolid)
        {
            state = States.cotton;
            sprite_index = spr_cottonLand;
            vsp = 0;
            movespeed = 0;
            image_index = 0;
        }
    }
    
    if (inputBufferSlap > 0 && sprite_index != spr_player_PZ_werecotton_drill_h && groundedCot && !place_meeting(x, y, obj_cottonsolid))
    {
        inputBufferSlap = 0;
        state = States.cotton;
        flash = true;
        image_index = 0;
        sprite_index = spr_player_PZ_werecotton_drill_h;
        movespeed = max(movespeed, 12);
        vsp = grounded ? 0 : -5;
        grav = 0.2;
        grounded = false;
        event_play_oneshot("event:/SFX/cotton/attack", x, y);
        groundedCot = false;
    }
    
    if (inputBufferJump > 0 && !cottonJumped && !can_jump && !doubleJumped && !place_meeting(x, y, obj_cottonsolid))
    {
        movespeed = 0;
        state = States.cotton;
        cottonJumped = 1;
        vsp = -10;
        grav = 0.025;
        image_index = 0;
        sprite_index = spr_cottonDoubleJump;
        instance_create(x, y, obj_highJumpCloud1, 
        {
            playerID: id
        });
        
        with (instance_create(x, y, obj_highJumpCloud1, 
        {
            playerID: id
        }))
        {
            image_xscale = other.xscale;
            sprite_index = spr_cottonpoof;
        }
        event_play_oneshot("event:/SFX/cotton/jump", x, y);
    }
}

