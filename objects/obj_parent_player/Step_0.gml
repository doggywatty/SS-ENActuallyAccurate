var a = instance_place(x, y, obj_secretwall);
secretArray = (a != noone) ? a.layerArray : [];

if (state != PlayerState.comingoutdoor)
	image_blend = c_white;

inputLadderBuffer = max(inputLadderBuffer - 1, 0);
wetTimer = approach(wetTimer, 0, 3);

if (wetTimer > 0 && wetTimerEffect-- <= 0)
	wetTimerEffect = 3;

if (!instance_exists(heatAfterEffectID))
{
	heatAfterEffectID = instance_create(x, y, obj_heatAfterEffect, 
	{
		playerID: id
	});
}

if (state != PlayerState.normal)
{
	breakdanceBuffer = 0;
	breakdanceSpeed = 0.25;
}

if (fireTrailBuffer > 0)
	fireTrailBuffer -= ((movespeed / 24) * 26);

if (fireTrailBuffer <= 0)
{
	if (movespeed >= 12 && sprite_index != spr_longJump && sprite_index != spr_longJump_intro && (state == PlayerState.mach2 || state == PlayerState.mach3 || (state == PlayerState.run && movespeed >= 12) || (state == PlayerState.machroll && mach3Roll > 0)))
	{
		instance_create(x, y, obj_flameCloud, 
		{
			playerID: id
		});
	}
	
	fireTrailBuffer = 100;
}

if (state != PlayerState.mach3 && state != PlayerState.climbwall)
	machFourMode = false;

var conveyor_hsp = conveyorBelt_hsp();

if (abs(conveyor_hsp) > 0)
	conveyorHsp = conveyor_hsp;
else if (abs(conveyor_hsp) <= 0)
	conveyorHsp = approach(conveyorHsp, 0, grounded ? 0.75 : 0.5);

if (!hasSeenProgressionPrompt && (room == hub_demohallway || room == hub_paintstudio) && !instance_exists(obj_fadeoutTransition))
{
	hasSeenProgressionPrompt = true;
	scr_queueToolTipPrompt(lang_get("demo_judgement_hint"));
}

if (room == rm_mainmenu || room == rm_introVideo || room == rm_startupLogo || room == rm_disclaimer)
	state = PlayerState.titlescreen;

if (grounded)
	floatyGrab = 18;

var ceiling = inBackgroundLayer ? (-global.BgInstanceLayerOffset - 600) : -600;

if ((y > (room_height + 400) || y < ceiling) && room != timesuproom && state != PlayerState.noclip && !instance_exists(obj_fadeoutTransition) && !instance_exists(obj_cutsceneManager))
	scr_playerrespawn();

if (state != PlayerState.freefall && state != PlayerState.freefallprep && state != PlayerState.freefallland && state != PlayerState.superslam)
	freeFallSmash = -14;

if (!global.freezeframe && state != PlayerState.frozen)
{
	if (!instance_exists(baddieGrabbedID) && (state == PlayerState.grab || state == PlayerState.charge))
		state = PlayerState.normal;
	
	if (state != PlayerState.grab && state != PlayerState.charge && state != PlayerState.superslam && state != PlayerState.finishingblow)
		baddieGrabbedID = noone;
	
	if (state != PlayerState.machroll && state != PlayerState.mach3)
		mach3Roll = 0;
}

if (sprite_index == spr_player_PZ_tired && state != PlayerState.normal)
	windingAnim = 0;

if (!global.freezeframe)
	global.ComboFreeze--;

global.ComboFreeze = clamp(global.ComboFreeze, 0, 15);
global.ComboTime = clamp(global.ComboTime, 0, 60);

if (!global.freezeframe && !instance_exists(obj_fadeoutTransition) && global.ComboFreeze <= 0 && !is_tutorial())
	global.ComboTime = approach(global.ComboTime, 0, 0.15);

var c_title = floor(global.Combo / 5);

if (oldComboTitle != c_title && c_title > 0)
{
	instance_destroy(obj_comboTitleEffect);
	instance_destroy(obj_comboEndEffect);
	instance_create(830, 265, obj_comboTitleEffect, 
	{
		title: c_title
	});
	oldComboTitle = c_title;
}

if (global.ComboTime <= 0 && global.Combo != 0)
{
	if (global.Combo > 5)
		scr_queueTVAnimation(global.TvSprPlayer_Happy, 200);
	
	event_play_oneshot("event:/SFX/ui/kashingcombo");
	playComboVariable = noone;
	instance_destroy(obj_comboEndEffect);
	
	with (instance_create(832, 265, obj_comboEndEffect, 
	{
		title: max(c_title, 0)
	}))
	{
		comboScore = global.ComboScore;
		subtractBy = round(global.ComboScore / 50);
		
		if (subtractBy < 25)
			subtractBy = 25;
		
		comboScoreMax = comboScore;
	}
	
	oldComboTitle = 0;
	global.ComboScore = 0;
	global.ComboLost = true;
	global.Combo = 0;
}

if (inputBufferSecondJump < 8)
	inputBufferSecondJump++;

if (inputBufferHighJump < 8)
	inputBufferHighJump++;

inputBufferSecondJump = min(inputBufferSecondJump + 1, 8);
inputBufferHighJump = min(inputBufferHighJump + 1, 8);

if (keyParticles)
	instance_create(x + irandom_range(-20, 20), y + irandom_range(-30, 30), obj_keyeffect);

if (!hurted)
	image_alpha = 1;

var machslide_check = sprite_index == spr_machslideboost3 || sprite_index == spr_machslideboost3FallStart || sprite_index == spr_machslideboost3Fall;
var killmove_states = [PlayerState.mach3, PlayerState.slipnslide, PlayerState.frostburnslide, PlayerState.frostburnnormal, PlayerState.cottondrill, PlayerState.cotton, PlayerState.cottonroll, PlayerState.cottondig, PlayerState.bottlerocket, PlayerState.machtumble2, PlayerState.minecart, PlayerState.fireass, PlayerState.grind, PlayerState.hang, PlayerState.puddle, PlayerState.doughmountspin, PlayerState.freefall, PlayerState.Sjump, PlayerState.charge, PlayerState.fling_launch, PlayerState.wallkick];

if (array_contains(killmove_states, state) || (state == PlayerState.machslide && machslide_check) || (state == PlayerState.run && movespeed >= 12) || (state == PlayerState.uppercut && vsp < 0) || (state == PlayerState.frostburnjump && vsp > 0) || (state == PlayerState.tumble && sprite_index != spr_tumblestart && sprite_index != spr_tumbleend) || (state == PlayerState.climbwall && verticalMovespeed > 8) || (state == PlayerState.doughmount && abs(movespeed) >= 10) || (state == PlayerState.machroll && mach3Roll > 0) || (state == PlayerState.superslam && sprite_index == spr_piledriver) || ((state == PlayerState.superslam && sprite_index == spr_piledriverIntro) && sprite_index != spr_player_PZ_werecotton_drill_h))
	instakillmove = true;
else
	instakillmove = false;

if ((state != PlayerState.jump && state != PlayerState.crouchjump) || vsp < 0)
	fallingAnimation = 0;

if (state != PlayerState.freefallland && state != PlayerState.normal && state != PlayerState.machslide)
	slamHurt = 0;

if (state != PlayerState.hurt)
	player_hurt_buffer = 100;

if (state != PlayerState.normal && state != PlayerState.machslide)
	machSlideAnim = false;

if (state != PlayerState.normal)
{
	idle = 0;
	dashdust = 0;
}

if (state != PlayerState.mach1 && state != PlayerState.jump && state != PlayerState.grabdash && state != PlayerState.normal && state != PlayerState.mach2 && state != PlayerState.mach3 && state != PlayerState.freefallprep && state != PlayerState.swingclub && state != PlayerState.cotton && state != PlayerState.cottonroll && state != PlayerState.cottondig)
	momentum = false;

if (state != PlayerState.mach2)
	machPunchAnim = false;

if (state != PlayerState.jump)
	ladderBuffer = 0;

if (state != PlayerState.jump && state != PlayerState.taunt)
	stompAnim = false;

if (state != PlayerState.puddle)
	slipSlopeBounces = 7;

if (state == PlayerState.mach3 || state == PlayerState.mach2 || state == PlayerState.Sjump || (state == PlayerState.machroll && mach3Roll > 0) || state == PlayerState.charge)
{
	machAfterimage--;
	
	if (machAfterimage <= 0)
	{
		with (create_afterimage(choose(AfterImageType.MACH3, AfterImageType.MACH3ALT), xscale, true))
			mach3Afterimage = true;
		
		machAfterimage = 6;
	}
}
else
{
	machAfterimage = 0;
}

var up_arrow = ((place_meeting(x, y, obj_door) && !(place_meeting(x, y, obj_doorblocked) || place_meeting(x, y, obj_keydoor) || place_meeting(x, y, obj_janitorDoor))) || (place_meeting(x, y, obj_startGate) && state != PlayerState.victory) || place_meeting(x, y, obj_soundTest_Button) || (place_meeting(x, y, obj_janitorDoor) && (global.janitorRudefollow || ds_list_find_index(global.SaveRoom, instance_place(x, y, obj_janitorDoor).id) != -1)) || (place_meeting(x, y, obj_keydoor) && (ds_list_size(global.KeyFollowerList) > 0 || ds_list_find_index(global.SaveRoom, instance_place(x, y, obj_keydoor).id) != -1)) || (place_meeting(x, y, obj_exitgate) && global.panic == 1)) && !instance_exists(obj_uparrow) && scr_solid(x, y + 1) && state == PlayerState.normal;

if (up_arrow)
	instance_create(x, y, obj_uparrow);

if (state == PlayerState.mach3 && !instance_exists(obj_speedlines))
{
	instance_create(x, y, obj_speedlines, 
	{
		playerID: id
	});
}

if (state == PlayerState.wallkick)
{
	blueAfterimage--;
	
	if (blueAfterimage <= 0)
	{
		with (create_afterimage(AfterImageType.WALLKICK, xscale, true))
			mach3Afterimage = true;
		
		blueAfterimage = 6;
	}
}
else
{
	blueAfterimage = 0;
}

if (superTauntBuffer >= 10 && state != PlayerState.taunt && global.Combo >= 10)
{
	if (!superTauntCharged)
		event_play_oneshot("event:/SFX/player/gotsupertaunt", x, y);
	
	superTauntCharged = true;
}

if (place_meeting(x, y + 9, obj_molassesGround))
{
	if (hsp != 0 && (floor(image_index) % 4) == 0 && grounded)
	{
		create_debris(x, y + 43, spr_molassesgoop);
		event_play_oneshot("event:/SFX/player/goopfloor", x, y);
	}
	
	if (state == PlayerState.climbwall && vsp < 0)
		state = PlayerState.normal;
	
	if (vsp < 0 && grounded)
	{
		vsp /= 2;
		create_debris(x, y + 43, spr_molassesgoop);
		event_play_oneshot("event:/SFX/player/goopjump", x, y);
	}
}

if (place_meeting(x, y + 3, obj_icyGround) && grounded)
{
	if (sign(hsp) != sign(prevHsp))
		slideHsp += (prevHsp / 1.5);
	
	if (scr_slope())
		slideHsp += (0.25 * slopeMomentum_acceleration());
}
else if (grounded)
{
	slideHsp = approach(slideHsp, 0, 0.35);
}

if (!grounded)
	slideHsp = approach(slideHsp, 0, 0.6);

slideHsp = approach(slideHsp, 0, 0.15);
slideHsp = clamp(abs(slideHsp), 0, 3) * sign(slideHsp);

if (state == PlayerState.climbwall)
	slideHsp = 0;

dashpadBuffer = max(dashpadBuffer - 1, 0);
kungBuffer = max(kungBuffer - 1, 0);
global.HighestCombo = max(global.Combo, global.HighestCombo);

if (playerNoInputBuffer < playerNoInputBufferMax)
	playerNoInputBuffer++;

if (any_input_check())
	playerNoInputBuffer = 0;
