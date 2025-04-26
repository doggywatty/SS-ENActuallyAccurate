function state_player_wallkick()
{
    floatyGrab = 0;
    move = key_left + key_right;
    hsp = movespeed;
    if (move != 0)
    {
        movespeed = approach(movespeed, 10 * move, 0.8);
        dir = move;
    }
    else
        movespeed = approach(movespeed, 0, 0.45);
    
    if (place_meeting_collision(x + sign(movespeed), y)
	&& !place_meeting(x + sign(movespeed), y, obj_destructibles))
        movespeed = 0;
    if (!grounded && (key_down || sprite_index == spr_wallJumpFastFall
	|| sprite_index == spr_wallJumpFastFallIntro))
    {
        vsp = max(vsp, 14);
        if (sprite_index != spr_wallJumpFastFallIntro && sprite_index != spr_wallJumpFastFall)
        {
            sprite_index = spr_wallJumpFastFallIntro;
            image_index = 0;
            fmod_studio_event_instance_start(sndDive);
        }
        else if (inputBufferJump > 0 && sprite_index == spr_wallJumpFastFall)
        {
            inputBufferJump = 0;
            state = States.freefall;
            image_index = 0;
            sprite_index = spr_diveBombstart;
            dir = xscale;
            hsp = movespeed * xscale;
            movespeed = abs(movespeed);
            vsp = -6;
            verticalMovespeed = vsp;
            freeFallSmash = 0;
        }
    }
    
    if (inputBufferSlap > 0)
    {
        inputBufferSlap = 0;
        jumpStop = true;
        xscale = dir;
        if !key_up
        {
            sprite_index = spr_wallJumpCancelIntro;
            image_index = 0;
            movespeed = 12;
            hsp = movespeed * xscale;
            vsp = -5;
            state = States.mach3;
            fmod_studio_event_instance_start(sndMachStart);
            fmod_studio_event_instance_start(sndWallkickCancel);
        }
        else
            do_uppercut();
    }
    
    if (grounded && vsp >= 0)
    {
        fmod_studio_event_instance_start(sndWallkickLand);
        flash = true;
        xscale = dir;
        if key_attack
        {
            repeat 5
				create_radiating_particle(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_spinningFireParticle);
            movespeed = 12;
            hsp = movespeed * dir;
            state = States.mach3;
            image_index = 0;
            sprite_index = spr_rollgetup;
            fmod_studio_event_instance_start(sndMachStart);
        }
        else
        {
            landAnim = true;
            movespeed = 8;
            hsp = movespeed * dir;
            state = States.normal;
            instance_create(x, y, obj_landcloud);
            event_play_oneshot("event:/SFX/player/step", x, y);
        }
    }
    
    if (sprite_index == spr_wallJumpIntro && sprite_animation_end())
        sprite_index = spr_wallJump;
    if (sprite_index == spr_wallJumpFastFallIntro && sprite_animation_end())
        sprite_index = spr_wallJumpFastFall;
    if !instance_exists(obj_wallkickDust)
        instance_create(x + random_range(-40, 40), y + random_range(-40, 40), obj_wallkickDust);
    
    do_taunt(States.wallkick);
    image_speed = 0.45;
}

