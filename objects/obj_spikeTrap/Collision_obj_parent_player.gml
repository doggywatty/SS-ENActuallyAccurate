if (sprite_index == spr_spikeTrap_extend)
{
	scr_hurtplayer(other.id);
}
else if (sprite_index == spr_spikeTrap)
{
	image_index = 0;
	sprite_index = spr_spikeTrap_extending;
}
