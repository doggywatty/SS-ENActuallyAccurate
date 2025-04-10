event_inherited();
baddieSpriteIdle = spr_swed;
baddieSpriteWalk = spr_swed;
baddieSpriteStun = spr_swedstun;
baddieSpriteScared = spr_swedscared;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_sweddead;
isFlyingEnemy = true;
enemyAttackTimerMax = 250;
defaultMovespeed = 0;

enemyAttack_TriggerEvent = function()
{
	if (scr_enemy_playerisnear(400, 60) && state == States.frozen && enemyAttackTimer <= 0)
	{
		enemyAttackTimer = enemyAttackTimerMax;
		state = States.titlescreen;
		movespeed = 0;
		var _player = get_nearestPlayer();
		image_xscale = face_obj(_player);
		sprite_index = spr_swed_chargestart;
		image_index = 0;
		fmod_studio_event_instance_start(sndCharge);
	}
};

enemyState_Attack = function()
{
	image_speed = 0.35;
	hsp = image_xscale * movespeed;
	vsp = 0;
	var _player = get_nearestPlayer();
	movespeed = (sprite_index == spr_swed_chargestart) ? 0 : 10;
	
	if (sprite_animation_end() && sprite_index == spr_swed_chargestart)
	{
		movespeed = 10;
		sprite_index = spr_swed_charge;
	}
	
	var wall_check = false;
	if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES) || (place_meeting(x + image_xscale, y, obj_clutterCone) && !place_meeting(x, y, obj_clutterCone)))
		wall_check = true;
	
	if (place_meeting(x + image_xscale, y, obj_hallway))
	{
		var hallway_direction = -sign(instance_place(x + sign(image_xscale), y, obj_hallway).image_xscale);
		if (sign(other.image_xscale) != hallway_direction)
			wall_check = true;
	}
	
	if wall_check
	{
		hsp = sign(image_xscale) * -3;
		vsp = -3;
		image_xscale *= -1;
		sprite_index = baddieSpriteStun;
		state = States.charge;
		baddieStunTimer = 100;
	}
};
