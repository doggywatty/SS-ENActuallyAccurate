function state_enemyNormal()
{
	image_speed = 0.35;
	if (!isFlyingEnemy && !grounded)
	{
		hsp = 0;
		movespeed = 0;
	}
	if grounded || isFlyingEnemy
		movespeed = approach(movespeed, defaultMovespeed, defaultMovespeedAcc ?? max(abs(movespeed), abs(defaultMovespeed)));
	hsp = image_xscale * movespeed;
	if isFlyingEnemy
	{
		vsp = 0;
		var dist_start_pos = sign(ystart - y);
		if (!place_meeting_collision(x, y + dist_start_pos))
			y += dist_start_pos;
	}
	scr_conveyorBeltKinematics();
	if grounded || isFlyingEnemy
	{
		if !is_undefined(baddieSpriteIdle) && movespeed == 0
			sprite_index = baddieSpriteIdle;
		else
			sprite_index = baddieSpriteWalk;
	}
	if (canTurnSelf && movespeed > 0 && turnTimer-- < 0)
	{
		scr_enemy_turn_trigger();
		exit;
	}
	if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES) || (place_meeting(x + image_xscale, y, obj_clutterCone) && !place_meeting(x, y, obj_clutterCone)))
	{
		scr_enemy_turn_trigger();
		exit;
	}
	if (place_meeting(x + image_xscale, y, obj_hallway))
	{
		var hallway_direction = -sign(instance_place(x + sign(image_xscale), y, obj_hallway).image_xscale);
		if (sign(other.image_xscale) != hallway_direction)
		{
			scr_enemy_turn_trigger();
			exit;
		}
	}
	
	var _bbox_side = (image_xscale >= 1) ? bbox_right : bbox_left;
	if (!isFlyingEnemy && grounded && movespeed > 0
	&& !place_meeting_collision(_bbox_side + image_xscale, y + 31)
	&& !place_meeting_slopePlatform(_bbox_side + image_xscale, y + 31))
	{
		scr_enemy_turn_trigger();
		exit;
	}
}

function state_enemyTurn()
{
	sprite_index = baddieSpriteTurn;
	image_speed = 0.35;
	movespeed = approach(movespeed, 0, defaultMovespeedDecc ?? movespeed);
	hsp = -image_xscale * movespeed;
	scr_conveyorBeltKinematics();
	if isFlyingEnemy
		vsp = 0;
	if sprite_animation_end()
	{
		hsp = 0;
		movespeed = defaultMovespeed;
		image_index = 0;
		sprite_index = baddieSpriteWalk;
		image_xscale *= -1;
		state = States.frozen;
		exit;
	}
}

function state_enemyScared()
{
	image_speed = 0.35;
	movespeed = 0;
	hsp = image_xscale * movespeed;
	if isFlyingEnemy
		vsp = 0;
	baddieScareBuffer--;
	if (baddieScareBuffer <= 0)
	{
		state = States.frozen;
		sprite_index = baddieSpriteWalk;
		baddieScareBuffer = 0;
		scare_jump = false;
	}
	scr_conveyorBeltKinematics();
}

function state_enemyStunned()
{
	baddieStunTimer--;
	movespeed = 0;
	sprite_index = baddieSpriteStun;
	image_speed = 0.35;
	if grounded
	{
		hsp = approach(hsp, 0, 0.3);
		scr_conveyorBeltKinematics();
		if (abs(hsp) > 4 && !instance_exists(dashCloudID))
		{
			dashCloudID = instance_create(x, y, obj_dashCloud, 
			{
				image_xscale: sign(hsp)
			});
		}
	}
	if (grounded && baddieStunTimer < 0)
	{
		image_index = 0;
		state = States.frozen;
		sprite_index = baddieSpriteWalk;
	}
}

function state_enemyHit()
{
	sprite_index = baddieSpriteHit ?? baddieSpriteDead;
	baddieStunTimer = 500;
	image_speed = 0.35;
	with (create_afterimage(AfterImageType.plain, image_xscale))
	{
		image_alpha = 0.6;
		vanish = true;
	}
	movespeed = 0;
	hsp = hitHsp;
	vsp = hitVsp;
	var impact_test = false;
	if (hitHsp != 0 && (place_meeting_collision(x + sign(hitHsp), y) || place_meeting(x + sign(hitHsp), y, obj_hallway)) && !place_meeting(x + sign(hitHsp), y, obj_destructibles))
	{
		vsp = -5;
		impact_test = true;
	}
	if (hitVsp != 0 && (place_meeting_collision(x, y - 1) || place_meeting(x, y - 1, obj_vertical_hallway)) && !place_meeting(x, y + hitVsp, obj_destructibles))
	{
		vsp = 5;
		impact_test = true;
	}
	if impact_test
	{
		if canBeKilled
		{
			instance_destroy();
			exit;
		}
		state = States.charge;
		exit;
	}
}

function state_enemyWaiting_Panic()
{
	visible = false;
	hsp = 0;
	vsp = 0;
	x = -900;
	y = -200;
	invincibleBaddie = true;
	if (escapeEnemy && global.panic)
	{
		var _player = get_nearestPlayer();
		if (!instance_exists(escapePortalEffect) && point_in_rectangle(xstart, ystart, _player.x - 500,
		_player.y - 100, _player.x + 500, _player.y + 100))
		{
			escapePortalEffect = instance_create(xstart, ystart, obj_panicPortal, 
			{
				baddieID: id
			});
		}
	}
}

function state_enemyWaiting_Box()
{
	visible = false;
	hsp = 0;
	vsp = 0;
	x = -900;
	y = -200;
	invincibleBaddie = true;
	if !place_meeting(xstart, ystart, obj_bigdestructibles)
	{
		x = xstart;
		y = ystart;
		visible = true;
		jumpedFromBlock = true;
		hasSquashedX = true;
		squashValueX = 0;
		baddieStunTimer = 3;
		vsp = -8;
		grounded = false;
		state = States.charge;
		sprite_index = baddieSpriteWalk;
	}
}

function scr_enemyThrowDefault(_spr_ind, _frmarg1, _img_spd, _func)
{
	image_speed = _img_spd;
	sprite_index = _spr_ind;
	enemyAttackTimer = enemyAttackTimerMax;
	if isFlyingEnemy
		vsp = 0;
	if !grounded
		hsp = approach(hsp, 0, 0.1);
	else
		hsp = 0;
	scr_conveyorBeltKinematics();
	if (!hasAttacked && sprite_animation_end(sprite_index, image_index, _frmarg1))
	{
		event_play_oneshot("event:/SFX/enemies/projectile", x, y);
		_func();
		hasAttacked = true;
	}
	if sprite_animation_end()
	{
		hsp = 0;
		movespeed = defaultMovespeed;
		image_index = 0;
		sprite_index = baddieSpriteWalk;
		state = States.frozen;
		exit;
	}
}
