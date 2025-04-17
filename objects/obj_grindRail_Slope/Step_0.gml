with obj_parent_player
{
    if (state != States.noclip && state != States.cotton && state != States.cottondrill && state != States.cottonroll && state != States.tumble && state != States.taunt && state != States.bump && state != States.actor && state != States.frozen)
    {
        if (place_meeting_slopePlatform(x, y + 1, other) && vsp >= 0 && state != States.grind)
        {
            state = States.grind;
            vsp = 0;
        }
    }
}

