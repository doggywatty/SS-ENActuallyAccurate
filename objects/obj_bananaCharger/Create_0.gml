event_inherited();
substate = 0;
defaultMovespeed = 0;
baddieSpriteIdle = spr_banana_idle;
baddieSpriteWalk = spr_banana_charge;
baddieSpriteStun = spr_banana_stun;
baddieSpriteScared = spr_banana_scared;
baddieSpriteTurn = spr_banana_machturn;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_banana_dead;
enemyAttack_TriggerEvent = function()
{
	if (scr_enemy_playerisnear(400, 20) && grounded && state == States.frozen)
	{
		state = States.titlescreen;
		substate = 0;
		movespeed = 0;
		var _player = get_nearestPlayer();
		image_xscale = -getFacingDirection(_player.x, x);
		sprite_index = spr_banana_chargestart;
		image_index = 0;
		fmod_studio_event_instance_start(sndCharge);
	}
};
enemyState_Attack = function()
{
	image_speed = 0.35;
	hsp = image_xscale * movespeed;
	if (substate == 0)
	{
		var _player = get_nearestPlayer();
		movespeed = (sprite_index == spr_banana_chargestart) ? 0 : 8;
		if (sprite_animation_end() && sprite_index == spr_banana_chargestart)
		{
			movespeed = 8;
			sprite_index = spr_banana_charge;
		}
		var turn_check = false;
		if (place_meeting_solid(x + image_xscale, y))
		{
		}
		if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES) || (place_meeting(x + image_xscale, y, obj_clutterCone) && !place_meeting(x, y, obj_clutterCone)))
			turn_check = true;
		if (place_meeting(x + image_xscale, y, obj_hallway))
		{
			var hallway_direction = -sign(instance_place(x + sign(image_xscale), y, obj_hallway).image_xscale);
			if (sign(other.image_xscale) != hallway_direction)
				turn_check = true;
		}
		if turn_check
			image_xscale *= -1;
		var dir = sign(_player.x - x);
		if (image_xscale == -dir && grounded && point_distance(x, 0, _player.x, 0) >= 50)
		{
			substate = 1;
			sprite_index = spr_banana_machturn;
			image_index = 0;
		}
		if (sprite_index == spr_banana_turnboost && sprite_animation_end())
			sprite_index = spr_banana_charge;
	}
	if (substate == 1)
	{
		movespeed = (1 - (image_index / image_number)) * 6;
		if (sprite_animation_end() && !grounded)
		{
			image_speed = 0;
			movespeed = approach(movespeed, 0, 0.2);
		}
		if ((sprite_animation_end() && grounded) || (image_speed == 0 && grounded))
		{
			image_xscale *= -1;
			movespeed = 8;
			substate = 0;
			sprite_index = spr_banana_turnboost;
			image_speed = 0.35;
		}
	}
};
