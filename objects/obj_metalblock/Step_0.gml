with (instance_nearest(x, y, obj_parent_player))
{
    if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == States.mach3 || (state == States.run && movespeed >= 12) || state == States.frostburnslide || (state == States.frostburnjump && movespeed > 5) || state == States.puddle || (state == States.machroll && mach3Roll > 0) || state == States.minecart || (state == States.bottlerocket && substate == 0)))
    {
        with other.id
        {
            DestroyedBy = other.id;
            event_user(0);
        }
    }
    
    if ((place_meeting(x + hsp, y, other.id) || place_meeting(x - xscale, y, other.id)) && state == States.unknownrun && movespeed >= 12)
    {
        with other.id
        {
            DestroyedBy = other.id;
            event_user(0);
        }
    }
    
    if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == States.Sjump)
    {
        with other.id
        {
            DestroyedBy = other.id;
            event_user(0);
        }
    }
    
    if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == States.fling_launch)
    {
        with other.id
        {
            DestroyedBy = other.id;
            event_user(0);
        }
    }
    
    if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == States.climbwall && machTwo >= 100)
    {
        with other.id
        {
            DestroyedBy = other.id;
            event_user(0);
        }
    }
    
    if (((place_meeting(x, y + vsp, other.id) && vsp >= 0) || place_meeting(x, y + 1, other.id)) && state == States.freefallland && freeFallSmash > 10)
    {
        with other.id
        {
            DestroyedBy = other.id;
            event_user(0);
        }
    }
}

