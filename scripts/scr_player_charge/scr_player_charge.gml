function state_player_charge()
{
	static afterimage_timer = 2;
	
	if (windingAnim < 2000)
		windingAnim++;
	
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	movespeed = approach(movespeed, 0, 0.25);
	move = key_right + key_left;
	
	if (!key_jump2 && !jumpStop && vsp < 0.5)
	{
		vsp /= 20;
		jumpStop = true;
	}
	
	if (movespeed <= 2)
	{
		state = PlayerState.grab;
		sprite_index = spr_haulingIdle;
	}
	
	if (grounded && vsp > 0)
		jumpStop = false;
	
	if (inputBufferJump > 0 && can_jump)
	{
		fmod_studio_event_instance_start(sndJump);
		vsp = -11;
		grav = 0.3;
		inputBufferJump = 0;
	}
	
	if (key_down && !grounded)
	{
		sprite_index = spr_piledriver;
		vsp = -6;
		state = PlayerState.superslam;
		image_index = 0;
		image_speed = 0.35;
	}
	
	if (inputBufferSlap > 0 || (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles)))
	{
		sprite_index = spr_swingDingEnd;
		state = PlayerState.finishingblow;
		movespeed *= xscale;
		hsp = movespeed;
		image_index = 0;
		inputBufferSlap = 0;
	}
	
	image_speed = 0.5;
	
	if (!instance_exists(dashCloudID) && grounded)
	{
		dashCloudID = instance_create(x, y, obj_dashCloud, 
		{
			image_xscale: xscale
		});
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(afterimagetypes.basic, xscale, 0))
		{
			image_index = max(other.image_index - 1, 0);
			vanish = true;
			gonealpha = 0.8;
			alarm[0] = 1;
			alarm[1] = 60;
		}
		
		afterimage_timer = 2;
	}
}
