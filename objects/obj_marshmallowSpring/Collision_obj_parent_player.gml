with other
{
    if (!cutscene && !global.freezeframe && (state != States.taunt && state != States.freefall && state != States.freefallprep && state != States.freefallland))
    {
        jumpStop = true;
        vsp = -18;
        
        if (state == States.normal || state == States.crouch || state == States.grabdash || state == States.machslide)
            state = States.jump;
        
        if (state == States.frostburnnormal || state == States.frostburnstick || state == States.frostburnjump)
        {
            image_index = 0;
            sprite_index = spr_player_PZ_frostburn_jump;
            state = States.frostburnjump;
        }
        
        if (state == States.climbwall || state == States.machroll)
            state = States.mach2;
        
        if (state == States.jump || state == States.normal)
        {
            sprite_index = spr_player_PZ_fall_outOfControl;
            image_index = 0;
        }
        
        with other
        {
            if (sprite_index != spr_marshmallowSpring_active)
                event_play_oneshot("event:/SFX/general/mallowbounce", x, y);
            
            sprite_index = spr_marshmallowSpring_active;
            image_index = 0;
        }
    }
}

