function state_player_drown()
{
	wetTimer = approach(wetTimer, wetTimerMax, 15);
	cutscene = true;
	hsp = 0;
	vsp = 0;
	
	if (sprite_animation_end())
		image_index = image_number - 1;
	
	image_speed = 0.35;
}
