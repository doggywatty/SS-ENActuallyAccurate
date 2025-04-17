if (place_meeting(x, y, obj_parent_player))
{
    with obj_parent_player
    {
        if (place_meeting(x, y, other))
        {
            if (state != States.noclip && state != States.drown && !global.freezeframe)
            {
                if (vsp >= 0)
                {
                    if (!instance_exists(obj_techdiff))
                    {
                        if (state == States.cotton || state == States.cottondrill)
                            instance_create(x, y, obj_poofeffect);
                        
                        scr_playerrespawn(true, true);
                        event_play_oneshot("event:/SFX/general/watersplash", x, y);
                        state = States.actor;
                        vsp = 10;
                        image_index = 10;
                        sprite_index = spr_drown;
                    }
                    else
                    {
                        sprite_index = spr_drown;
                        hsp = approach(hsp, 0, 1);
                        vsp -= grav;
                        vsp = approach(vsp, 0, 0.5);
                        image_speed = 0.35;
                        state = States.actor;
                    }
                    
                    wetTimer = approach(wetTimer, wetTimerMax, 15);
                }
            }
        }
    }
}

