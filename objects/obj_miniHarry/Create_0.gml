event_inherited();
baddieSpriteIdle = undefined;
baddieSpriteWalk = spr_miniharry_walk;
baddieSpriteStun = spr_miniharry_stun;
baddieSpriteScared = spr_miniharry_spot;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_miniharry_dead;
canGetScared = false;
slide = 0;

enemyAttack_TriggerEvent = function()
{
	if (scr_enemy_playerisnear(400, 20) && grounded && state == States.frozen)
	{
		slide = 0;
		state = States.titlescreen;
		movespeed = 0;
		var _player = get_nearestPlayer();
		image_xscale = face_obj(_player);
		sprite_index = spr_miniharry_spot;
		image_index = 0;
		fmod_studio_event_instance_start(sndCharge);
	}
};

enemyState_Attack = function()
{
	image_speed = 0.35;
	hsp = image_xscale * movespeed;
	hsp += slide;
	slide = approach(slide, 0, 0.2);
	var _player = get_nearestPlayer();
	movespeed = (sprite_index == spr_miniharry_spot) ? 0 : 8;
	
	if (sprite_animation_end() && sprite_index == spr_miniharry_spot)
	{
		movespeed = 8;
		sprite_index = spr_miniharry_run;
	}
	
	var turn_check = false;
	if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES) || (place_meeting(x + image_xscale, y, obj_clutterCone) && !place_meeting(x, y, obj_clutterCone)))
		turn_check = true;
	
	if (place_meeting(x + image_xscale, y, obj_hallway))
	{
		var hallway_direction = -sign(instance_place(x + sign(image_xscale), y, obj_hallway).image_xscale);
		if (sign(other.image_xscale) != hallway_direction)
			turn_check = true;
	}
	
	if turn_check
	{
		image_xscale *= -1;
		slide = -image_xscale * (movespeed + 4);
	}
	
	if (grounded && sprite_index != spr_miniharry_spot)
		vsp = -4;
	
	var target_player = get_nearestPlayer();
	var playerposition = x - target_player.x;
	if (playerposition != 0 && image_xscale != -sign(playerposition))
	{
		image_xscale = -sign(playerposition);
		slide = -image_xscale * (movespeed + 4);
	}
};
