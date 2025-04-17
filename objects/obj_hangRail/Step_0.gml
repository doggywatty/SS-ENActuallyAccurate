with obj_parent_player
{
    if (state != States.noclip && state != States.cotton && state != States.cottondrill && state != States.cottonroll && state != States.tumble && state != States.taunt && state != States.bump && state != States.actor && state != States.frozen)
    {
        if (place_meeting(x, y, other) && vsp <= 4 && !grounded && place_meeting_collision(x, y - 16) && y >= other.y && state != States.hang)
        {
            state = States.hang;
            vsp = -16;
        }
    }
}

