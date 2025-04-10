function state_player_crouch()
{
	var room_to_jump = !(place_meeting_solid(x, y - 16) || place_meeting_solid(x, y - 32));
	move = key_left + key_right;
	hsp = move * movespeed;
	scr_conveyorBeltKinematics();
	mask_index = spr_crouchmask;
	turning = 0;
	movespeed = 4;
	if !grounded && !key_jump
	{
		jumpAnim = false;
		state = States.crouchjump;
		movespeed = 4;
		crouchAnim = true;
		image_index = 0;
	}
	if (key_jump && grounded && room_to_jump)
	{
		fmod_studio_event_instance_start(sndJump);
		vsp = -8;
		state = States.crouchjump;
		movespeed = 4;
		image_index = 0;
		crouchAnim = true;
		jumpAnim = true;
	}
	if (grounded && !key_down && !key_jump && room_to_jump)
	{
		state = States.normal;
		movespeed = 0;
		crouchAnim = true;
		jumpAnim = true;
		image_index = 0;
		mask_index = spr_player_mask;
	}
	if !crouchAnim
	{
		if (move == 0)
			sprite_index = shotgunAnim ? spr_shotgun_duck : spr_crouch;
		else
			sprite_index = spr_crawl;
	}
	if (crouchAnim && move == 0)
	{
		sprite_index = shotgunAnim ? spr_shotgun_goduck : spr_couchstart;
		if (floor(image_index) == (image_number - 1))
			crouchAnim = false;
	}
	if (move != 0)
	{
		xscale = move;
		crouchAnim = false;
	}
	if (inputBufferSlap > 0 && grounded)
	{
		grav = 0.5;
		inputBufferSlap = 0;
		fmod_studio_event_instance_start(sndCrouchslide);
		vsp = 0;
		instance_create(x, y, obj_jumpdust);
		sprite_index = spr_crouchslipintro;
		image_index = 0;
		state = States.machroll;
		with instance_create(x, y, obj_jumpdust)
			image_xscale = other.xscale;
		movespeed = 11;
		crouchSlipBuffer = 25;
		crouchSlipAntiBuffer = 0;
	}
	image_speed = 0.45;
}
