if (global.freezeframe)
	exit;

with (other)
{
	if (!player_complete_invulnerability() && state != states.bossintro && state != states.keyget && state != states.grab && state != states.tackle && state != states.slipnslide)
	{
		event_play_oneshot("event:/SFX/cotton/intro", x, y);
		state = states.bossintro;
		x = other.x;
		y = other.y + 33;
		flash = 0;
		targetxscale = xscale;
		xscale = 1;
		sprite_index = other.image_xscale ? spr_cottonIntroLeft : spr_cottonIntroRight;
		image_index = 0;
	}
}
