function state_player_machroll()
{
	static afterimage_timer = 2;
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	machTwo = 100;
	machSlideAnim = true;
	move = key_right + key_left;
	if !instance_exists(obj_puffEffect) && grounded
		instance_create(x, y + 43, obj_puffEffect);
	if (grounded && sprite_index != spr_crouchslipintro && sprite_index != spr_crouchslip && sprite_index != spr_crouchslipfall)
	{
		if (mach3Roll <= 0)
			sprite_index = spr_machroll;
		else if (sprite_index != spr_machroll3intro && sprite_index != spr_machroll3 && (sprite_index != spr_machroll || sprite_animation_end()))
		{
			sprite_index = spr_machroll3intro;
			image_index = 0;
		}
	}
	else if (!grounded && sprite_index != spr_dive)
	{
		crouchSlipBuffer = 0;
		sprite_index = spr_dive;
		fmod_studio_event_instance_start(sndDive);
		vsp = 10;
	}
	
	if (sprite_index == spr_crouchslipintro || sprite_index == spr_crouchslip || sprite_index == spr_crouchslipfall)
	{
	}
	
	crouchSlipBuffer = max(crouchSlipBuffer - 1, 0);
	if sprite_animation_end()
	{
		if (sprite_index == spr_crouchslipintro)
			sprite_index = spr_crouchslip;
		if (sprite_index == spr_machroll3intro)
			sprite_index = spr_machroll3;
	}
	
	if (!key_down && grounded && !scr_solid(x + 27, y - 32) && !scr_solid(x - 27, y - 32) && !scr_solid(x, y - 32) && !scr_solid(x, y - 16))
	{
		if (crouchSlipBuffer <= 0 || (sprite_index != spr_crouchslip && sprite_index != spr_crouchslipintro && sprite_index != spr_crouchslipfall))
		{
			crouchSlipBuffer = 0;
			if key_attack
			{
				instance_create(x, y, obj_jumpdust);
				fmod_studio_event_instance_start(sndRollGetUp);
				image_index = 0;
				sprite_index = spr_rollgetup;
				state = (movespeed >= 12) ? States.mach3 : States.mach2;
			}
			else if (movespeed > 6)
			{
				event_play_oneshot("event:/SFX/player/break", x, y);
				sprite_index = spr_machslidestart;
				image_index = 0;
				state = States.machslide;
			}
			else
				state = States.normal;
		}
	}
	
	if (inputBufferJump > 0 && sprite_index == spr_dive && !place_meeting_collision(x, y + vsp))
	{
		inputBufferJump = 0;
		create_particle(x, y, spr_groundPoundClouds);
		state = States.freefall;
		image_index = 0;
		sprite_index = spr_diveBombstart;
		dir = xscale;
		vsp = -6;
		verticalMovespeed = vsp;
		freeFallSmash = 0;
	}
	
	var mach3_check = (movespeed >= 12 && !place_meeting(x + xscale, y, obj_metalblock)) || movespeed < 12;
	if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		state = States.bump;
		image_index = 0;
		sprite_index = spr_splat;
		event_play_oneshot("event:/SFX/player/splat", x, y);
	}
	
	if (sprite_index == spr_crouchslip || sprite_index == spr_crouchslipfall || sprite_index == spr_crouchslipintro || sprite_index == spr_machroll || sprite_index == spr_machroll3 || sprite_index == spr_machroll3intro)
		image_speed = abs(movespeed) / 15;
	else
		image_speed = 0.35;
	if (!instance_exists(obj_chargeEffect) && sprite_index != spr_crouchslip && sprite_index != spr_crouchslipfall && sprite_index != spr_crouchslipintro && sprite_index != spr_dive && movespeed >= 12)
	{
		instance_create(x, y, obj_chargeEffect, 
		{
			playerID: id
		});
	}
	if (!instance_exists(dashCloudID) && grounded)
	{
		dashCloudID = instance_create(x, y, obj_dashCloud, 
		{
			image_xscale: xscale,
			sprite_index: (movespeed >= 8) ? spr_dashcloud2 : spr_dashCloud
		});
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(AfterImageType.plain, xscale))
		{
			gonealpha = 0.8;
			alarm[0] = 1;
			alarm[1] = 60;
		}
		afterimage_timer = 2;
	}
}
