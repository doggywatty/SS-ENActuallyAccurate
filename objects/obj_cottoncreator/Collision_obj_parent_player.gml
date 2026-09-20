if (global.freezeframe)
	exit;

with (other)
{
	if (!player_complete_invulnerability() && state != PlayerState.cotton && state != PlayerState.cottondrill && state != PlayerState.door && state != PlayerState.cottonroll && state != PlayerState.cottondig)
	{
		event_play_oneshot("event:/SFX/cotton/intro", x, y);
		state = PlayerState.cotton;
		x = other.x;
		y = other.y + 33;
		flash = 0;
		targetxscale = xscale;
		xscale = 1;
		sprite_index = other.image_xscale ? spr_cottonIntroLeft : spr_cottonIntroRight;
		image_index = 0;
	}
}
