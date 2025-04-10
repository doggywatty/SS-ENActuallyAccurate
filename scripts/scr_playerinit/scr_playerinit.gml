function scr_player_changeCharacter(player = obj_player1, _playerChar, _mainPlayerChar = false)
{
	with player
	{
		previousCharacter = global.playerCharacter;
		global.playerCharacter = _playerChar;
		if !_mainPlayerChar
			mainPlayerCharacter = _playerChar;
		scr_characterSprite();
	}
}

function scr_playerrespawn(player = true, _drowned = false)
{
	if !player
	{
		if (state != States.gameover && (state != States.actor || instance_exists(obj_techdiff)) && state != States.fling && !place_meeting(x, y + 32, obj_vertical_hallway) && !instance_exists(obj_fadeoutTransition) && room != timesuproom && room != rank_room)
		{
			var _checkpoint = instance_nearest(x, y, obj_checkpoint_invis);
			var _checkpointReal = -4;
			with obj_checkpoint
			{
				if Checkpointactivated
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
			
			state = States.normal;
			alarm[7] = 60;
			hurted = true;
			sprite_index = spr_idle;
		}
	}
	else if !instance_exists(obj_techdiff)
	{
		if !_drowned
		{
			event_play_oneshot("event:/SFX/player/groundpound", x, room_height - 100);
			camera_shake_add(3, 3);
			hsp = 0;
			vsp = 0;
		}
		instance_create(x, y, obj_techdiff, 
		{
			drowned: _drowned
		});
		state = States.actor;
	}
	with obj_achievementTracker
		hitInMinecart = true;
}

function scr_playerstate()
{
	var state_function = undefined;
	switch state
	{
		case States.normal:
			state_function = state_player_normal;
			break;
		case States.jump:
			state_function = state_player_jump;
			break;
		case States.run:
			state_function = state_player_run;
			break;
		case States.titlescreen:
			state_function = state_player_titlescreen;
			break;
		case States.charge:
			state_function = state_player_charge;
			break;
		case States.climbwall:
			state_function = state_player_climbwall;
			break;
		case States.wallkick:
			state_function = state_player_wallkick;
			break;
		case States.machtumble:
			state_function = state_player_machtumble;
			break;
		case States.grabdash:
			state_function = state_player_grabdash;
			break;
		case States.grab:
			state_function = state_player_grab;
			break;
		case States.timesup:
			state_function = state_player_timesup;
			break;
		case States.machroll:
			state_function = state_player_machroll;
			break;
		case States.swingclub:
			state_function = state_player_swingclub;
			break;
		case States.superslam:
			state_function = state_player_superslam;
			break;
		case States.grind:
			state_function = state_player_grind;
			break;
		case States.hang:
			state_function = state_player_hang;
			break;
		case States.taunt:
			state_function = state_player_taunt;
			break;
		case States.gameover:
			state_function = state_player_gameover;
			break;
		case States.ceilingCrash:
			state_function = state_player_ceilingCrash;
			break;
		case States.freefallprep:
			state_function = state_player_freefallprep;
			break;
		case States.tackle:
			state_function = state_player_tackle;
			break;
		case States.slipnslide:
			state_function = state_player_slipnslide;
			break;
		case States.ladder:
			state_function = state_player_ladder;
			break;
		case States.victory:
			state_function = state_player_victory;
			break;
		case States.comingoutdoor:
			state_function = state_player_comingoutdoor;
			break;
		case States.Sjump:
			state_function = state_player_Sjump;
			break;
		case States.Sjumpprep:
			state_function = state_player_Sjumpprep;
			break;
		case States.crouch:
			state_function = state_player_crouch;
			break;
		case States.crouchjump:
			state_function = state_player_crouchjump;
			break;
		case States.mach1:
			state_function = state_player_mach1;
			break;
		case States.mach2:
			state_function = state_player_mach2;
			break;
		case States.mach3:
			state_function = state_player_mach3;
			break;
		case States.machslide:
			state_function = state_player_machslide;
			break;
		case States.bump:
			state_function = state_player_bump;
			break;
		case States.hurt:
			state_function = state_player_hurt;
			break;
		case States.freefall:
			state_function = state_player_freefall;
			break;
		case States.freefallland:
			state_function = state_player_freefallland;
			break;
		case States.door:
			state_function = state_player_door;
			break;
		case States.doughmount:
			state_function = state_player_doughmount;
			break;
		case States.doughmountspin:
			state_function = state_player_doughmountspin;
			break;
		case States.doughmountballoon:
			state_function = state_player_doughmountballoon;
			break;
		case States.doughmountpancake:
			state_function = state_player_doughmountpancake;
			break;
		case States.gotkey:
			state_function = state_player_gotkey;
			break;
		case States.finishingblow:
			state_function = state_player_finishingblow;
			break;
		case States.cotton:
			state_function = state_player_cotton;
			break;
		case States.uppercut:
			state_function = state_player_uppercut;
			break;
		case States.pal:
			state_function = state_player_pal;
			break;
		case States.shocked:
			state_function = state_player_shocked;
			break;
		case States.rocketlauncher:
			state_function = state_player_rocketlauncher;
			break;
		case States.parry:
			state_function = state_player_parry;
			break;
		case States.tumble:
			state_function = state_player_tumble;
			break;
		case States.talkto:
			state_function = state_player_talkto;
			break;
		case States.puddle:
			state_function = state_player_puddle;
			break;
		case States.cottondrill:
			state_function = state_player_cottondrill;
			break;
		case States.cottonroll:
			state_function = state_player_cottonroll;
			break;
		case States.cottondig:
			state_function = state_player_cottondig;
			break;
		case States.fling:
			state_function = state_player_fling;
			break;
		case States.breakdance:
			state_function = state_player_breakdance;
			break;
		case States.minecart:
			state_function = state_player_minecart;
			break;
		case States.minecart_bump:
			state_function = state_player_minecart_bump;
			break;
		case States.minecart_launched:
			state_function = state_player_minecart_launched;
			break;
		case States.fireass:
			state_function = state_player_fireass;
			break;
		case States.fireassdash:
			state_function = state_player_fireassdash;
			break;
		case States.squished:
			state_function = state_player_squished;
			break;
		case States.machtumble2:
			state_function = state_player_machtumble;
			break;
		case States.dodgetumble:
			state_function = state_player_dodgetumble;
			break;
		case States.geyser:
			state_function = state_player_geyser;
			break;
		case States.actor:
			state_function = state_player_actor;
			break;
		case States.changing:
			state_function = state_player_changing;
			break;
		case States.donothing:
			state_function = state_player_donothing;
			break;
		case States.drown:
			state_function = state_player_drown;
			break;
		case States.frozen:
			state_function = state_player_frozen;
			break;
		case States.trick:
			state_function = state_player_trick;
			break;
		case States.noclip:
			state_function = state_player_noclip;
			break;
		case States.costumenormal:
			state_function = state_player_costumenormal;
			break;
		case States.costumegrab:
			state_function = state_player_costumegrab;
			break;
		case States.costumechuck:
			state_function = state_player_costumechuck;
			break;
		case States.costumebreeze:
			state_function = state_player_costumebreeze;
			break;
		case States.bottlerocket:
			state_function = state_player_bottlerocket;
			break;
		case States.frostburnnormal:
			state_function = state_player_frostburnnormal;
			break;
		case States.frostburnslide:
			state_function = state_player_frostburnslide;
			break;
		case States.frostburnjump:
			state_function = state_player_frostburnjump;
			break;
		case States.frostburnstick:
			state_function = state_player_frostburnstick;
			break;
		case States.supergrab:
			state_function = state_player_supergrab;
			break;
		case States.doughmountjump:
			state_function = state_player_doughmountjump;
			break;
		case States.fling_launch:
			state_function = state_player_fling_launch;
			break;
		case States.freeflight:
			state_function = state_player_freeflight;
			break;
	}
	stateName = string($"State : {state}");
	if !is_undefined(state_function)
	{
		state_function();
		if global.DebugMode
			stateName = "PlayerState." + string_extract(script_get_name(state_function), "_", 1) + string_extract(script_get_name(state_function), "_", 3);
	}
}

function scr_isMainCharacter()
{
	return global.playerCharacter == Characters.Pizzelle;
}
