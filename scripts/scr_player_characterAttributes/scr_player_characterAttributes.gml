function scr_getCharacterPrefix(_char_prefix)
{
	var character_prefix = ["PZ"];
	return character_prefix[_char_prefix];
}

function scr_getCharacterSprite(_sprite, _spr_index = "spr_player_", _char = global.playerCharacter)
{
	var prefix_length = string_length(_spr_index);
	var sprite_name = string_delete(sprite_get_name(_sprite), 1, prefix_length + 3);
	var asset_string = $"{_spr_index}{scr_getCharacterPrefix(_char)}_{sprite_name}";
	
	if (asset_get_index(asset_string) <= -1)
	{
		if global.DebugVisuals
			show_debug_message($"'{asset_string}' cannot be found. Using '{sprite_get_name(_sprite)}'.");
		return _sprite;
	}
	
	if global.DebugVisuals
		show_debug_message($"'{asset_string}' found.");
	
	return asset_get_index(asset_string);
}

function scr_getCharacterTVSprite(_sprite, _char = global.playerCharacter)
{
	return scr_getCharacterSprite(_sprite, "spr_tvHUD_player_", _char);
}

function scr_characterSprite()
{
	spr_idle = scr_getCharacterSprite(spr_player_PZ_idle);
	spr_move = scr_getCharacterSprite(spr_player_PZ_walk);
	spr_smallComboIdle = scr_getCharacterSprite(spr_player_PZ_idle_comboSmall);
	spr_bigComboIdle = scr_getCharacterSprite(spr_player_PZ_idle_comboBig);
	spr_smallComboWalk = scr_getCharacterSprite(spr_player_PZ_walk_comboSmall);
	spr_bigComboWalk = scr_getCharacterSprite(spr_player_PZ_walk_comboBig);
	spr_angryidle = scr_getCharacterSprite(spr_player_PZ_idle_supercharged);
	spr_angrywalk = scr_getCharacterSprite(spr_player_PZ_walk_supercharged);
	spr_crawl = scr_getCharacterSprite(spr_player_PZ_crawl);
	spr_jump = scr_getCharacterSprite(spr_player_PZ_jump);
	spr_fall = scr_getCharacterSprite(spr_player_PZ_fall);
	spr_wallJumpIntro = scr_getCharacterSprite(spr_player_PZ_wallJump_intro);
	spr_wallJump = scr_getCharacterSprite(spr_player_PZ_wallJump);
	spr_wallJumpCancelIntro = scr_getCharacterSprite(spr_player_PZ_wallJumpCancel_intro);
	spr_wallJumpCancel = scr_getCharacterSprite(spr_player_PZ_wallJumpCancel);
	spr_wallJumpFastFallIntro = scr_getCharacterSprite(spr_player_PZ_wallJumpFastFall_intro);
	spr_wallJumpFastFall = scr_getCharacterSprite(spr_player_PZ_wallJumpFastFall);
	spr_runskid = scr_getCharacterSprite(spr_player_PZ_skid);
	spr_uppercutbegin = scr_getCharacterSprite(spr_player_PZ_uppercut_intro);
	spr_uppercutend = scr_getCharacterSprite(spr_player_PZ_uppercut_end);
	spr_crouch = scr_getCharacterSprite(spr_player_PZ_crouch);
	spr_crouchjump = scr_getCharacterSprite(spr_player_PZ_crouch_jump);
	spr_crouchfall = scr_getCharacterSprite(spr_player_PZ_crouch_fall);
	spr_couchstart = scr_getCharacterSprite(spr_player_PZ_crouch_intro);
	spr_splat = scr_getCharacterSprite(spr_player_PZ_splat);
	spr_bump = scr_getCharacterSprite(spr_player_PZ_bumped);
	spr_land = scr_getCharacterSprite(spr_player_PZ_land);
	spr_land2 = scr_getCharacterSprite(spr_player_PZ_land_walk);
	spr_lookdoor = scr_getCharacterSprite(spr_player_PZ_enter);
	spr_walkfront = scr_getCharacterSprite(spr_player_PZ_walkFront);
	spr_victory = scr_getCharacterSprite(spr_player_PZ_enter_key);
	spr_Ladder = scr_getCharacterSprite(spr_player_PZ_ladder_idle);
	spr_laddermove = scr_getCharacterSprite(spr_player_PZ_ladder_up);
	spr_ladderdown = scr_getCharacterSprite(spr_player_PZ_ladder_down);
	spr_crouchslip = scr_getCharacterSprite(spr_player_PZ_crouchSlip);
	spr_crouchslipfall = scr_getCharacterSprite(spr_player_PZ_crouchSlip_fall);
	spr_crouchslipintro = scr_getCharacterSprite(spr_player_PZ_crouchSlip_intro);
	spr_slippingonice = scr_getCharacterSprite(spr_player_PZ_slipping);
	spr_mach1 = scr_getCharacterSprite(spr_player_PZ_mach1);
	spr_mach2 = scr_getCharacterSprite(spr_player_PZ_mach2);
	spr_mach3player = scr_getCharacterSprite(spr_player_PZ_mach3);
	spr_mach3hit = scr_getCharacterSprite(spr_player_PZ_mach3_hit);
	spr_longJump_intro = scr_getCharacterSprite(spr_player_PZ_mach2_longJump_intro);
	spr_longJump = scr_getCharacterSprite(spr_player_PZ_mach2_longJump);
	spr_grabDashTumble = scr_getCharacterSprite(spr_player_PZ_suplexTumble);
	spr_machdashpad = scr_getCharacterSprite(spr_player_PZ_mach3_dashPad);
	spr_rollgetup = scr_getCharacterSprite(spr_player_PZ_machRoll_getUp);
	spr_mach3jump = scr_getCharacterSprite(spr_player_PZ_mach3_jump);
	spr_mach3hitwall = scr_getCharacterSprite(spr_player_PZ_hitWall_mach3);
	spr_crazyrun = scr_getCharacterSprite(spr_player_PZ_mach4);
	spr_secondjump1 = scr_getCharacterSprite(spr_player_PZ_mach2_jump);
	spr_secondjump2 = scr_getCharacterSprite(spr_player_PZ_mach2_fall);
	spr_machslidestart = scr_getCharacterSprite(spr_player_PZ_machSkid_intro);
	spr_machslide = scr_getCharacterSprite(spr_player_PZ_machSkid);
	spr_machslideend = scr_getCharacterSprite(spr_player_PZ_machSkid_end);
	spr_machslideboost = scr_getCharacterSprite(spr_player_PZ_mach2_turn);
	spr_machslideboostFallStart = scr_getCharacterSprite(spr_player_PZ_mach2_turnFall_intro);
	spr_machslideboostFall = scr_getCharacterSprite(spr_player_PZ_mach2_turnFall);
	spr_machslideboost3 = scr_getCharacterSprite(spr_player_PZ_mach3_turn);
	spr_machslideboost3FallStart = scr_getCharacterSprite(spr_player_PZ_mach3_turnFall_intro);
	spr_machslideboost3Fall = scr_getCharacterSprite(spr_player_PZ_mach3_turnFall);
	spr_land2 = scr_getCharacterSprite(spr_player_PZ_land_walk);
	spr_stomp = scr_getCharacterSprite(spr_player_PZ_stomp);
	spr_stompprep = scr_getCharacterSprite(spr_player_PZ_stomp_intro);
	spr_crouchslide = scr_getCharacterSprite(spr_player_PZ_crouchSlip);
	spr_crouch = scr_getCharacterSprite(spr_player_PZ_crouch);
	spr_bump = scr_getCharacterSprite(spr_player_PZ_bumped);
	spr_victory = scr_getCharacterSprite(spr_player_PZ_enter_key);
	spr_hurt = scr_getCharacterSprite(spr_player_PZ_stun);
	spr_hurtjump = scr_getCharacterSprite(spr_player_PZ_hurt);
	spr_hurtShock = scr_getCharacterSprite(spr_player_PZ_electrocuted);
	spr_mach2_climbwall = scr_getCharacterSprite(spr_player_PZ_mach2_climbWall);
	spr_mach3_climbwall = scr_getCharacterSprite(spr_player_PZ_mach3_climbWall);
	spr_groundPoundstart = scr_getCharacterSprite(spr_player_PZ_groundPound_intro);
	spr_groundPoundfall = scr_getCharacterSprite(spr_player_PZ_groundPound);
	spr_groundPoundland = scr_getCharacterSprite(spr_player_PZ_groundPound_land);
	spr_groundPoundEnd_intro = scr_getCharacterSprite(spr_player_PZ_groundPoundEnd_intro);
	spr_groundPoundEnd = scr_getCharacterSprite(spr_player_PZ_groundPoundEnd);
	spr_diveBombstart = scr_getCharacterSprite(spr_player_PZ_divebomb_start);
	spr_diveBombfall = scr_getCharacterSprite(spr_player_PZ_divebomb_fall);
	spr_diveBombland = scr_getCharacterSprite(spr_player_PZ_divebomb_land);
	spr_haulingIntro = scr_getCharacterSprite(spr_player_PZ_hauling_intro);
	spr_haulingIdle = scr_getCharacterSprite(spr_player_PZ_hauling_idle);
	spr_haulingWalk = scr_getCharacterSprite(spr_player_PZ_hauling_walk);
	spr_haulingJump = scr_getCharacterSprite(spr_player_PZ_hauling_jump);
	spr_haulingFall = scr_getCharacterSprite(spr_player_PZ_hauling_fall);
	spr_haulingLand = scr_getCharacterSprite(spr_player_PZ_hauling_land);
	spr_superjumpPrep = scr_getCharacterSprite(spr_player_PZ_superJump_prep);
	spr_superjumpPrep_flash = scr_getCharacterSprite(spr_player_PZ_superJump_prep_flash);
	spr_superjumpPrep_left = scr_getCharacterSprite(spr_player_PZ_superJump_prep_left);
	spr_superjumpPrep_right = scr_getCharacterSprite(spr_player_PZ_superJump_prep_right);
	spr_superjump = scr_getCharacterSprite(spr_player_PZ_superJump);
	spr_superjumpLand = scr_getCharacterSprite(spr_player_PZ_superJump_land);
	spr_superspring = scr_getCharacterSprite(spr_player_PZ_superSpring);
	spr_superspringLand = scr_getCharacterSprite(spr_player_PZ_superSpring_land);
	spr_superjumpCancelIntro = scr_getCharacterSprite(spr_player_PZ_superJump_cancel_intro);
	spr_superjumpCancel = scr_getCharacterSprite(spr_player_PZ_superJump_cancel);
	spr_swingDing = scr_getCharacterSprite(spr_player_PZ_swingDing);
	spr_swingDingEnd = scr_getCharacterSprite(spr_player_PZ_swingDing_end);
	spr_climbdownwall = scr_getCharacterSprite(spr_player_PZ_mach2_climbWall);
	spr_mach2_spinJump = scr_getCharacterSprite(spr_player_PZ_mach2_spinJump);
	spr_Timesup = scr_getCharacterSprite(spr_player_PZ_gateSurprise);
	spr_machpunch1 = scr_getCharacterSprite(spr_player_PZ_mach2_hit2);
	spr_machpunch2 = scr_getCharacterSprite(spr_player_PZ_mach2_hit1);
	spr_entergate = scr_getCharacterSprite(spr_player_PZ_enter_gate);
	spr_enterpainting = scr_getCharacterSprite(spr_player_PZ_enter_painting);
	spr_suplexmash1 = scr_getCharacterSprite(spr_player_PZ_finishingBlow_1);
	spr_suplexmash2 = scr_getCharacterSprite(spr_player_PZ_finishingBlow_2);
	spr_suplexmash3 = scr_getCharacterSprite(spr_player_PZ_finishingBlow_3);
	spr_suplexmash4 = scr_getCharacterSprite(spr_player_PZ_finishingBlow_4);
	spr_suplexmashUppercut = scr_getCharacterSprite(spr_player_PZ_finishingBlow_uppercut);
	spr_airdash1 = scr_getCharacterSprite(spr_player_PZ_mach1_jump);
	spr_airdash2 = scr_getCharacterSprite(spr_player_PZ_mach1_fall);
	spr_idle1 = scr_getCharacterSprite(spr_player_PZ_idleAnim_1);
	spr_idle2 = scr_getCharacterSprite(spr_player_PZ_idleAnim_2);
	spr_idle3 = scr_getCharacterSprite(spr_player_PZ_idleAnim_3);
	spr_idle4 = scr_getCharacterSprite(spr_player_PZ_idleAnim_4);
	spr_idle5 = scr_getCharacterSprite(spr_player_PZ_idleAnim_5);
	spr_idle6 = scr_getCharacterSprite(spr_player_PZ_idleAnim_6);
	spr_gotTreasure = scr_getCharacterSprite(spr_player_PZ_gotTreasure);
	spr_parry1 = scr_getCharacterSprite(spr_player_PZ_parry_1);
	spr_parry2 = scr_getCharacterSprite(spr_player_PZ_parry_2);
	spr_parry3 = scr_getCharacterSprite(spr_player_PZ_parry_3);
	spr_supertaunt1 = scr_getCharacterSprite(spr_player_PZ_superTaunt_1);
	spr_supertaunt2 = scr_getCharacterSprite(spr_player_PZ_superTaunt_2);
	spr_supertaunt3 = scr_getCharacterSprite(spr_player_PZ_superTaunt_3);
	spr_supertaunt4 = scr_getCharacterSprite(spr_player_PZ_superTaunt_4);
	spr_suplexdashIntro = scr_getCharacterSprite(spr_player_PZ_suplexDash_intro);
	spr_suplexdashFallIntro = scr_getCharacterSprite(spr_player_PZ_suplexDashFall_intro);
	spr_suplexdashGround = scr_getCharacterSprite(spr_player_PZ_suplexDashGround);
	spr_suplexdashFall = scr_getCharacterSprite(spr_player_PZ_suplexDashFall);
	spr_suplexdashCancel = scr_getCharacterSprite(spr_player_PZ_suplexDash_cancel);
	spr_piledriverIntro = scr_getCharacterSprite(spr_player_PZ_pileDriver_intro);
	spr_piledriver = scr_getCharacterSprite(spr_player_PZ_pileDriver);
	spr_piledriverland = scr_getCharacterSprite(spr_player_PZ_pileDriver_land);
	spr_piledriverJump = scr_getCharacterSprite(spr_player_PZ_pileDriver_jump);
	spr_taunt = scr_getCharacterSprite(spr_player_PZ_tauntStills);
	paletteSprite = spr_null;
	spr_drown = scr_getCharacterSprite(spr_player_PZ_drown);
	spr_uppizzabox = scr_getCharacterSprite(spr_player_PZ_pipeUp_getIn);
	spr_downpizzabox = scr_getCharacterSprite(spr_player_PZ_pipeDown_getIn);
	spr_noclip = scr_getCharacterSprite(spr_player_PZ_noclip);
	spr_tumblestart = scr_getCharacterSprite(spr_player_PZ_tumble_intro);
	spr_tumble = scr_getCharacterSprite(spr_player_PZ_tumble);
	spr_tumbleend = scr_getCharacterSprite(spr_player_PZ_tumble_end);
	spr_taunt = scr_getCharacterSprite(spr_player_PZ_tauntStills);
	spr_machroll = scr_getCharacterSprite(spr_player_PZ_machRoll);
	spr_machroll3intro = scr_getCharacterSprite(spr_player_PZ_machRoll3_intro);
	spr_machroll3 = scr_getCharacterSprite(spr_player_PZ_machRoll3);
	spr_dive = scr_getCharacterSprite(spr_player_PZ_dive);
	spr_cottonIdle = scr_getCharacterSprite(spr_player_PZ_werecotton_idle);
	spr_cottonDashIntro = scr_getCharacterSprite(spr_player_PZ_werecotton_drill_start);
	spr_cottonDashOut = scr_getCharacterSprite(spr_player_PZ_werecotton_drill_outro);
	spr_cottonLand = scr_getCharacterSprite(spr_player_PZ_werecotton_land);
	spr_cottonLandWalk = scr_getCharacterSprite(spr_player_PZ_werecotton_land_walk);
	spr_cottonWalk = scr_getCharacterSprite(spr_player_PZ_werecotton_walk);
	spr_cottonJump = scr_getCharacterSprite(spr_player_PZ_werecotton_jump);
	spr_cottonDoubleJump = scr_getCharacterSprite(spr_player_PZ_werecotton_doubleJump);
	spr_cottonFall = scr_getCharacterSprite(spr_player_PZ_werecotton_fall);
	spr_cottonDoubleJumpFall = scr_getCharacterSprite(spr_player_PZ_werecotton_doubleJump_fall);
	spr_cottonIntroLeft = scr_getCharacterSprite(spr_player_PZ_werecottonintroRight);
	spr_cottonIntroRight = scr_getCharacterSprite(spr_player_PZ_werecottonintroLeft);
	spr_cottonIntroScream = scr_getCharacterSprite(spr_player_PZ_werecottonintroscream);
	spr_escapeidle = scr_getCharacterSprite(spr_player_PZ_idle_escape);
	spr_timesupidle = scr_getCharacterSprite(spr_player_PZ_idle_timesUp);
	spr_petdog = scr_getCharacterSprite(spr_player_PZ_dogMount_pet);
	spr_dogMount_meteor = scr_getCharacterSprite(spr_player_PZ_dogMount_meteor);
	
	scr_characterTVSprite();
	
	var char_arr = [Characters.Pizzelle];
	for (var i = 0; i < array_length(char_arr); i++)
	{
		if (global.playerCharacter == char_arr[i])
		{
			fmod_studio_system_set_parameter_by_name("character", i, true);
			break;
		}
	}
}

function scr_characterTVSprite()
{
	global.TvSprPlayer_Idle = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_idle);
	global.TvSprPlayer_EscapeIdle = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_escapeIdle);
	global.TvSprPlayer_Secret = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_secret);
	global.TvSprPlayer_HighCombo = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_angry);
	global.TvSprPlayer_Combo = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_combo);
	global.TvSprPlayer_Mach1 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_mach1);
	global.TvSprPlayer_Mach2 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_mach2);
	global.TvSprPlayer_Mach3 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_mach3);
	global.TvSprPlayer_Mach4 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_mach4);
	global.TvSprPlayer_MachRoll = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_machRoll);
	global.TvSprPlayer_HighCombo = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_angry);
	global.TvSprPlayer_Crash = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_crash);
	global.TvSprPlayer_IdleAnim1 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_idleAnim_1);
	global.TvSprPlayer_IdleAnim2 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_idleAnim_2);
	global.TvSprPlayer_Hurt = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurt);
	global.TvSprPlayer_HurtExp = [scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_1), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_2), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_3), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_4), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_5), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_6), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_7), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_8), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_9), scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_10)];
	global.TvSprPlayer_EscapeAnim3 = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hurtExp_7);
	global.TvSprPlayer_Happy = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_happy);
	global.TvSprPlayer_KeyGot = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_keyGot);
	global.TvSprPlayer_Ball = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_ball);
	global.TvSprPlayer_WereCotton = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_werecotton);
	global.TvSprPlayer_FireAss = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_fireAss);
	global.TvSprPlayer_Croaked = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_croaked);
	global.TvSprPlayer_Slipping = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_slipping);
	global.TvSprPlayer_FrostBurn = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_frostBurn);
	global.TvSprPlayer_Minecart = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_minecart);
	global.TvSprPlayer_MarshMount = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_marshMount);
	global.TvSprPlayer_Hooked = scr_getCharacterTVSprite(spr_tvHUD_player_PZ_hooked);
}

global.CharacterPalette = [];
global.StupidWorkaroundFixLater = 0;

function define_player_palette(_char = Characters.Pizzelle, _palName, _arr_ind1, _arr_ind2 = _arr_ind1, _arr_ind3 = _arr_ind2, _palTexture = undefined)
{
	var q = [];
	if (array_length(global.CharacterPalette[_char].palettes))
	{
		var _ref = global.CharacterPalette[_char].palettes[0].palColors;
		array_copy(q, 0, _ref, 0, array_length(_ref));
	}
	
	var _def = q;
	var array_index = 0;
	q[array_index++] = _arr_ind1;
	q[array_index++] = _arr_ind2;
	q[array_index++] = _arr_ind3;
	
	for (var i = 6; i < argument_count; i++)
		q[array_index++] = argument[i];
	
	var struct = 
	{
		palName: _palName,
		palTexture: _palTexture,
		palColors: q
	};
	array_push(global.CharacterPalette[_char].palettes, struct);
}

function index_from_paletteName(_char_pal, _char_palName)
{
	var array = global.CharacterPalette[_char_pal].palettes;
	for (var i = 0; i < array_length(array); i++)
	{
		if (array[i].palName == _char_palName)
			return i;
	}
	
	return 0;
}

function define_palette_sprite(_char_pal, _patternColors = [1, 2])
{
	var _struct = 
	{
		palettes: [],
		sprite: -4,
		debug: -4,
		patternColors: _patternColors
	};
	global.CharacterPalette[_char_pal] = _struct;
	trace("INIT PAL BASE : ", _struct);
}

#region Pizzelle Definitions | FROM SS MODDING DATABASE | THANK UNNOWN | "Characters.Pizzelle" WAS "PlayerCharacter.PIZZELLE" BEFORE

define_palette_sprite(Characters.Pizzelle, [0, 1]);
//	DEFAULT:			CHARACTER			NAME					CLOTHES		CLOTHES_SHADING		PATCHES		PATTERN			SCOOTER		SCOOTER_DARK	SCOOTER_THRUSTER	SKIN		SKIN_SHADING
define_player_palette(Characters.Pizzelle, "palette_PZ_default",	#ffff40,	#e6b83c,			#602828,	undefined,		#872cd2,	#200239,		#786898,			#ffaa83,	#a03800);

define_player_palette(Characters.Pizzelle, "palette_PZ_classic", #ffffff, #88a8c8, #88a8c8, undefined); // Technically you don't need to add undefined here.
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionnight", #d0b8b8, #af6669, #602828, undefined);
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionred", #e03000, #580000, #580000, undefined); // 3 Secrets
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionblack", #3e3e49, #182028, #182028, undefined); // 6 Secrets
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionpurple", #6f5bab, #3d2d6e, #3d2d6e, undefined, #c80090, #900040, #d0b8b8); // 9 Secrets
define_player_palette(Characters.Pizzelle, "palette_PZ_noise", #f8e080, #d88818, #d88818, undefined, #d88818, #a03800, #a03800); // 12 Secrets
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionbrain", undefined, c_black, #741A45, spr_demopattern_brain, #a82860, #780038, #780038); // Judgement
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionbraingold", undefined, c_black, #580000, spr_demopattern_brainGold, #943000, #502620, #502620); // 303%
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionpaper", undefined, c_black, #78A8F8, spr_demopattern_paper, #90b0f8, #1070d0, #1070d0); // Paper
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionentryway", undefined, c_black, #E09000, spr_demopattern_entryway, #b83830, #602828, #602828); // Entryway
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionsteamy", undefined, c_black, #FFDEF9, spr_demopattern_steamy, #a880a8, #8038f0, #686090); // Cottontown
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionmineshaft", undefined, c_black, #09447F, spr_demopattern_mineshaft, #60d048, #006858, #006858); // Mines
define_player_palette(Characters.Pizzelle, "palette_PZ_exhibitionmolasses", undefined, c_black, #006858, spr_demopattern_molasses, #f87018, #b03000, #b03000); // Molasses

#endregion

var palette_surface = surface_create(1, 1);
for (var i = 0; i < array_length(global.CharacterPalette); i++)
{
	var char_pal_array = global.CharacterPalette[i].palettes;
	var default_colors = char_pal_array[0].palColors;
	var pal_height = array_length(default_colors);
	surface_resize(palette_surface, array_length(char_pal_array), pal_height);
	surface_set_target(palette_surface);
	draw_clear_alpha(c_black, 0);
	gpu_set_blendenable(false);	
	draw_set_alpha(1);
	
	for (var z = 0; z < array_length(char_pal_array); z++)
	{
		var cur_index = char_pal_array[z].palColors;
		var pal_pattern = char_pal_array[z].palTexture;
		trace("INIT PALETTE : ", char_pal_array[z].palName);
		for (var u = 0; u < array_length(cur_index); u++)
		{
			var _color = cur_index[u];
			if !is_undefined(pal_pattern) && sprite_exists(pal_pattern) && u == 1
				draw_set_alpha(104 / 255);
			if !is_undefined(_color)
				draw_point_color(z, u, _color);
			draw_set_alpha(1);
		}
	}
	
	gpu_set_blendenable(true);
	surface_reset_target();
	global.CharacterPalette[i].sprite = sprite_create_from_surface(palette_surface, 0, 0, surface_get_width(palette_surface), surface_get_height(palette_surface), false, false, 0, 0);
	global.CharacterPalette[i].debug = ref_create(global.CharacterPalette[i], "sprite");
}
surface_free(palette_surface);
