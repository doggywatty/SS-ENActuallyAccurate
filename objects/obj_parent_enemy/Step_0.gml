scr_baddie_collide_destroyables();
downSlope = state != States.climbwall;

if (doCollision && state != States.stun && state != States.wallkick && state != States.machtumble)
	scr_collision();

canBreakBlocks = false;

if (global.freezeframe && state != States.freezeframe)
{
	frozenState = state;
	frozenSpriteIndex = sprite_index;
	frozenImageIndex = image_index;
	frozenImageSpeed = image_speed;
	frozenMoveSpeed = movespeed;
	frozenGrav = grav;
	frozenHsp = hsp;
	frozenVsp = vsp;
	state = States.freezeframe;
}

switch state
{
	case States.frozen:
		state_enemyNormal();
		break;
	case States.normal:
		state_enemyTurn();
		break;
	case States.titlescreen:
		if (is_callable(enemyState_Attack))
		{
			scr_conveyorBeltKinematics();
			enemyState_Attack();
		}
		
		break;
	case States.run:
		state_enemyScared();
		break;
	case States.charge:
		state_enemyStunned();
		break;
	case States.stun:
		if (baddieStunTimer < 200)
			baddieStunTimer = 200;
		vsp = 0;
		hsp = 0;
		movespeed = 0;
		sprite_index = baddieSpriteStun;
		image_speed = 0.35;
		grounded = false;
		break;
	case States.climbwall:
		state_enemyHit();
		break;
	case States.wallkick:
		state_enemyWaiting_Panic();
		break;
	case States.machtumble:
		state_enemyWaiting_Box();
		break;
	case States.freezeframe:
		if markedForDeath
			sprite_index = baddieSpriteStun;
		if !global.freezeframe
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

if baddieCollisionBoxEnabled
	scr_baddieCollisionBox(baddieCollisionMask);
if canGetScared
	scr_scareenemy();
if (state != States.titlescreen)
	hasAttacked = false;

if (markedForDeath && !global.freezeframe && !obj_camera.NextFreeze)
{
	create_particle(x, y, spr_genericPoofEffect);
	instance_destroy();
}

if (y > (room_height + 64))
	instance_destroy();

if hasSquashedX
{
	squashValueX = approach(squashValueX, 0.4, 0.15);
	if (squashValueX >= 0.4)
		hasSquashedX = false;
}
else
	squashValueX = approach(squashValueX, 0, 0.05);

if hasSquashedY
{
	squashValueY = approach(squashValueY, 0.4, 0.15);
	if (squashValueY >= 0.4)
		hasSquashedY = false;
}
else
	squashValueY = approach(squashValueY, 0, 0.05);

if (flash && alarm[0] <= 0)
	alarm[0] = room_speed * 0.15;

if tauntBuffer
{
	if (obj_parent_player.state != States.taunt && obj_parent_player.state != States.parry)
	{
		tauntBuffer = false;
		baddieStunTimer = 0;
		baddieScareBuffer = 0;
		enemyAttackTimer = 0;
		if (is_callable(enemyAttack_TriggerEvent))
			enemyAttack_TriggerEvent();
	}
}

if (state != States.run && state != States.freezeframe)
	baddieScareBuffer = 0;

if (doRedAfterImage && redAfterImagebuffer-- < 0)
{
	create_afterimage(AfterImageType.baddie, image_xscale);
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
