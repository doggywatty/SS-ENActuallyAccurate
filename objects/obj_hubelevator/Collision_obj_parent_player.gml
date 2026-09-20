if (state == PlayerState.frozen && other.state != PlayerState.comingoutdoor && other.hsp == 0 && other.grounded && other.key_up2)
{
	state = PlayerState.normal;
	playerID = other.id;
	other.state = PlayerState.actor;
	other.key_up2 = 0;
	other.movespeed = 0;
	other.hsp = 0;
	other.sprite_index = other.spr_idle;
	other.image_speed = 0.35;
}
