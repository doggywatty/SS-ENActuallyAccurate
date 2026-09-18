with (other)
{
	if (!cutscene && !global.freezeframe && (state != states.gottreasure && state != states.slam && state != states.meteorpep && state != states.skateboard))
	{
		jumpStop = true;
		vsp = -18;
		
		if (state == states.normal || state == states.facestomp || state == states.pistalaim || state == states.machfreefall)
			state = states.chainsawpogo;
		
		if (state == states.cotton || state == states.shocked || state == states.pal)
		{
			image_index = 0;
			sprite_index = spr_player_PZ_frostburn_jump;
			state = states.pal;
		}
		
		if (state == states.cheesepep || state == states.climbdownwall)
			state = states.pistol;
		
		if (state == states.chainsawpogo || state == states.normal)
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
