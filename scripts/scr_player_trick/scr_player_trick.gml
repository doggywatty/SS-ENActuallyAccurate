function state_player_trick()
{
	hsp = movespeed * xscale;
	if (sprite_index != spr_player_PZ_trick_intro && sprite_index != spr_player_PZ_trick)
	{
		sprite_index = spr_player_PZ_trick_intro;
		image_index = 0;
	}
	else if (sprite_animation_end() && sprite_index == spr_player_PZ_trick_intro)
		sprite_index = spr_player_PZ_trick;
	
	if (key_attack && (!grounded || slopeCheck(x + xscale, y)) && scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles) && global.playerCharacter == Characters.Pizzelle)
	{
		verticalMovespeed = movespeed;
		if (vsp > 0 && place_meeting(x + xscale, y, obj_icyWall))
			verticalMovespeed -= vsp;
		grabClimbBuffer = 0;
		state = States.climbwall;
	}
	else if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		var _ledge = snap_to_ledge();
		if !_ledge
		{
			state = States.bump;
			image_index = 0;
			sprite_index = spr_splat;
			event_play_oneshot("event:/SFX/player/splat", x, y);
		}
	}
	if grounded
	{
		fmod_studio_event_instance_start(sndRollGetUp);
		image_index = 0;
		sprite_index = spr_rollgetup;
		state = States.mach3;
	}
	
	image_speed = 0.5;
	if (image_index >= 11 && image_index < 12)
		image_speed = 0;
}
