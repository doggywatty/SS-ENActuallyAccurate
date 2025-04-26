function state_player_mach2()
{
	windingAnim = min(windingAnim + 1, 2000);
	machTwo = 35;
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	move = key_right + key_left;
	move2 = key_right2 + key_left2;
	
	if (!key_jump2 && !jumpStop && vsp < 0.5)
	{
		vsp /= 20;
		jumpStop = true;
	}
	if (grounded && vsp > 0)
		jumpStop = false;
	if (inputBufferJump > 0 && can_jump)
	{
		if (global.playerCharacter == Characters.Pizzelle && move != -xscale && key_attack)
		{
			image_index = 0;
			sprite_index = spr_airdash1;
			if (movespeed >= 8)
				sprite_index = spr_secondjump1;
		}
		inputBufferJump = 0;
		fmod_studio_event_instance_start(sndJump);
		vsp = -11;
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
	}
	
	var mach_sprite = (movespeed >= 8) ? spr_mach2 : spr_mach1;
	var mach_jumpsprite = (movespeed >= 8) ? spr_secondjump1 : spr_airdash1;
	if grounded
	{
		if (sprite_index != mach_sprite && sprite_index != spr_mach3player)
		{
			if (sprite_index != spr_rollgetup)
				sprite_index = mach_sprite;
		}
	}
	
	if !grounded
		machPunchAnim = false;
	if grounded
	{
		if (slopeCheck(x, y) && hsp != 0 && movespeed > 8)
			player_slopeMomentum(0.1, 0);
		if (movespeed < 12)
			movespeed += 0.1;
		if (abs(hsp) >= 12)
		{
			movespeed = max(movespeed, 12);
			state = States.mach3;
			flash = true;
			if (sprite_index != spr_rollgetup && sprite_index != spr_mach3hit)
				sprite_index = spr_mach3player;
			fmod_studio_event_instance_start(sndMachStart);
			instance_create(x, y, obj_jumpdust, 
			{
				playerID: id
			});
		}
	}
	
	if (movespeed >= 8)
	{
		if (grounded && vsp >= 0)
		{
			if !key_attack
			{
				event_play_oneshot("event:/SFX/player/break", x, y);
				sprite_index = spr_machslidestart;
				image_index = 0;
				state = States.machslide;
			}
			if (move == -xscale)
			{
				event_play_oneshot("event:/SFX/player/machslideboost", x, y);
				sprite_index = spr_machslideboost;
				image_index = 0;
				state = States.machslide;
			}
		}
	}
	else if (movespeed < 8 && (grounded && vsp >= 0))
	{
		if !key_attack
			state = States.normal;
		if (move == -xscale)
		{
			xscale *= -1;
			movespeed = 6;
		}
	}
	
	if (key_down && !key_slap2 && !place_meeting(x, y, obj_dashpad))
	{
		flash = false;
		state = States.machroll;
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
		image_index = 0;
		sprite_index = spr_machroll;
		if !grounded
		{
			sprite_index = spr_dive;
			fmod_studio_event_instance_start(sndDive);
		}
		vsp = 10;
	}
	
	if (bump_wall(xscale) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		if !grounded || slopeCheck(x + xscale, y)
		{
			verticalMovespeed = movespeed;
			if (vsp > 0 && place_meeting(x + xscale, y, obj_icyWall))
				verticalMovespeed -= vsp;
			grabClimbBuffer = 0;
			state = States.climbwall;
		}
		else
		{
			var _ledge = snap_to_ledge();
			if !_ledge
			{
				state = States.bump;
				image_index = 0;
				sprite_index = spr_splat;
				event_play_oneshot("event:/SFX/player/splat", x, y);
				movespeed = 0;
			}
		}
	}
	
	if ((!grounded || slopeCheck(x + xscale, y)) && scr_solid(x + xscale, y, true) && global.playerCharacter == Characters.Pizzelle)
	{
	}
	else if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
	}
	
	if (!instance_exists(dashCloudID) && grounded)
	{
		dashCloudID = instance_create(x, y, obj_dashCloud, 
		{
			image_xscale: xscale,
			sprite_index: (movespeed >= 8) ? spr_dashcloud2 : spr_dashCloud
		});
	}
	if (!grounded && sprite_index != spr_wallJumpCancelIntro && sprite_index != spr_wallJumpCancel && sprite_index != spr_airdash2 && sprite_index != spr_secondjump2 && sprite_index != spr_mach2_spinJump && sprite_index != spr_longJump_intro && sprite_index != spr_longJump && sprite_index != spr_player_PZ_bumped)
		sprite_index = mach_jumpsprite;
	if sprite_animation_end()
	{
		if (sprite_index == spr_wallJumpCancelIntro)
			sprite_index = spr_wallJumpCancel;
		if (sprite_index == spr_secondjump1)
			sprite_index = spr_secondjump2;
		if (sprite_index == spr_airdash1)
			sprite_index = spr_airdash2;
	}
	
	if (grounded && sprite_animation_end() && sprite_index == spr_rollgetup)
		sprite_index = spr_mach2;
	if (sprite_animation_end() && sprite_index == spr_longJump_intro)
		sprite_index = spr_longJump;
	
	do_grab(States.mach2);
	do_taunt(States.mach2);
	
	if (sprite_index == spr_rollgetup || sprite_index == spr_longJump_intro || sprite_index == spr_longJump)
		image_speed = 0.4;
	else if (sprite_index == spr_wallJumpCancelIntro)
		image_speed = 0.35;
	else
		image_speed = abs(movespeed) / 15;
	
	if grounded
	{
		upsideDownJump = false;
		floatyGrab = 18;
	}
}
