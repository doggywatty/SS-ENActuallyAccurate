with other
{
    if ((state == States.minecart || state == States.minecart_bump)
	&& sprite_index != spr_player_PZ_minecart_turn && sprite_index != spr_player_PZ_minecart_turnidle
	&& other.image_xscale == xscale && !global.freezeframe)
    {
        event_play_oneshot("event:/SFX/general/fredturnstop", x, y);
        x = other.x - (image_xscale * 100);
        movespeed = 0;
        sprite_index = spr_player_PZ_minecart_turn;
        image_index = 0;
        other.sprite_index = spr_fred_turn;
        other.image_index = 0;
        other.vsp = 3;
    }
}

