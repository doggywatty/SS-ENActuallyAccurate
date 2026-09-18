switch (state)
{
	case enemystates.idle:
		scr_enemy_idle();
		break;
	case enemystates.turn:
		scr_enemy_turn();
		break;
	case enemystates.walk:
		scr_enemy_walk();
		break;
	case enemystates.hit:
		scr_enemy_hit();
		break;
	case enemystates.charge:
		scr_enemy_charge();
		break;
	case enemystates.stun:
		scr_enemy_stun();
		break;
	case enemystates.frozen:
		scr_enemy_frozen();
		break;
	case enemystates.stationary:
		hsp = 0;
		vsp = 0;
		break;
	case enemystates.float:
		scr_enemy_float();
		break;
	case enemystates.thief:
		scr_enemy_thief();
		break;
	case enemystates.panicWait:
		scr_enemy_panicWait();
		break;
	case enemystates.secretWait:
		scr_enemy_secretWait();
		break;
	case enemystates.Throw:
		scr_enemy_throw();
		break;
	case enemystates.grabbed:
		scr_enemy_grabbed();
		break;
	case enemystates.scared:
		scr_enemy_scared();
		break;
	case enemystates.cherryWait:
		scr_enemy_cherrywait();
		break;
	case enemystates.charcherry:
		scr_enemy_charcherry();
		break;
	case enemystates.slugjump:
		scr_enemy_slugjump();
		break;
	case enemystates.slugparry:
		scr_enemy_slugparry();
		break;
	case enemystates.eyescreamWait:
		scr_enemy_eyescreamwait();
		break;
	case enemystates.eyescream:
		scr_enemy_eyescream();
		break;
	case enemystates.rage:
		scr_enemy_rage();
		break;
}

if (baddieCollisionBoxEnabled)
	scr_baddieCollisionBox();

if (y > (room_height + 64))
	instance_destroy();

if (state != enemystates.scared && state != enemystates.frozen)
	baddieScareBuffer = 0;

if (tauntBuffer)
{
	if (!instance_exists(tauntBufferEffect))
	{
		with (instance_create(x, y, obj_baddieAngryCloud, 
		{
			baddieID: id
		}))
			other.tauntBufferEffect = id;
	}
	
	if (!global.freezeframe)
	{
		if (obj_parent_player.state != (18 << 0) && obj_parent_player.state != (51 << 0) && state != enemystates.Throw)
		{
			tauntBuffer = false;
			enemyAttackTimer = 0;
			ragereset = 0;
			baddieStunTimer = 0;
			enemyAttackTimer = 0;
			burrowTimer = 0;
			baddieScareBuffer = 0;
		}
	}
}

if (state == enemystates.stun && baddieStunTimer >= 50 && !birdCreated && object_index != obj_coneboyCutout && object_index != obj_cherrycardboard)
{
	birdCreated = true;
	instance_create(x, y - 40, obj_enemyBirdEffect, 
	{
		baddieID: id
	});
}

if (doRedAfterImage && redAfterImagebuffer-- < 0)
{
	with (create_afterimage(afterimagetypes.red, image_xscale))
		image_alpha = 0.85;
	
	redAfterImagebuffer = redAfterImagebufferMax;
}

doRedAfterImage = false;
wetTimer = approach(wetTimer, 0, 1);

if (wetTimer > 0 && wetTimerEffect-- <= 0)
	wetTimerEffect = 3;

if (baddieInvincibilityBuffer > 0 && !global.freezeframe)
	baddieInvincibilityBuffer--;

if (global.freezeframe && state != enemystates.frozen)
{
	frozenState = state;
	frozenSpriteIndex = sprite_index;
	frozenImageIndex = image_index;
	frozenImageSpeed = image_speed;
	frozenMoveSpeed = movespeed;
	frozenGrav = grav;
	frozenHsp = hsp;
	frozenVsp = vsp;
	state = enemystates.frozen;
}

if (markedForDeath && !global.freezeframe && object_index != obj_iceblock)
{
	instance_destroy();
	create_particle(x, y, spr_genericPoofEffect);
}

if (flash && alarm[2] <= 0)
	alarm[2] = room_speed * 0.15;

if (state != enemystates.grabbed)
	depth = 0;

if (grounded && vsp > 0 && sprite_index == baddieSpriteWalk && sprite_animation_end() && sign(hsp) == sign(image_xscale))
	create_particle(x - (image_xscale * 20), y + 43, spr_cloudEffect);
