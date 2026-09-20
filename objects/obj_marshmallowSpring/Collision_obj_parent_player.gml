with (other)
{
	if (!cutscene && !global.freezeframe && (state != PlayerState.taunt && state != PlayerState.freefall && state != PlayerState.freefallprep && state != PlayerState.freefallland))
	{
		jumpStop = true;
		vsp = -18;
		
		if (state == PlayerState.normal || state == PlayerState.crouch || state == PlayerState.grabdash || state == PlayerState.machslide)
			state = PlayerState.jump;
		
		if (state == PlayerState.frostburnnormal || state == PlayerState.frostburnstick || state == PlayerState.frostburnjump)
		{
			image_index = 0;
			sprite_index = spr_player_PZ_frostburn_jump;
			state = PlayerState.frostburnjump;
		}
		
		if (state == PlayerState.climbwall || state == PlayerState.machroll)
			state = PlayerState.mach2;
		
		if (state == PlayerState.jump || state == PlayerState.normal)
		{
			sprite_index = spr_player_PZ_fall_outOfControl;
			image_index = 0;
		}
		
		with (other)
		{
			if (sprite_index != spr_marshmallowSpring_active)
				event_play_oneshot("event:/SFX/general/mallowbounce", x, y);
			
			sprite_index = spr_marshmallowSpring_active;
			image_index = 0;
		}
	}
}
