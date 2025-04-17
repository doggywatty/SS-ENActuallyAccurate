with obj_parent_player
{
    if (state != States.Sjump && state != States.freefall)
    {
        event_play_oneshot("event:/SFX/general/superspring", x, y);
        other.image_index = 0;
        other.image_speed = 0.35;
        hsp = 0;
        if (other.image_yscale == 1)
        {
            sprite_index = spr_superspring;
            state = States.Sjump;
            vsp = -12;
            verticalMovespeed = vsp;
            freeFallSmash = 0;
            create_particle(other.x, other.y - 80, spr_bangEffect);
        }
        else
        {
            state = States.freefall;
            movespeed = 0;
            vsp = 10;
            freeFallSmash = 0;
            sprite_index = spr_player_PZ_fall_outOfControl;
            create_particle(other.x, other.y + 80, spr_bangEffect);
        }
        x = other.x;
    }
}

