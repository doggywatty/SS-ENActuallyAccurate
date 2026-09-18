function scr_finishingBlow(arg0, arg1)
{
	if (!instance_exists(arg0))
		exit;
	
	if (arg0.state == states.cheesepep)
		exit;
	
	with (arg0)
	{
		x = arg1.x + (60 * arg1.xscale);
		y = arg1.y;
		scr_enemyFinishingBlowPos(arg1);
		flash = true;
		global.ComboTime = 60;
		alarm[1] = 5;
		grounded = false;
		hitHsp = arg1.xscale * 25;
		hitVsp = 0;
		
		if (arg1.sprite_index == arg1.spr_suplexmashUppercut)
		{
			hitHsp = 0;
			hitVsp = -25;
		}
		
		hsp = hitHsp;
		vsp = hitVsp;
		hp = 0;
		throwAntiGrav = true;
		state = states.cheesepep;
		
		if (baddieStunTimer < 500)
			baddieStunTimer = 500;
		
		create_particle(x, y, spr_bangEffect);
		create_particle(x, y, spr_parryeffect);
		
		repeat (6)
		{
			create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
			create_baddiedebris();
		}
	}
}

function scr_instakillEnemy(arg0, arg1)
{
	if (!instance_exists(arg0))
		exit;
	
	if (arg0.state == states.cheesepep)
		exit;
	
	with (arg0)
	{
		event_play_oneshot("event:/SFX/player/punch", x, y);
		camera_shake_add(3, 3);
		global.ComboTime = 60;
		image_xscale = -arg1.xscale;
		hsp = -image_xscale * abs(arg1.hsp);
		
		if (arg1.state == states.shotgun)
			x = arg1.x + (((abs(arg1.hsp) * 2) + 5) * sign(arg1.hsp));
		
		vsp = -10;
		sprite_index = baddieSpriteDead;
		state = states.slap;
		
		if (baddieStunTimer < 200)
			baddieStunTimer = 200;
		
		baddieInvincibilityBuffer = 20;
		markedForDeath = true;
		create_particle(x, y, spr_kungfuEffect);
		create_particle(x, y, spr_parryeffect);
		
		repeat (6)
		{
			create_baddiedebris();
			create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
		}
	}
}

function scr_baddieCollisionBox(arg0 = mask_index)
{
	var old_mask = mask_index;
	mask_index = arg0;
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
	
	if (!invincibleBaddie && state != states.charge && place_meeting(x, y, player_object) && !player_object.cutscene && player_object.state != states.superslam)
	{
		if (baddieInvincibilityBuffer <= 0 && player_object.instakillmove && state != states.cheesepep)
		{
			scr_instakillEnemy(id, player_object);
			
			with (player_object)
			{
				if (mach3Roll > 0 && state == states.climbdownwall)
				{
					mach3Roll = mach3RollMax;
					flash = false;
					
					if (grounded)
					{
						sprite_index = spr_machroll3intro;
						image_index = 0;
					}
				}
				
				if (!grounded && state != states.slam && state != states.climbdownwall && key_jump2)
				{
					create_particle(x, y + 50, spr_stompEffect);
					flash = false;
					vsp = -11;
				}
				
				if (state == states.shotgun && sprite_index != spr_mach3hit)
				{
					sprite_index = spr_mach3hit;
					image_index = 0;
				}
				
				if ((state == states.bossintro || state == states.keyget || state == states.tackle) && !grounded)
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
		
		if (baddieInvincibilityBuffer <= 0 && state != states.cheesepep && (player_object.state == states.pistol || player_object.state == states.shotgun || player_object.state == states.Nhookshot || player_object.state == states.climbdownwall))
		{
			event_play_multiple("event:/SFX/player/mach2bump", x, y);
			global.ComboFreeze = 15;
			image_xscale = -player_object.xscale;
			image_index = 0;
			hsp = player_object.xscale * 12;
			vsp = (player_object.y - 180 - y) / 60;
			state = states.slap;
			baddieInvincibilityBuffer = 5;
			hasSquashedX = true;
			squashValueX = 0;
			
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			
			instance_create(x, y, obj_bumpEffect);
			create_particle(x, y, spr_bangEffect);
			
			repeat (2)
			{
				instance_create(x, y, obj_slapstar);
				instance_create(x, y, obj_baddieGibs);
			}
			
			exit;
		}
		
		if (baddieInvincibilityBuffer <= 0 && player_object.state == states.bossintro && player_object.sprite_index == spr_player_PZ_werecotton_drill_h)
		{
			event_play_oneshot("event:/SFX/player/punch", x, y);
			event_play_oneshot("event:/SFX/enemies/killingblow", x, y);
			camera_shake_add(5, 20);
			scr_finishingBlow(id, player_object);
			exit;
		}
		
		if (canBeStomped && vsp >= 0 && (player_object.state == states.chainsawpogo || player_object.state == states.handstandjump) && player_object.vsp > 0 && player_object.y < y && player_object.sprite_index != player_object.spr_stompprep)
		{
			event_play_oneshot("event:/SFX/enemies/stomp", x, y);
			hasSquashedX = true;
			squashValueX = 0;
			
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			
			var facePlayer = face_obj(player_object);
			
			if (facePlayer != 0)
				image_xscale = facePlayer;
			
			hsp = player_object.xscale * 5;
			vsp = -5;
			state = states.slap;
			
			with (player_object)
			{
				flash = false;
				stompAnim = true;
				sprite_index = spr_stompprep;
				image_index = 0;
				create_particle(x, y + 50, spr_stompEffect);
				
				if (state == states.handstandjump)
					sprite_index = spr_haulingJump;
				
				vsp = key_jump2 ? -14 : -9;
			}
			
			exit;
		}
		
		if (canBeGrabbed && player_object.state == states.pistalaim)
		{
			state = states.charge;
			
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			
			with (player_object)
			{
				event_play_oneshot("event:/SFX/enemies/grabbed");
				baddieGrabbedID = other.id;
				image_index = 0;
				create_particle(x, y, spr_grabRing);
				
				if (movespeed <= 10)
				{
					state = states.handstandjump;
					sprite_index = spr_haulingIntro;
				}
				else
				{
					sprite_index = spr_swingDing;
					movespeed = max(movespeed, 10);
					state = states.slap;
				}
				
				if (!grounded)
					vsp = -6;
				
				if (key_up)
				{
					state = states.secondjump;
					sprite_index = spr_piledriver;
					vsp = -14;
					grounded = false;
					image_index = 0;
					image_speed = 0.35;
				}
			}
			
			exit;
		}
		
		if (canBeGrabbed && player_object.state == states.cheesepepstick)
		{
			state = states.charge;
			
			if (baddieStunTimer < 200)
				baddieStunTimer = 200;
			
			with (player_object)
			{
				baddieGrabbedID = other.id;
				image_index = 0;
				
				if (move != 0)
					move = xscale;
				
				inputBufferSlap = 0;
				movespeed = clamp(movespeed, 0, 6);
				state = states.bossdefeat;
				sprite_index = spr_grabDashTumble_hit;
				
				if (key_up)
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
	if (state != states.cheesepep || !place_meeting(x, y, obj_parent_enemy))
		exit;
	
	with (instance_place(x, y, obj_parent_enemy))
	{
		if (!invincibleBaddie && state != states.charge)
		{
			instance_destroy();
			exit;
		}
	}
}

function baddieOnEscapeRosetteCollisions()
{
	if (!place_meeting(x, y, obj_escaperosette))
		exit;
	
	with (instance_place(x, y, obj_escaperosette))
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
	
	if (!instance_exists(player_object))
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
	state = states.slap;
	eliteHP = 0;
	
	if (baddieStunTimer < 200)
		baddieStunTimer = 200;
	
	baddieInvincibilityBuffer = 20;
	markedForDeath = true;
	camera_shake_add(3, 3);
	
	repeat (3)
	{
		create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
		instance_create(x, y, obj_slapstar);
		instance_create(x, y, obj_baddieGibs);
	}
}

function baddieOnInstakillHitboxCollisions()
{
	if (baddieInvincibilityBuffer > 0 || invincibleBaddie || state == states.charge || !place_meeting(x, y, obj_instakillHitbox))
		exit;
	
	var player_object = instance_place(x, y, obj_instakillHitbox).playerID;
	scr_instakillEnemy(id, player_object);
}
