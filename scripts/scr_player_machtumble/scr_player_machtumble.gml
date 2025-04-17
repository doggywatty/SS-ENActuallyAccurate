function state_player_machtumble()
{
	static afterimage_timer = 2;
	
	hsp = xscale * movespeed;
	mask_index = spr_crouchmask;
	
	if !grounded
		movespeed = min(movespeed, 11);
	if (movespeed < 11)
		movespeed += 0.5;
	
	if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		var _ledge = snap_to_ledge();
		if !_ledge
		{
			if (state == States.machtumble)
			{
				jumpStop = false;
				xscale *= -1;
				state = States.wallkick;
				fmod_studio_event_instance_start(sndWallkickStart);
				vsp = -14;
				sprite_index = spr_wallJumpIntro;
				movespeed = 4 * xscale;
				hsp = movespeed;
				dir = xscale;
				with instance_create(x, y, obj_jumpdust)
					image_xscale = other.xscale;
				fmod_studio_event_instance_start(sndJump);
			}
			else
			{
				state = States.bump;
				image_index = 0;
				sprite_index = spr_splat;
				event_play_oneshot("event:/SFX/player/splat", x, y);
			}
		}
	}
	if key_down
	{
		if grounded
		{
			grav = 0.5;
			sprite_index = spr_crouchslip;
			state = States.machroll;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
			movespeed = 12;
			crouchSlipBuffer = 25;
			crouchSlipAntiBuffer = 0;
		}
		else if (vsp < 6)
			vsp = 6;
	}
	
	if (inputBufferJump > 0 && can_jump)
	{
		if (scr_solid(x, y - 1, true))
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
			if (movespeed < 11)
				movespeed = 11;
		}
		else
		{
			inputBufferJump = 0;
			image_index = 0;
			sprite_index = spr_longJump_intro;
			instance_create(x, y, obj_jumpdust);
			state = States.mach2;
			jumpStop = false;
			vsp = -11;
			grav = 0.3;
			fmod_studio_event_instance_start(sndJump);
			fmod_studio_event_instance_start(sndRollGetUp);
		}
	}
	
	if sprite_animation_end()
	{
		if (scr_solid(x, y - 1, true))
		{
			if (key_attack)
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
				if (movespeed < 11)
					movespeed = 11;
			}
			else
			{
				grav = 0.5;
				inputBufferSlap = 0;
				vsp = 0;
				sprite_index = spr_couchstart;
				image_index = 0;
				state = States.crouch;
			}
		}
		else if key_attack
		{
			state = States.mach2;
			sprite_index = spr_mach2;
		}
		else if (inputBufferSlap > 0)
		{
			fmod_studio_event_instance_start(sndCrouchslide);
			sprite_index = spr_grabDashTumble;
			image_index = 0;
			inputBufferSlap = 0;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
		}
		else
		{
			sprite_index = spr_fall;
			momentum = true;
			state = States.jump;
			jumpStop = true;
		}
	}
	image_speed = 0.35;
	afterimage_timer = max(afterimage_timer - 1, 0);
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(AfterImageType.plain, xscale, 0))
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

function state_player_dodgetumble()
{
	static attack_afterimage_timer = 6;
	
	hsp = (xscale * movespeed) + move;
	if key_down
		vsp = 6;
	else
		vsp = -2 * key_up;
	if (dodgeBuffer > 0)
		dodgeBuffer--;
	if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		var _ledge = 0;
		_ledge -= slope_check_up(x + xscale, y, 32);
		_ledge += slope_check_down(x + xscale, y, 3);
		if (_ledge != 0)
			y += _ledge;
		else
		{
			state = States.bump;
			image_index = 0;
			sprite_index = spr_splat;
			event_play_oneshot("event:/SFX/player/splat", x, y);
		}
	}
	
	if key_down
	{
		if grounded
		{
			grav = 0.5;
			sprite_index = spr_crouchslip;
			state = States.machroll;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
			movespeed = 12;
			crouchSlipBuffer = 25;
			crouchSlipAntiBuffer = 0;
		}
	}
	
	if (inputBufferJump > 0 && can_jump)
	{
		inputBufferJump = 0;
		image_index = 0;
		sprite_index = spr_longJump_intro;
		instance_create(x, y, obj_jumpdust);
		state = States.mach2;
		jumpStop = false;
		vsp = -11;
		grav = 0.3;
	}
	
	if (dodgeBuffer <= 0)
	{
		if key_attack
		{
			state = States.mach2;
			sprite_index = spr_mach2;
		}
		else if (inputBufferSlap > 0)
		{
			fmod_studio_event_instance_start(sndCrouchslide);
			sprite_index = spr_grabDashTumble;
			image_index = 0;
			inputBufferSlap = 0;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
		}
		else
		{
			sprite_index = spr_fall;
			momentum = true;
			state = States.jump;
			jumpStop = true;
		}
	}
	image_speed = 0.35;
	attack_afterimage_timer = max(attack_afterimage_timer - 1, 0);
	if (attack_afterimage_timer <= 0 && vsp <= 0)
	{
		with instance_create(x, y, obj_attackAfterEffect)
			playerID = other.id;
		attack_afterimage_timer = 6;
	}
}
