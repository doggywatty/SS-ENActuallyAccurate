function scr_taunt_storeVariables()
{
	tauntStored = 
	{
		state: (place_meeting(x, y, obj_secretTreasure) && state == PlayerState.taunt) ? PlayerState.normal : state,
		hsp: hsp,
		prevHsp: prevHsp,
		vsp: vsp,
		prevVsp: prevVsp,
		movespeed: movespeed,
		verticalMovespeed: verticalMovespeed,
		conveyorHsp: conveyorHsp,
		sprite_index: sprite_index,
		image_index: image_index
	};
}

function scr_taunt_setVariables()
{
	state = tauntStored.state;
	hsp = tauntStored.hsp;
	prevHsp = tauntStored.prevHsp;
	vsp = tauntStored.vsp;
	prevVsp = tauntStored.prevVsp;
	movespeed = tauntStored.movespeed;
	verticalMovespeed = tauntStored.verticalMovespeed;
	conveyorHsp = tauntStored.conveyorHsp;
	sprite_index = tauntStored.sprite_index;
	image_index = tauntStored.image_index;
}

function do_taunt(arg0 = state)
{
	static superTauntEffect = 0;
	
	if (arg0 != state)
		exit;
	
	if (superTauntCharged && room != rank_room)
	{
		superTauntEffect--;
		
		if (superTauntEffect <= 0)
		{
			instance_create(x + irandom_range(-25, 25), y + irandom_range(-10, 35), obj_superTauntEffect);
			superTauntEffect = 4;
		}
	}
	
	if (key_taunt2)
	{
		tauntTimer = 20;
		scr_taunt_storeVariables();
		state = PlayerState.taunt;
		
		if (superTauntCharged && key_up)
		{
			event_play_oneshot("event:/SFX/player/supertaunt", x, y);
			sprite_index = choose(spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4);
			image_index = 0;
		}
		else if (instance_exists(obj_dogMount) && distance_to_object(obj_dogMount) <= 50)
		{
			sprite_index = spr_petdog;
			image_index = 0;
			
			with (obj_dogMount)
				visible = false;
		}
		else
		{
			if (place_meeting(x, y, obj_exitgate) && global.ComboTime > 0 && global.ExitGateTaunt < 10 && get_panic())
			{
				var val = 25;
				global.Collect += val;
				global.ExitGateTaunt++;
				create_small_number(x, y, string(val));
				create_collect_effect(x, y, spr_taunteffect, val);
				event_play_multiple("event:/SFX/general/collect", x, y);
			}
			
			sprite_index = spr_taunt;
			event_play_oneshot("event:/SFX/player/taunt", x, y);
			image_index = irandom_range(0, sprite_get_number(spr_taunt));
		}
		
		instance_create(x, y, obj_taunteffect);
		
		with (obj_parent_enemy)
		{
			if (point_in_rectangle(x, y, obj_parent_player.x - 480, obj_parent_player.y - 270, obj_parent_player.x + 480, obj_parent_player.y + 270))
				tauntBuffer = true;
		}
		
		with (obj_dartTrap)
		{
			if (point_in_rectangle(x, y, obj_parent_player.x - 480, obj_parent_player.y - 270, obj_parent_player.x + 480, obj_parent_player.y + 270))
				tauntBuffer = true;
		}
		
		return true;
	}
	
	return false;
}

function do_grab(arg0 = state)
{
	if (arg0 != state)
		exit;
	
	if (inputBufferSlap > 0)
	{
		inputBufferSlap = 0;
		
		if (key_up || key_up2)
		{
			do_uppercut();
		}
		else if (global.rocketLauncher || global.tempRocketLauncher)
		{
			state = PlayerState.rocketlauncher;
			image_index = 0;
			global.tempRocketLauncher = false;
			
			with (instance_create(x, y, obj_rocket))
			{
				image_xscale = other.xscale;
				frog = true;
			}
		}
		else if (global.Donutfollow)
		{
			if (!instance_exists(obj_donurang))
			{
				with (instance_create(x + (8 * sign(xscale)), y + 16, obj_donurang))
				{
					throwbuffer = 12;
					var _hspcarry = other.hsp + (other.xscale * 28);
					hsp = clamp(hsp, min(_hspcarry, 28 * other.xscale), max(_hspcarry, 28 * other.xscale));
					image_xscale = 2 * sign(other.xscale);
					image_yscale = 2;
					player = other.id;
				}
			}
			else
			{
				with (obj_donurang)
				{
					if (player == other.id)
						hurry = 3;
				}
			}
		}
		else if (global.playerCharacter == PlayerCharacter.PIZZELLE && sprite_index != spr_player_PZ_suplexDash_bump)
		{
			if (floatyGrab > 0)
			{
				instance_create(x, y, obj_crazyRunHoopEffect, 
				{
					playerID: id
				});
				sprite_index = spr_suplexdashIntro;
			}
			else
			{
				sprite_index = spr_suplexdashFallIntro;
			}
			
			instance_create(x, y, obj_slaphitbox);
			flash = (floatyGrab > 0) ? true : false;
			vsp = 0;
			instance_create(x, y, obj_jumpdust);
			image_index = 0;
			
			if (state == PlayerState.normal || state == PlayerState.jump)
				movespeed = 8;
			else
				movespeed = max(movespeed, 5);
			
			state = PlayerState.grabdash;
			fmod_studio_event_instance_start(sndSuplex);
			
			if (key_down)
			{
				vsp = max(vsp, 6);
				floatyGrab = 0;
				
				if (grounded)
				{
					grav = 0.5;
					sprite_index = spr_crouchslipintro;
					image_index = 0;
					fmod_studio_event_instance_start(sndCrouchslide);
					state = PlayerState.machroll;
					
					with (instance_create(x, y, obj_jumpdust))
						image_xscale = other.xscale;
					
					movespeed = 11;
					crouchSlipBuffer = 25;
					crouchSlipAntiBuffer = 0;
				}
			}
		}
		
		return true;
	}
	
	return false;
}

function do_uppercut()
{
	dir = xscale;
	movespeed = hsp;
	vsp = grounded ? -14 : -10;
	grav = 0;
	state = PlayerState.uppercut;
	flash = false;
	sprite_index = spr_uppercutbegin;
	image_index = 0;
	event_play_oneshot("event:/SFX/player/uppercut", x, y);
	
	with (instance_create(x, y, obj_puffEffect))
		sprite_index = spr_highJumpCloud1;
}

function do_clubswing()
{
	state = PlayerState.swingclub;
	sprite_index = spr_suplexdashIntro;
	image_index = 0;
	
	with (instance_create(x, y, obj_swinghitbox, 
	{
		playerID: id
	}))
		image_xscale = other.xscale;
}

function get_nearestPlayer(arg0 = x, arg1 = y)
{
	return global.coopGame ? instance_nearest(arg0, arg1, obj_parent_player) : obj_player1;
}

function get_primaryPlayer()
{
	return global.coopGame ? obj_player1 : obj_player1;
}

function get_playerState(arg0 = get_primaryPlayer())
{
	return global.freezeframe ? arg0.frozenState : arg0.state;
}

function bump_wall(arg0 = hsp)
{
	return (place_meeting_solid(x + arg0, y) || scr_solid_slope(x + arg0, y)) && (!scr_slope() || place_meeting_solid(x + sign(arg0), y - 16));
}

function snap_to_ledge(arg0 = xscale, arg1 = 32)
{
	var _ledge = false;
	var _y = y;
	
	if (!place_meeting_collision(x + arg0, y - arg1))
	{
		_ledge = true;
		x += arg0;
		
		while (place_meeting_collision(x, y))
			y--;
		
		with (obj_camera)
			cameraYOffset = _y - other.y;
	}
	
	return _ledge;
}
