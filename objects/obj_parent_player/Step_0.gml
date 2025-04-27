var a = instance_place(x, y, obj_secretwall);
secretArray = (a != -4) ? a.layerArray : [];

if (state != States.comingoutdoor)
	image_blend = c_white;

inputLadderBuffer = max(inputLadderBuffer - 1, 0);
wetTimer = approach(wetTimer, 0, 3);

if (wetTimer > 0 && wetTimerEffect-- <= 0)
	wetTimerEffect = 3;
if !instance_exists(heatAfterEffectID)
{
	heatAfterEffectID = instance_create(x, y, obj_heatAfterEffect, 
	{
		playerID: id
	});
}

if (state != States.normal)
{
	breakdanceBuffer = 0;
	breakdanceSpeed = 0.25;
}

if (fireTrailBuffer > 0)
	fireTrailBuffer -= ((movespeed / 24) * 26);
if (fireTrailBuffer <= 0)
{
	if (movespeed >= 12 && sprite_index != spr_longJump && sprite_index != spr_longJump_intro
	&& (state == States.mach2 || state == States.mach3 || (state == States.run && movespeed >= 12)
	|| (state == States.machroll && mach3Roll > 0)))
	{
		instance_create(x, y, obj_flameCloud, 
		{
			playerID: id
		});
	}
	fireTrailBuffer = 100;
}

if (state != States.mach3 && state != States.climbwall)
	machFourMode = false;

var conveyor_hsp = conveyorBelt_hsp();
if (abs(conveyor_hsp) > 0)
	conveyorHsp = conveyor_hsp;
else if (abs(conveyor_hsp) <= 0)
	conveyorHsp = approach(conveyorHsp, 0, grounded ? 0.75 : 0.5);

if (!hasSeenProgressionPrompt && (room == hub_demohallway || room == hub_paintstudio)
&& !instance_exists(obj_fadeoutTransition))
{
	hasSeenProgressionPrompt = true;
	scr_queueToolTipPrompt(lang_get("demo_judgement_hint"));
}

if (room == rm_mainmenu || room == rm_introVideo || room == rm_startupLogo || room == rm_disclaimer)
	state = States.titlescreen;
if grounded
	floatyGrab = 18;
if global.lapcount > 1
	instance_create(x, y, obj_memLeak);

var ceiling = inBackgroundLayer ? (-global.BgInstanceLayerOffset - 600) : -600;
if ((y > (room_height + 400) || y < ceiling) && room != timesuproom && state != States.noclip
&& !instance_exists(obj_fadeoutTransition) && !instance_exists(obj_cutsceneManager))
	scr_playerrespawn();
if (state != States.freefall && state != States.freefallprep && state != States.freefallland && state != States.superslam)
	freeFallSmash = -14;

if (!global.freezeframe && state != States.frozen)
{
	if (!instance_exists(baddieGrabbedID) && (state == States.grab || state == States.charge))
		state = States.normal;
	if (state != States.grab && state != States.charge && state != States.superslam && state != States.finishingblow)
		baddieGrabbedID = -4;
	if (state != States.machroll && state != States.mach3)
		mach3Roll = 0;
}

if (sprite_index == spr_player_PZ_tired && state != States.normal)
	windingAnim = 0;

if !global.freezeframe
	global.ComboFreeze--;

global.ComboFreeze = clamp(global.ComboFreeze, 0, 15);
global.ComboTime = clamp(global.ComboTime, 0, 60);

if (!global.freezeframe && !instance_exists(obj_fadeoutTransition)
&& global.ComboFreeze <= 0 && !is_tutorial())
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

if keyParticles
	instance_create(x + irandom_range(-20, 20), y + irandom_range(-30, 30), obj_keyeffect);
if !hurted
	image_alpha = 1;
var machslide_check = sprite_index == spr_machslideboost3 || sprite_index == spr_machslideboost3FallStart || sprite_index == spr_machslideboost3Fall;
var killmove_states = [
	States.mach3, States.slipnslide, States.frostburnslide, States.frostburnnormal,
	States.cottondrill, States.cotton, States.cottonroll, States.cottondig,
	States.bottlerocket, States.machtumble2, States.minecart, States.fireass,
	States.grind, States.hang, States.puddle, States.doughmountspin, States.freefall,
	States.Sjump, States.charge, States.fling_launch, States.wallkick
];
if (array_contains(killmove_states, state) || (state == States.machslide && machslide_check) || (state == States.run && movespeed >= 12) || (state == States.uppercut && vsp < 0) || (state == States.frostburnjump && vsp > 0) || (state == States.tumble && sprite_index != spr_tumblestart && sprite_index != spr_tumbleend) || (state == States.climbwall && verticalMovespeed > 8) || (state == States.doughmount && abs(movespeed) >= 10) || (state == States.machroll && mach3Roll > 0) || (state == States.superslam && sprite_index == spr_piledriver) || ((state == States.superslam && sprite_index == spr_piledriverIntro) && sprite_index != spr_player_PZ_werecotton_drill_h))
	instakillmove = true;
else
	instakillmove = false;
if ((state != States.jump && state != States.crouchjump) || vsp < 0)
	fallingAnimation = 0;
if (state != States.freefallland && state != States.normal && state != States.machslide)
	slamHurt = 0;
if (state != States.hurt)
	player_hurt_buffer = 100;
if (state != States.normal && state != States.machslide)
	machSlideAnim = false;
if (state != States.normal)
{
	idle = 0;
	dashdust = 0;
}
if (state != States.mach1 && state != States.jump && state != States.grabdash && state != States.normal && state != States.mach2 && state != States.mach3 && state != States.freefallprep && state != States.swingclub && state != States.cotton && state != States.cottonroll && state != States.cottondig)
	momentum = false;
if (state != States.mach2)
	machPunchAnim = false;
if (state != States.jump)
	ladderBuffer = 0;
if (state != States.jump && state != States.taunt)
	stompAnim = false;
if (state != States.puddle)
	slipSlopeBounces = 7;
if (state == States.mach3 || state == States.mach2 || state == States.Sjump || (state == States.machroll && mach3Roll > 0) || state == States.charge)
{
	machAfterimage--;
	if (machAfterimage <= 0)
	{
		with (create_afterimage(choose(AfterImageType.mach3effect1, AfterImageType.mach3effect2), xscale, true))
			mach3Afterimage = true;
		machAfterimage = 6;
	}
}
else
	machAfterimage = 0;

var up_arrow = ((place_meeting(x, y, obj_door) && !(place_meeting(x, y, obj_doorblocked) || place_meeting(x, y, obj_keydoor)
|| place_meeting(x, y, obj_janitorDoor))) || (place_meeting(x, y, obj_startGate)
&& state != States.victory) || place_meeting(x, y, obj_soundTest_Button)
|| (place_meeting(x, y, obj_janitorDoor) && (global.janitorRudefollow
|| ds_list_find_index(global.SaveRoom, instance_place(x, y, obj_janitorDoor).id) != -1))
|| (place_meeting(x, y, obj_keydoor) && (ds_list_size(global.KeyFollowerList) > 0
|| ds_list_find_index(global.SaveRoom, instance_place(x, y, obj_keydoor).id) != -1))
|| (place_meeting(x, y, obj_exitgate) && global.panic == 1)) && !instance_exists(obj_uparrow)
&& scr_solid(x, y + 1) && state == States.normal;
if up_arrow
	instance_create(x, y, obj_uparrow);

if (state == States.mach3 && !instance_exists(obj_speedlines))
{
	instance_create(x, y, obj_speedlines, 
	{
		playerID: id
	});
}

if (state == States.wallkick)
{
	blueAfterimage--;
	if (blueAfterimage <= 0)
	{
		with (create_afterimage(AfterImageType.wallkick, xscale, true))
			mach3Afterimage = true;
		blueAfterimage = 6;
	}
}
else
	blueAfterimage = 0;

if (superTauntBuffer >= 10 && state != States.taunt && global.Combo >= 10)
{
	if !superTauntCharged
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
	if (state == States.climbwall && vsp < 0)
		state = States.normal;
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
else if grounded
	slideHsp = approach(slideHsp, 0, 0.35);
if !grounded
	slideHsp = approach(slideHsp, 0, 0.6);

slideHsp = approach(slideHsp, 0, 0.15);
slideHsp = clamp(abs(slideHsp), 0, 3) * sign(slideHsp);

if (state == States.climbwall)
	slideHsp = 0;

dashpadBuffer = max(dashpadBuffer - 1, 0);
kungBuffer = max(kungBuffer - 1, 0);
global.HighestCombo = max(global.Combo, global.HighestCombo);

if (playerNoInputBuffer < playerNoInputBufferMax)
	playerNoInputBuffer++;

if any_input_check()
	playerNoInputBuffer = 0;
