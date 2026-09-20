function scr_player_changeCharacter(arg0 = obj_player1, arg1, arg2 = false)
{
	with (arg0)
	{
		previousCharacter = global.playerCharacter;
		global.playerCharacter = arg1;
		
		if (!arg2)
			mainPlayerCharacter = arg1;
		
		scr_characterSprite();
	}
}

function scr_playerrespawn(arg0 = true, arg1 = false)
{
	if (!arg0)
	{
		if (state != PlayerState.gameover && (state != PlayerState.actor || instance_exists(obj_techdiff)) && state != PlayerState.fling && !place_meeting(x, y + 32, obj_vertical_hallway) && !instance_exists(obj_fadeoutTransition) && room != timesuproom && room != rank_room)
		{
			var _checkpoint = instance_nearest(x, y, obj_checkpoint_invis);
			var _checkpointReal = -4;
			
			with (obj_checkpoint)
			{
				if (Checkpointactivated)
					_checkpointReal = id;
			}
			
			if (instance_exists(_checkpoint) && _checkpoint.Checkpointactivated)
			{
				x = _checkpoint.x;
				y = _checkpoint.y;
				instance_create(_checkpoint.x, _checkpoint.y, obj_poofeffect);
			}
			else if (instance_exists(_checkpointReal) && _checkpointReal.Checkpointactivated)
			{
				x = _checkpointReal.x;
				y = _checkpointReal.y;
				instance_create(_checkpointReal.x, _checkpointReal.y, obj_poofeffect);
			}
			else
			{
				x = roomStartX;
				y = roomStartY;
				instance_create(roomStartX, roomStartY, obj_poofeffect);
			}
			
			state = PlayerState.normal;
			alarm[7] = 60;
			hurted = true;
			sprite_index = spr_idle;
		}
	}
	else if (!instance_exists(obj_techdiff))
	{
		if (!arg1)
		{
			event_play_oneshot("event:/SFX/player/groundpound", x, room_height - 100);
			camera_shake_add(3, 3);
			hsp = 0;
			vsp = 0;
		}
		
		instance_create(x, y, obj_techdiff, 
		{
			drowned: arg1
		});
		state = PlayerState.actor;
	}
	
	with (obj_achievementTracker)
	{
		if (obj_parent_player.state == PlayerState.minecart || obj_parent_player.state == PlayerState.minecart_bump || obj_parent_player.state == PlayerState.minecart_launched)
			hitInMinecart = true;
	}
}

function scr_playerstate()
{
	var state_function = undefined;
	
	switch (state)
	{
		case PlayerState.normal:
			state_function = state_player_normal;
			break;
		case PlayerState.jump:
			state_function = state_player_jump;
			break;
		case PlayerState.run:
			state_function = state_player_run;
			break;
		case PlayerState.titlescreen:
			state_function = state_player_titlescreen;
			break;
		case PlayerState.charge:
			state_function = state_player_charge;
			break;
		case PlayerState.climbwall:
			state_function = state_player_climbwall;
			break;
		case PlayerState.wallkick:
			state_function = state_player_wallkick;
			break;
		case PlayerState.machtumble:
			state_function = state_player_machtumble;
			break;
		case PlayerState.grabdash:
			state_function = state_player_grabdash;
			break;
		case PlayerState.grab:
			state_function = state_player_grab;
			break;
		case PlayerState.timesup:
			state_function = state_player_timesup;
			break;
		case PlayerState.machroll:
			state_function = state_player_machroll;
			break;
		case PlayerState.swingclub:
			state_function = state_player_swingclub;
			break;
		case PlayerState.superslam:
			state_function = state_player_superslam;
			break;
		case PlayerState.grind:
			state_function = state_player_grind;
			break;
		case PlayerState.hang:
			state_function = state_player_hang;
			break;
		case PlayerState.taunt:
			state_function = state_player_taunt;
			break;
		case PlayerState.gameover:
			state_function = state_player_gameover;
			break;
		case PlayerState.ceilingCrash:
			state_function = state_player_ceilingCrash;
			break;
		case PlayerState.freefallprep:
			state_function = state_player_freefallprep;
			break;
		case PlayerState.tackle:
			state_function = state_player_tackle;
			break;
		case PlayerState.slipnslide:
			state_function = state_player_slipnslide;
			break;
		case PlayerState.ladder:
			state_function = state_player_ladder;
			break;
		case PlayerState.victory:
			state_function = state_player_victory;
			break;
		case PlayerState.comingoutdoor:
			state_function = state_player_comingoutdoor;
			break;
		case PlayerState.Sjump:
			state_function = state_player_Sjump;
			break;
		case PlayerState.Sjumpprep:
			state_function = state_player_Sjumpprep;
			break;
		case PlayerState.crouch:
			state_function = state_player_crouch;
			break;
		case PlayerState.crouchjump:
			state_function = state_player_crouchjump;
			break;
		case PlayerState.mach1:
			state_function = state_player_mach1;
			break;
		case PlayerState.mach2:
			state_function = state_player_mach2;
			break;
		case PlayerState.mach3:
			state_function = state_player_mach3;
			break;
		case PlayerState.machslide:
			state_function = state_player_machslide;
			break;
		case PlayerState.bump:
			state_function = state_player_bump;
			break;
		case PlayerState.hurt:
			state_function = state_player_hurt;
			break;
		case PlayerState.freefall:
			state_function = state_player_freefall;
			break;
		case PlayerState.freefallland:
			state_function = state_player_freefallland;
			break;
		case PlayerState.door:
			state_function = state_player_door;
			break;
		case PlayerState.doughmount:
			state_function = state_player_doughmount;
			break;
		case PlayerState.doughmountspin:
			state_function = state_player_doughmountspin;
			break;
		case PlayerState.doughmountballoon:
			state_function = state_player_doughmountballoon;
			break;
		case PlayerState.doughmountpancake:
			state_function = state_player_doughmountpancake;
			break;
		case PlayerState.gotkey:
			state_function = state_player_gotkey;
			break;
		case PlayerState.finishingblow:
			state_function = state_player_finishingblow;
			break;
		case PlayerState.cotton:
			state_function = state_player_cotton;
			break;
		case PlayerState.uppercut:
			state_function = state_player_uppercut;
			break;
		case PlayerState.pal:
			state_function = state_player_pal;
			break;
		case PlayerState.shocked:
			state_function = state_player_shocked;
			break;
		case PlayerState.rocketlauncher:
			state_function = state_player_rocketlauncher;
			break;
		case PlayerState.parry:
			state_function = state_player_parry;
			break;
		case PlayerState.tumble:
			state_function = state_player_tumble;
			break;
		case PlayerState.talkto:
			state_function = state_player_talkto;
			break;
		case PlayerState.puddle:
			state_function = state_player_puddle;
			break;
		case PlayerState.cottondrill:
			state_function = state_player_cottondrill;
			break;
		case PlayerState.cottonroll:
			state_function = state_player_cottonroll;
			break;
		case PlayerState.cottondig:
			state_function = state_player_cottondig;
			break;
		case PlayerState.fling:
			state_function = state_player_fling;
			break;
		case PlayerState.breakdance:
			state_function = state_player_breakdance;
			break;
		case PlayerState.minecart:
			state_function = state_player_minecart;
			break;
		case PlayerState.minecart_bump:
			state_function = state_player_minecart_bump;
			break;
		case PlayerState.minecart_launched:
			state_function = state_player_minecart_launched;
			break;
		case PlayerState.fireass:
			state_function = state_player_fireass;
			break;
		case PlayerState.fireassdash:
			state_function = state_player_fireassdash;
			break;
		case PlayerState.squished:
			state_function = state_player_squished;
			break;
		case PlayerState.machtumble2:
			state_function = state_player_machtumble;
			break;
		case PlayerState.dodgetumble:
			state_function = state_player_dodgetumble;
			break;
		case PlayerState.geyser:
			state_function = state_player_geyser;
			break;
		case PlayerState.actor:
			state_function = state_player_actor;
			break;
		case PlayerState.changing:
			state_function = state_player_changing;
			break;
		case PlayerState.donothing:
			state_function = state_player_donothing;
			break;
		case PlayerState.drown:
			state_function = state_player_drown;
			break;
		case PlayerState.frozen:
			state_function = state_player_frozen;
			break;
		case PlayerState.trick:
			state_function = state_player_trick;
			break;
		case PlayerState.noclip:
			state_function = state_player_noclip;
			break;
		case PlayerState.costumenormal:
			state_function = state_player_costumenormal;
			break;
		case PlayerState.costumegrab:
			state_function = state_player_costumegrab;
			break;
		case PlayerState.costumechuck:
			state_function = state_player_costumechuck;
			break;
		case PlayerState.costumebreeze:
			state_function = state_player_costumebreeze;
			break;
		case PlayerState.bottlerocket:
			state_function = state_player_bottlerocket;
			break;
		case PlayerState.frostburnnormal:
			state_function = state_player_frostburnnormal;
			break;
		case PlayerState.frostburnslide:
			state_function = state_player_frostburnslide;
			break;
		case PlayerState.frostburnjump:
			state_function = state_player_frostburnjump;
			break;
		case PlayerState.frostburnstick:
			state_function = state_player_frostburnstick;
			break;
		case PlayerState.supergrab:
			state_function = state_player_supergrab;
			break;
		case PlayerState.doughmountjump:
			state_function = state_player_doughmountjump;
			break;
		case PlayerState.fling_launch:
			state_function = state_player_fling_launch;
			break;
		case PlayerState.freeflight:
			state_function = state_player_freeflight;
			break;
	}
	
	stateName = $"State : {state}";
	
	if (!is_undefined(state_function))
	{
		state_function();
		
		if (global.DebugMode)
			stateName = "PlayerState." + string_extract(script_get_name(state_function), "_", 1) + string_extract(script_get_name(state_function), "_", 3);
	}
}

function scr_isMainCharacter()
{
	return global.playerCharacter == PlayerCharacter.PIZZELLE;
}
