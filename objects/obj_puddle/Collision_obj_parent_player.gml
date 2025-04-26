if (sprite_index == spr_juicepuddledone && other.grounded)
{
	if (player_complete_invulnerability(other.id))
		exit;
	with other
	{
		var old_mask = mask_index;
		mask_index = spr_player_mask;
		if (place_meeting_collision(x, y))
		{
			mask_index = old_mask;
			exit;
		}
		mask_index = old_mask;
		image_index = 0;
		image_speed = 0.35;
		sprite_index = spr_player_PZ_slipSlide_intro;
		state = States.puddle;
		vsp = -11;
		grounded = 0;
	}
	
	with obj_achievementTracker
		constructHasSlipped = true;
	
	event_play_oneshot("event:/SFX/player/slip", x, y);
	slipped = 1;
	
	with (instance_create(x, y, obj_baddieDead))
	{
		vsp = random_range(-7, -10);
		hsp = random_range(5, 10) * other.image_xscale;
		canrotate = false;
		sprite_index = spr_iceblock_puddle;
		image_speed = 0;
	}
	
	if !perma
	{
		image_xscale = other.image_xscale;
		instance_destroy();
	}
	else
		alarm[0] = 60;
}