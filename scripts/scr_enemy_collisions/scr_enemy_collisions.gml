function scr_finishingBlow(player, scale)
{
	if !instance_exists(player)
		exit;
	if (player.state == States.climbwall)
		exit;
	with player
	{
		x = scale.x + (60 * scale.xscale);
		y = scale.y;
		scr_enemyFinishingBlowPos(scale);
		flash = true;
		global.ComboTime = 60;
		alarm[1] = 5;
		grounded = false;
		hitHsp = scale.xscale * 25;
		hitVsp = 0;
		if (scale.sprite_index == scale.spr_suplexmashUppercut)
		{
			hitHsp = 0;
			hitVsp = -25;
		}
		hsp = hitHsp;
		vsp = hitVsp;
		hp = 0;
		throwAntiGrav = true;
		state = States.climbwall;
		if (baddieStunTimer < 500)
			baddieStunTimer = 500;
		create_particle(x, y, spr_bangEffect);
		create_particle(x, y, spr_parryeffect);
		repeat 6
		{
			create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
			create_baddiedebris();
		}
	}
}

function scr_instakillEnemy(player, scale)
{
	if !instance_exists(player)
		exit;
	if (player.state == States.climbwall)
		exit;
	with player
	{
		event_play_oneshot("event:/SFX/player/punch", x, y);
		camera_shake_add(3, 3);
		global.ComboTime = 60;
		image_xscale = -scale.xscale;
		hsp = -image_xscale * abs(scale.hsp);
		if (scale.state == States.mach3)
			x = scale.x + (((abs(scale.hsp) * 2) + 5) * sign(scale.hsp));
		vsp = -10;
		sprite_index = baddieSpriteDead;
		state = States.charge;
		if (baddieStunTimer < 200)
			baddieStunTimer = 200;
		baddieInvincibilityBuffer = 20;
		markedForDeath = true;
		create_particle(x, y, spr_kungfuEffect);
		create_particle(x, y, spr_parryeffect);
		repeat 6
		{
			create_baddiedebris();
			create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
		}
	}
}

function scr_baddieCollisionBox(_mask_ind = mask_index)
{
	var old_mask = mask_index;
	mask_index = _mask_ind;
	baddieOnPlayerCollisions();
	baddieOnEscapeRosetteCollisions();
	baddieOnBaddieCollisions();
	baddieOnSwingCollisions();
	baddieOnInstakillHitboxCollisions();
	mask_index = old_mask;
}

function baddieOnPlayerCollisions()
{
	var player_object = get_nearestPlayer();
	if (!invincibleBaddie && state != States.stun && place_meeting(x, y, player_object)
	&& !player_object.cutscene && player_object.state != States.hurt)
	{
		if (baddieInvincibilityBuffer <= 0 && player_object.instakillmove && state != States.climbwall)
		{
			scr_instakillEnemy(id, player_object);
			with player_object
			{
				if (mach3Roll > 0 && state == States.machroll)
				{
					mach3Roll = mach3RollMax;
					flash = false;
					if grounded
					{
						sprite_index = spr_machroll3intro;
						image_index = 0;
					}
				}
				if !grounded && state != States.freefall && state != States.machroll && key_jump2
				{
					create_particle(x, y + 50, spr_stompEffect);
					flash = false;
					vsp = -11;
				}
				if (state == States.mach3 && sprite_index != spr_mach3hit)
				{
					sprite_index = spr_mach3hit;
					image_index = 0;
				}
				if ((state == States.cotton || state == States.cottondrill || state == States.cottonroll) && !grounded)
				{
					vsp = min(-10, vsp);
					jumpStop = true;
					image_index = 0;
					sprite_index = spr_cottonDoubleJump;
				}
			}
			scr_sleep();
			exit;
		}
		
		if (baddieInvincibilityBuffer <= 0 && state != States.climbwall
		&& (player_object.state == States.mach2 || player_object.state == States.mach3
		|| player_object.state == States.run || player_object.state == States.machroll))
		{
			event_play_multiple("event:/SFX/player/mach2bump", x, y);
			global.ComboFreeze = 15;
			image_xscale = -player_object.xscale;
			image_index = 0;
			hsp = player_object.xscale * 12;
			vsp = (player_object.y - 180 - y) / 60;
			state = States.charge;
			baddieInvincibilityBuffer = 5;
			hasSquashedX = true;
			squashValueX = 0;
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			instance_create(x, y, obj_bumpEffect);
			create_particle(x, y, spr_bangEffect);
			repeat 2
			{
				instance_create(x, y, obj_slapstar);
				instance_create(x, y, obj_baddieGibs);
			}
			exit;
		}
		
		if (baddieInvincibilityBuffer <= 0 && player_object.state == States.cotton
		&& player_object.sprite_index == spr_player_PZ_werecotton_drill_h)
		{
			event_play_oneshot("event:/SFX/player/punch", x, y);
			event_play_oneshot("event:/SFX/enemies/killingblow", x, y);
			camera_shake_add(5, 20);
			scr_finishingBlow(id, player_object);
			exit;
		}
		
		if (canBeStomped && vsp >= 0 && (player_object.state == States.jump
		|| player_object.state == States.grab) && player_object.vsp > 0 && player_object.y < y
		&& player_object.sprite_index != player_object.spr_stompprep)
		{
			event_play_oneshot("event:/SFX/enemies/stomp", x, y);
			hasSquashedX = true;
			squashValueX = 0;
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			var facePlayer = face_obj(player_object);
			if facePlayer != 0
				image_xscale = facePlayer;
			hsp = player_object.xscale * 5;
			vsp = -5;
			state = States.charge;
			with player_object
			{
				flash = false;
				stompAnim = true;
				sprite_index = spr_stompprep;
				image_index = 0;
				create_particle(x, y + 50, spr_stompEffect);
				if (state == States.grab)
					sprite_index = spr_haulingJump;
				vsp = key_jump2 ? -14 : -9;
			}
			exit;
		}
		
		if (canBeGrabbed && player_object.state == States.grabdash)
		{
			state = States.stun;
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			with player_object
			{
				event_play_oneshot("event:/SFX/enemies/grabbed");
				baddieGrabbedID = other.id;
				image_index = 0;
				create_particle(x, y, spr_grabRing);
				if (movespeed <= 10)
				{
					state = States.grab;
					sprite_index = spr_haulingIntro;
				}
				else
				{
					sprite_index = spr_swingDing;
					movespeed = max(movespeed, 10);
					state = States.charge;
				}
				if !grounded
					vsp = -6;
				if key_up
				{
					state = States.superslam;
					sprite_index = spr_piledriver;
					vsp = -14;
					grounded = false;
					image_index = 0;
					image_speed = 0.35;
				}
			}
			exit;
		}
		
		if (canBeGrabbed && player_object.state == States.machtumble)
		{
			state = States.stun;
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			with player_object
			{
				baddieGrabbedID = other.id;
				image_index = 0;
				if (move != 0)
					move = xscale;
				inputBufferSlap = 0;
				movespeed = clamp(movespeed, 0, 6);
				state = States.finishingblow;
				sprite_index = spr_grabDashTumble_hit;
				if key_up
					sprite_index = spr_grabDashTumble_hitUp;
			}
			if (object_get_parent(object_index) == obj_parent_boss)
				scr_grab_boss(player_object);
			exit;
		}
	}
	exit;
}

function baddieOnBaddieCollisions()
{
	if (state != States.climbwall || !place_meeting(x, y, obj_parent_enemy))
		exit;
	with instance_place(x, y, obj_parent_enemy)
	{
		if (!invincibleBaddie && state != States.stun)
		{
			instance_destroy();
			exit;
		}
	}
}

function baddieOnEscapeRosetteCollisions()
{
	if !place_meeting(x, y, obj_escaperosette)
		exit;
	with instance_place(x, y, obj_escaperosette)
	{
		if (state == 1)
		{
			instance_destroy(other.id);
			exit;
		}
	}
}

function baddieOnSwingCollisions()
{
	if (baddieInvincibilityBuffer > 0 || invincibleBaddie || !place_meeting(x, y, obj_swinghitbox))
		exit;
	var player_object = instance_place(x, y, obj_swinghitbox).playerID;
	if !instance_exists(player_object)
		exit;
	event_play_oneshot("event:/SFX/player/punch", x, y);
	scr_sleep();
	create_particle(x, y, spr_enemypuncheffect);
	create_particle(x, y, spr_parryeffect);
	global.ComboTime = 60;
	if (player_object.x != x)
		image_xscale = getFacingDirection(player_object.x, x);
	hsp = image_xscale * abs(player_object.hsp);
	vsp = -10;
	sprite_index = baddieSpriteDead;
	flash = true;
	state = States.charge;
	eliteHP = 0;
	if (baddieStunTimer < 200)
		baddieStunTimer = 200;
	baddieInvincibilityBuffer = 20;
	markedForDeath = true;
	camera_shake_add(3, 3);
	repeat 3
	{
		create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);		
		instance_create(x, y, obj_slapstar);
		instance_create(x, y, obj_baddieGibs);
	}
}

function baddieOnInstakillHitboxCollisions()
{
	if (baddieInvincibilityBuffer > 0 || invincibleBaddie || state == States.stun
	|| !place_meeting(x, y, obj_instakillHitbox))
		exit;
	var player_object = instance_place(x, y, obj_instakillHitbox).playerID;
	scr_instakillEnemy(id, player_object);
}
