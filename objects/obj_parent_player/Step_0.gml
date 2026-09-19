var a = instance_place(x, y, obj_secretwall);
secretArray = (a != -4) ? a.layerArray : [];

if (state != states.stunned)
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

if (state != states.normal)
{
	breakdanceBuffer = 0;
	breakdanceSpeed = 0.25;
}

if (fireTrailBuffer > 0)
	fireTrailBuffer -= ((movespeed / 24) * 26);

if (fireTrailBuffer <= 0)
{
	if (movespeed >= 12 && sprite_index != spr_longJump && sprite_index != spr_longJump_intro && (state == states.pistol || state == states.shotgun || (state == states.Nhookshot && movespeed >= 12) || (state == states.climbdownwall && mach3Roll > 0)))
	{
		instance_create(x, y, obj_flameCloud, 
		{
			playerID: id
		});
	}
	
	fireTrailBuffer = 100;
}

if (state != states.shotgun && state != states.cheesepep)
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
	state = states.titlescreen;

if (grounded)
	floatyGrab = 18;

var ceiling = inBackgroundLayer ? (-global.BgInstanceLayerOffset - 600) : -600;

if ((y > (room_height + 400) || y < ceiling) && room != timesuproom && state != states.noclip && !instance_exists(obj_fadeoutTransition) && !instance_exists(obj_cutsceneManager))
	scr_playerrespawn();

if (state != states.slam && state != states.meteorpep && state != states.skateboard && state != states.secondjump)
	freeFallSmash = -14;

if (!global.freezeframe && state != states.frozen)
{
	if (!instance_exists(baddieGrabbedID) && (state == states.handstandjump || state == states.slap))
		state = states.normal;
	
	if (state != states.handstandjump && state != states.slap && state != states.secondjump && state != states.bossdefeat)
		baddieGrabbedID = -4;
	
	if (state != states.climbdownwall && state != states.shotgun)
		mach3Roll = 0;
}

if (sprite_index == spr_player_PZ_tired && state != states.normal)
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
	playComboVariable = -4;
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
var killmove_states = [states.shotgun, states.bombpep, states.uppercut, states.cotton, states.keyget, states.bossintro, states.tackle, states.slipnslide, states.barrelmach2, states.crouch, states.victory, states.crouchslide, states.chainsawbump, states.grind, states.freefallprep, states.backkick, states.slam, states.highjump, states.slap, states.parry, states.cheeseball];

if (array_contains(killmove_states, state) || (state == states.machfreefall && machslide_check) || (state == states.Nhookshot && movespeed >= 12) || (state == states.ufofloat && vsp < 0) || (state == states.pal && vsp > 0) || (state == states.runonball && sprite_index != spr_tumblestart && sprite_index != spr_tumbleend) || (state == states.cheesepep && verticalMovespeed > 8) || (state == states.punch && abs(movespeed) >= 10) || (state == states.climbdownwall && mach3Roll > 0) || (state == states.secondjump && sprite_index == spr_piledriver) || ((state == states.secondjump && sprite_index == spr_piledriverIntro) && sprite_index != spr_player_PZ_werecotton_drill_h))
	instakillmove = true;
else
	instakillmove = false;

if ((state != states.chainsawpogo && state != states.timesup) || vsp < 0)
	fallingAnimation = 0;

if (state != states.skateboard && state != states.normal && state != states.machfreefall)
	slamHurt = 0;

if (state != states.superslam)
	player_hurt_buffer = 100;

if (state != states.normal && state != states.machfreefall)
	machSlideAnim = false;

if (state != states.normal)
{
	idle = 0;
	dashdust = 0;
}

if (state != states.machroll && state != states.chainsawpogo && state != states.pistalaim && state != states.normal && state != states.pistol && state != states.shotgun && state != states.meteorpep && state != states.portal && state != states.bossintro && state != states.tackle && state != states.slipnslide)
	momentum = false;

if (state != states.pistol)
	machPunchAnim = false;

if (state != states.chainsawpogo)
	ladderBuffer = 0;

if (state != states.chainsawpogo && state != states.gottreasure)
	stompAnim = false;

if (state != states.freefallprep)
	slipSlopeBounces = 7;

if (state == states.shotgun || state == states.pistol || state == states.highjump || (state == states.climbdownwall && mach3Roll > 0) || state == states.slap)
{
	machAfterimage--;
	
	if (machAfterimage <= 0)
	{
		with (create_afterimage(choose(afterimagetypes.blue, afterimagetypes.pink), xscale, true))
			mach3Afterimage = true;
		
		machAfterimage = 6;
	}
}
else
{
	machAfterimage = 0;
}

var up_arrow = ((place_meeting(x, y, obj_door) && !(place_meeting(x, y, obj_doorblocked) || place_meeting(x, y, obj_keydoor) || place_meeting(x, y, obj_janitorDoor))) || (place_meeting(x, y, obj_startGate) && state != states.shotgunjump) || place_meeting(x, y, obj_soundTest_Button) || (place_meeting(x, y, obj_janitorDoor) && (global.janitorRudefollow || ds_list_find_index(global.SaveRoom, instance_place(x, y, obj_janitorDoor).id) != -1)) || (place_meeting(x, y, obj_keydoor) && (ds_list_size(global.KeyFollowerList) > 0 || ds_list_find_index(global.SaveRoom, instance_place(x, y, obj_keydoor).id) != -1)) || (place_meeting(x, y, obj_exitgate) && global.panic == 1)) && !instance_exists(obj_uparrow) && scr_solid(x, y + 1) && state == states.normal;

if (up_arrow)
	instance_create(x, y, obj_uparrow);

if (state == states.shotgun && !instance_exists(obj_speedlines))
{
	instance_create(x, y, obj_speedlines, 
	{
		playerID: id
	});
}

if (state == states.cheeseball)
{
	blueAfterimage--;
	
	if (blueAfterimage <= 0)
	{
		with (create_afterimage(afterimagetypes.palette, xscale, true))
			mach3Afterimage = true;
		
		blueAfterimage = 6;
	}
}
else
{
	blueAfterimage = 0;
}

if (superTauntBuffer >= 10 && state != states.gottreasure && global.Combo >= 10)
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
	
	if (state == states.cheesepep && vsp < 0)
		state = states.normal;
	
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

if (state == states.cheesepep)
	slideHsp = 0;

dashpadBuffer = max(dashpadBuffer - 1, 0);
kungBuffer = max(kungBuffer - 1, 0);
global.HighestCombo = max(global.Combo, global.HighestCombo);

if (playerNoInputBuffer < playerNoInputBufferMax)
	playerNoInputBuffer++;

if (any_input_check())
	playerNoInputBuffer = 0;
