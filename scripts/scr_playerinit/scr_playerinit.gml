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
		if (state != states.knightpep && (state != states.mach3 || instance_exists(obj_techdiff)) && state != states.ladder && !place_meeting(x, y + 32, obj_vertical_hallway) && !instance_exists(obj_fadeoutTransition) && room != timesuproom && room != rank_room)
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
			
			state = states.normal;
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
		state = states.mach3;
	}
	
	with (obj_achievementTracker)
	{
		if (obj_parent_player.state == states.victory || obj_parent_player.state == states.Sjump || obj_parent_player.state == states.comingoutdoor)
			hitInMinecart = true;
	}
}

function scr_playerstate()
{
	var state_function = undefined;
	
	switch (state)
	{
		case states.normal:
			state_function = state_player_normal;
			break;
		case states.chainsawpogo:
			state_function = state_player_jump;
			break;
		case states.Nhookshot:
			state_function = state_player_run;
			break;
		case states.titlescreen:
			state_function = state_player_titlescreen;
			break;
		case states.slap:
			state_function = state_player_charge;
			break;
		case states.cheesepep:
			state_function = state_player_climbwall;
			break;
		case states.cheeseball:
			state_function = state_player_wallkick;
			break;
		case states.cheesepepstick:
			state_function = state_player_machtumble;
			break;
		case states.pistalaim:
			state_function = state_player_grabdash;
			break;
		case states.handstandjump:
			state_function = state_player_grab;
			break;
		case states.climbwall:
			state_function = state_player_timesup;
			break;
		case states.climbdownwall:
			state_function = state_player_machroll;
			break;
		case states.portal:
			state_function = state_player_swingclub;
			break;
		case states.secondjump:
			state_function = state_player_superslam;
			break;
		case states.chainsawbump:
			state_function = state_player_grind;
			break;
		case states.grind:
			state_function = state_player_hang;
			break;
		case states.gottreasure:
			state_function = state_player_taunt;
			break;
		case states.knightpep:
			state_function = state_player_gameover;
			break;
		case states.knightpepattack:
			state_function = state_player_ceilingCrash;
			break;
		case states.meteorpep:
			state_function = state_player_freefallprep;
			break;
		case states.knightpepslopes:
			state_function = state_player_tackle;
			break;
		case states.bombpep:
			state_function = state_player_slipnslide;
			break;
		case states.grabbing:
			state_function = state_player_ladder;
			break;
		case states.shotgunjump:
			state_function = state_player_victory;
			break;
		case states.stunned:
			state_function = state_player_comingoutdoor;
			break;
		case states.highjump:
			state_function = state_player_Sjump;
			break;
		case states.chainsaw:
			state_function = state_player_Sjumpprep;
			break;
		case states.facestomp:
			state_function = state_player_crouch;
			break;
		case states.timesup:
			state_function = state_player_crouchjump;
			break;
		case states.machroll:
			state_function = state_player_mach1;
			break;
		case states.pistol:
			state_function = state_player_mach2;
			break;
		case states.shotgun:
			state_function = state_player_mach3;
			break;
		case states.machfreefall:
			state_function = state_player_machslide;
			break;
		case states.throwing:
			state_function = state_player_bump;
			break;
		case states.superslam:
			state_function = state_player_hurt;
			break;
		case states.slam:
			state_function = state_player_freefall;
			break;
		case states.skateboard:
			state_function = state_player_freefallland;
			break;
		case states.grab:
			state_function = state_player_door;
			break;
		case states.punch:
			state_function = state_player_doughmount;
			break;
		case states.backkick:
			state_function = state_player_doughmountspin;
			break;
		case states.shoulder:
			state_function = state_player_doughmountballoon;
			break;
		case states.backbreaker:
			state_function = state_player_doughmountpancake;
			break;
		case states.boulder:
			state_function = state_player_gotkey;
			break;
		case states.bossdefeat:
			state_function = state_player_finishingblow;
			break;
		case states.bossintro:
			state_function = state_player_cotton;
			break;
		case states.ufofloat:
			state_function = state_player_uppercut;
			break;
		case states.ufodash:
			state_function = state_player_pal;
			break;
		case states.pizzathrow:
			state_function = state_player_shocked;
			break;
		case states.hurt:
			state_function = state_player_rocketlauncher;
			break;
		case states.gameover:
			state_function = state_player_parry;
			break;
		case states.runonball:
			state_function = state_player_tumble;
			break;
		case states.Sjumpland:
			state_function = state_player_talkto;
			break;
		case states.freefallprep:
			state_function = state_player_puddle;
			break;
		case states.keyget:
			state_function = state_player_cottondrill;
			break;
		case states.tackle:
			state_function = state_player_cottonroll;
			break;
		case states.slipnslide:
			state_function = state_player_cottondig;
			break;
		case states.ladder:
			state_function = state_player_fling;
			break;
		case states.jump:
			state_function = state_player_breakdance;
			break;
		case states.victory:
			state_function = state_player_minecart;
			break;
		case states.Sjump:
			state_function = state_player_minecart_bump;
			break;
		case states.comingoutdoor:
			state_function = state_player_minecart_launched;
			break;
		case states.crouchslide:
			state_function = state_player_fireass;
			break;
		case states.mach1:
			state_function = state_player_fireassdash;
			break;
		case states.Sjumpprep:
			state_function = state_player_squished;
			break;
		case states.crouch:
			state_function = state_player_machtumble;
			break;
		case states.crouchjump:
			state_function = state_player_dodgetumble;
			break;
		case states.mach2:
			state_function = state_player_geyser;
			break;
		case states.mach3:
			state_function = state_player_actor;
			break;
		case states.bump:
			state_function = state_player_changing;
			break;
		case states.machslide:
			state_function = state_player_donothing;
			break;
		case states.barrelroll:
			state_function = state_player_drown;
			break;
		case states.frozen:
			state_function = state_player_frozen;
			break;
		case states.freefallland:
			state_function = state_player_trick;
			break;
		case states.hang:
			state_function = state_player_noclip;
			break;
		case states.door:
			state_function = state_player_costumenormal;
			break;
		case states.barrelnormal:
			state_function = state_player_costumegrab;
			break;
		case states.barrelmach1:
			state_function = state_player_costumechuck;
			break;
		case states.barrelfall:
			state_function = state_player_costumebreeze;
			break;
		case states.barrelmach2:
			state_function = state_player_bottlerocket;
			break;
		case states.cotton:
			state_function = state_player_frostburnnormal;
			break;
		case states.uppercut:
			state_function = state_player_frostburnslide;
			break;
		case states.pal:
			state_function = state_player_frostburnjump;
			break;
		case states.shocked:
			state_function = state_player_frostburnstick;
			break;
		case states.bushdisguise:
			state_function = state_player_supergrab;
			break;
		case states.uppunch:
			state_function = state_player_doughmountjump;
			break;
		case states.parry:
			state_function = state_player_fling_launch;
			break;
		case states.talkto:
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
	return global.playerCharacter == characters.PZ;
}
