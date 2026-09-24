switch (state)
{
	case EnemyState.idle:
		scr_enemy_idle();
		break;
	case EnemyState.turn:
		scr_enemy_turn();
		break;
	case EnemyState.walk:
		scr_enemy_walk();
		break;
	case EnemyState.hit:
		scr_enemy_hit();
		break;
	case EnemyState.charge:
		scr_enemy_charge();
		break;
	case EnemyState.stun:
		scr_enemy_stun();
		break;
	case EnemyState.frozen:
		scr_enemy_frozen();
		break;
	case EnemyState.unknownreset:
		hsp = 0;
		vsp = 0;
		break;
	case EnemyState.float:
		scr_enemy_float();
		break;
	case EnemyState.thief:
		scr_enemy_thief();
		break;
	case EnemyState.panicWait:
		scr_enemy_panicWait();
		break;
	case EnemyState.secretWait:
		scr_enemy_secretWait();
		break;
	case EnemyState.Throw:
		scr_enemy_throw();
		break;
	case EnemyState.grabbed:
		scr_enemy_grabbed();
		break;
	case EnemyState.scared:
		scr_enemy_scared();
		break;
	case EnemyState.cherryWait:
		scr_enemy_cherrywait();
		break;
	case EnemyState.charcherry:
		scr_enemy_charcherry();
		break;
	case EnemyState.slugjump:
		scr_enemy_slugjump();
		break;
	case EnemyState.slugparry:
		scr_enemy_slugparry();
		break;
	case EnemyState.eyescreamWait:
		scr_enemy_eyescreamwait();
		break;
	case EnemyState.eyescream:
		scr_enemy_eyescream();
		break;
	case EnemyState.rage:
		scr_enemy_rage();
		break;
}

if (baddieCollisionBoxEnabled)
	scr_baddieCollisionBox();

if (y > (room_height + 64))
	instance_destroy();

if (state != EnemyState.scared && state != EnemyState.frozen)
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
		if (obj_parent_player.state != PlayerState.taunt && obj_parent_player.state != PlayerState.parry && state != EnemyState.Throw)
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

if (state == EnemyState.stun && baddieStunTimer >= 50 && !birdCreated && object_index != obj_coneboyCutout && object_index != obj_cherrycardboard)
{
	birdCreated = true;
	instance_create(x, y - 40, obj_enemyBirdEffect, 
	{
		baddieID: id
	});
}

if (doRedAfterImage && redAfterImagebuffer-- < 0)
{
	with (create_afterimage(AfterImageType.BADDIE, image_xscale))
		image_alpha = 0.85;
	
	redAfterImagebuffer = redAfterImagebufferMax;
}

doRedAfterImage = false;
wetTimer = approach(wetTimer, 0, 1);

if (wetTimer > 0 && wetTimerEffect-- <= 0)
	wetTimerEffect = 3;

if (baddieInvincibilityBuffer > 0 && !global.freezeframe)
	baddieInvincibilityBuffer--;

if (global.freezeframe && state != EnemyState.frozen)
{
	frozenState = state;
	frozenSpriteIndex = sprite_index;
	frozenImageIndex = image_index;
	frozenImageSpeed = image_speed;
	frozenMoveSpeed = movespeed;
	frozenGrav = grav;
	frozenHsp = hsp;
	frozenVsp = vsp;
	state = EnemyState.frozen;
}

if (markedForDeath && !global.freezeframe && object_index != obj_iceblock)
{
	instance_destroy();
	create_particle(x, y, spr_genericPoofEffect);
}

if (flash && alarm[2] <= 0)
	alarm[2] = room_speed * 0.15;

if (state != EnemyState.grabbed)
	depth = 0;

if (grounded && vsp > 0 && sprite_index == baddieSpriteWalk && sprite_animation_end() && sign(hsp) == sign(image_xscale))
	create_particle(x - (image_xscale * 20), y + 43, spr_cloudEffect);
