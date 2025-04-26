if global.freezeframe
    exit;
with other
{
    if (!player_complete_invulnerability() && state != States.cotton && state != States.cottondrill && state != States.door && state != States.cottonroll && state != States.cottondig)
    {
        event_play_oneshot("event:/SFX/cotton/intro", x, y);
        state = States.cotton;
        x = other.x;
        y = other.y + 33;
        flash = 0;
        targetxscale = xscale;
        xscale = 1;
        sprite_index = other.image_xscale ? spr_cottonIntroLeft : spr_cottonIntroRight;
        image_index = 0;
    }
}

