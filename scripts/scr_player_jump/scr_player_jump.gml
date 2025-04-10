function state_player_jump()
{
	move = key_left + key_right;

	if momentum
		hsp = xscale * movespeed;
	else
		hsp = move * movespeed;
	
	scr_conveyorBeltKinematics();
	
	if (move != xscale && momentum && movespeed != 0)
		movespeed = approach(movespeed, 0, 0.1);
	
	if (movespeed <= 0)
		momentum = false;
	
	if ((move == 0 && !momentum) || scr_solid(x + hsp, y))
	{
		movespeed = 0;
		machTwo = 0;
	}
	
	if (move != 0 && movespeed < 7)
		movespeed += 0.5;
	
	if (movespeed > 7)
		movespeed -= 0.1;
	
	if (move == xscale && scr_solid(x + xscale, y))
	{
		var _ledge = false;
		if (vsp < 0)
			_ledge = snap_to_ledge(xscale, 6);
		if !_ledge
			movespeed = 0;
	}
	
	if (dir != xscale)
	{
		machTwo = 0;
		dir = xscale;
		movespeed = 0;
	}
	
	if (move == -xscale)
	{
		machTwo = 0;
		movespeed = 0;
		momentum = false;
	}
	
	landAnim = true;
	
	if (!key_jump2 && !jumpStop && vsp < 0.5 && !stompAnim)
	{
		vsp /= 20;
		jumpStop = true;
	}
	
	ladderBuffer = max(ladderBuffer - 1, 0);
	
	if (scr_solid(x, y - 1) && !jumpStop && jumpAnim)
	{
		vsp = grav;
		jumpStop = true;
	}
	
	if (can_jump && inputBufferJump > 0 && !key_down && (!key_attack || scr_solid(x + xscale, y, true)))
	{
		fmod_studio_event_instance_start(sndJump);
		sprite_index = shotgunAnim ? spr_shotgun_jump : spr_jump;
		image_index = 0;
		instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		});
		stompAnim = false;
		vsp = -11;
		grav = 0.3;
		state = States.jump;
		jumpAnim = true;
		jumpStop = false;
		freefallstart = 0;
		instance_create(x, y, obj_landcloud);
		inputBufferJump = 0;
	}
	
	if (grounded && vsp > 0 && (!key_attack || scr_solid(x + xscale, y, true)))
	{
		inputBufferSecondJump = 0;
		state = States.normal;
		jumpAnim = true;
		jumpStop = false;
		image_index = 0;
		freefallstart = 0;
		instance_create(x, y, obj_landcloud);
		event_play_oneshot("event:/SFX/player/step", x, y);
		doubleJumped = false;
		floatyGrab = 18;
	}
	
	if (global.playerCharacter == Characters.Pizzelle)
	{
		if (vsp > 5)
			fallingAnimation++;
		if (fallingAnimation >= 40 && fallingAnimation < 65)
		{
			sprite_index = spr_player_PZ_freeFall_1;
			if (sprite_index == spr_player_PZ_flinged_up && !instance_exists(obj_candifiedeffect1))
				instance_create(x, y, obj_candifiedeffect1);
		}
		if (fallingAnimation >= 65)
			sprite_index = spr_player_PZ_freeFall_2;
	}
	
	if !stompAnim
	{
		if (jumpAnim && sprite_animation_end())
			jumpAnim = false;
		if !jumpAnim
		{
			var aerial_sprite_transitions = [
				[spr_suplexdashCancel, spr_fall],
				[spr_piledriverJump, spr_fall],
				[spr_jump, spr_fall]
			];
			for (var i = 0; i < array_length(aerial_sprite_transitions); i++)
			{
				if (aerial_sprite_transitions[i][0] == sprite_index)
				{
					sprite_index = aerial_sprite_transitions[i][1];
					break;
				}
			}
		}
	}
	
	if (stompAnim == 1)
	{
		if (sprite_index == spr_stompprep && floor(image_index) == (image_number - 1))
			sprite_index = spr_stomp;
	}
	
	if (move != 0)
		xscale = move;
	
	image_speed = 0.35;
	do_grab(States.jump);
	
	if (grounded && (sprite_index == spr_player_PZ_freeFall_1 || sprite_index == spr_player_PZ_freeFall_2))
	{
		event_play_oneshot("event:/SFX/player/groundpound", x, y);
		with obj_parent_enemy
		{
			if (bbox_in_camera(id, view_camera[0]) && grounded)
			{
				vsp = -7;
				hsp = 0;
			}
		}
		
		camera_shake_add(10, 30);
		image_index = 0;
		sprite_index = spr_player_PZ_freeFall_land;
		state = States.freefallland;
		vsp = 0;
		doubleJumped = false;
	}
	
	do_taunt(States.jump);
	
	if (scr_checkgroundpound() && !key_slap2 && !grounded)
	{
		image_index = 0;
		sprite_index = spr_groundPoundstart;
		vsp = -6;
		freeFallSmash = -14;
		state = States.freefallprep;
	}
	
	if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_PZ_flinged_up_start)
		sprite_index = spr_player_PZ_flinged_up;
	
	if (key_attack && grounded && !scr_solid(x + xscale, y, true) && fallingAnimation < 40)
	{
		machTwo = 0;
		movespeed = max(movespeed, 6);
		sprite_index = spr_mach1;
		jumpAnim = true;
		state = States.mach2;
		image_index = 0;
	}
}
