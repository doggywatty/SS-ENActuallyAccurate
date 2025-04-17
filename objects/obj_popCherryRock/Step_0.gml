if (global.freezeframe)
    exit;

if (activated == true)
{
    sprite_index = spr_popCherryRock_activated;
    image_speed = 0.85 - ((timer / timerMax) * 0.5);
    timer--;
    
    if (timer <= 0)
        instance_destroy();
    
    exit;
}

with obj_parent_player
{
    if (place_meeting_adjacent(other.id))
        other.activated = true;
}

with obj_parent_enemy
{
    if (place_meeting_adjacent(other.id) && state != States.stun)
        other.activated = true;
}

