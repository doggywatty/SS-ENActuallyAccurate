if global.freezeframe
    exit;
with obj_parent_player
{
    if (place_meeting_adjacent(other.id))
    {
        if scr_hurtplayer(id)
        {
            sprite_index = spr_hurtShock;
            event_play_oneshot("event:/SFX/enemies/thunderhit", x, y);
        }
    }
}
with obj_parent_enemy
{
    if (place_meeting_adjacent(other.id) && state != States.stun)
        instance_destroy();
}

