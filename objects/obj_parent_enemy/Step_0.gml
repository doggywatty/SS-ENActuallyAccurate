scr_baddie_collide_destroyables();
downSlope = state != states.cheesepep;

if (doCollision && state != states.charge && state != states.cheeseball && state != states.cheesepepstick)
	scr_collision();

canBreakBlocks = false;

if (global.freezeframe && state != states.boxxedpep)
{
	frozenState = state;
	frozenSpriteIndex = sprite_index;
	frozenImageIndex = image_index;
	frozenImageSpeed = image_speed;
	frozenMoveSpeed = movespeed;
	frozenGrav = grav;
	frozenHsp = hsp;
	frozenVsp = vsp;
	state = states.boxxedpep;
}

switch (state)
{
	case states.frozen:
		state_enemyNormal();
		break;
	case states.normal:
		state_enemyTurn();
		break;
	case states.titlescreen:
		if (is_callable(enemyState_Attack))
		{
			scr_conveyorBeltKinematics();
			enemyState_Attack();
		}
		
		break;
	case states.Nhookshot:
		state_enemyScared();
		break;
	case states.slap:
		state_enemyStunned();
		break;
	case states.charge:
		if (baddieStunTimer < 200)
			baddieStunTimer = 200;
		
		vsp = 0;
		hsp = 0;
		movespeed = 0;
		sprite_index = baddieSpriteStun;
		image_speed = 0.35;
		grounded = false;
		break;
	case states.cheesepep:
		state_enemyHit();
		break;
	case states.cheeseball:
		state_enemyWaiting_Panic();
		break;
	case states.cheesepepstick:
		state_enemyWaiting_Box();
		break;
	case states.boxxedpep:
		if (markedForDeath)
			sprite_index = baddieSpriteStun;
		
		if (!global.freezeframe)
		{
			state = frozenState;
			sprite_index = frozenSpriteIndex;
			image_index = frozenImageIndex;
			image_speed = frozenImageSpeed;
			movespeed = frozenMoveSpeed;
			grav = frozenGrav;
			hsp = frozenHsp;
			vsp = frozenVsp;
		}
		else
		{
			vsp = 0;
			hsp = 0;
			grav = 0;
			image_speed = 0;
			movespeed = 0;
		}
		
		break;
	default:
		if (is_callable(enemyCustomStates))
			enemyCustomStates();
		
		break;
}

enemyAttackTimer = max(enemyAttackTimer - 1, 0);

if (baddieCollisionBoxEnabled)
	scr_baddieCollisionBox(baddieCollisionMask);

if (canGetScared)
	scr_scareenemy();

if (state != states.titlescreen)
	hasAttacked = false;

if (markedForDeath && !global.freezeframe && !obj_camera.NextFreeze)
{
	create_particle(x, y, spr_genericPoofEffect);
	instance_destroy();
}

if (y > (room_height + 64))
	instance_destroy();

if (hasSquashedX)
{
	squashValueX = approach(squashValueX, 0.4, 0.15);
	
	if (squashValueX >= 0.4)
		hasSquashedX = false;
}
else
{
	squashValueX = approach(squashValueX, 0, 0.05);
}

if (hasSquashedY)
{
	squashValueY = approach(squashValueY, 0.4, 0.15);
	
	if (squashValueY >= 0.4)
		hasSquashedY = false;
}
else
{
	squashValueY = approach(squashValueY, 0, 0.05);
}

if (flash && alarm[0] <= 0)
	alarm[0] = room_speed * 0.15;

if (tauntBuffer)
{
	if (obj_parent_player.state != states.gottreasure && obj_parent_player.state != states.gameover)
	{
		tauntBuffer = false;
		baddieStunTimer = 0;
		baddieScareBuffer = 0;
		enemyAttackTimer = 0;
		
		if (is_callable(enemyAttack_TriggerEvent))
			enemyAttack_TriggerEvent();
	}
}

if (state != states.Nhookshot && state != states.boxxedpep)
	baddieScareBuffer = 0;

if (doRedAfterImage && redAfterImagebuffer-- < 0)
{
	create_afterimage(afterimagetypes.red, image_xscale);
	redAfterImagebuffer = redAfterImagebufferMax;
}

doRedAfterImage = false;
wetTimer = approach(wetTimer, 0, 1);

if (wetTimer > 0 && wetTimerEffect-- <= 0)
	wetTimerEffect = 3;

if (baddieInvincibilityBuffer > 0 && !global.freezeframe)
	baddieInvincibilityBuffer--;

if (jumpedFromBlock && vsp >= 0 && grounded && invincibleBaddie)
{
	invincibleBaddie = false;
	jumpedFromBlock = false;
}

if (((grounded && vsp > 0) || isFlyingEnemy) && sprite_index == baddieSpriteWalk && sprite_animation_end() && sign(hsp) == sign(image_xscale))
	create_particle(x - (image_xscale * 20), y + 43, spr_cloudEffect);

scr_enemySounds_update();
