event_inherited();
baddieSpriteIdle = undefined;
baddieSpriteWalk = spr_sluggy;
baddieSpriteStun = spr_sluggy_stunned;
baddieSpriteScared = spr_sluggy_scared;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_sluggy_dead;
wasInAir = false;
slide = 0;
burrowTimerMax = 50;
burrowTimer = burrowTimerMax;
digOverlayEffect = new subSprite(spr_sluggy_dugDirt, irandom_range(0, sprite_get_number(spr_sluggy_dugDirt)), 0);
digDustEffect = -4;

jumpEvent = function(statement = true)
{
	if event_instance_isplaying(sndSluggyDig)
		fmod_studio_event_instance_stop(sndSluggyDig, false);
	else if (state != States.burrow)
		event_play_oneshot("event:/SFX/enemies/sluggyJump", x, y);		
	enemyAttackTimer = enemyAttackTimerMax;
	if statement
	{
		var _player = get_nearestPlayer();
		image_xscale = face_obj(_player);
	}
	
	sprite_index = (state == States.burrow) ? spr_sluggy_undergroundjumpstart : spr_sluggy_jumpstart;
	image_index = 0;
	burrowTimer = 0;
	state = States.titlescreen;
};

enemyAttack_TriggerEvent = function()
{
	if (enemyAttackTimer <= 0 && scr_enemy_playerisnear(200, 200, undefined, 16) && grounded && (state == States.burrow || state == States.frozen))
		jumpEvent();
};

enemyState_Attack = function()
{
	image_speed = 0.35;
	hsp = image_xscale * movespeed;
	
	if (sprite_index == spr_sluggy_land)
	{
		enemyAttackTimer = enemyAttackTimerMax;
		hsp = 0;
		movespeed = 0;
		
		if (sprite_animation_end())
		{
			state = States.frozen;
			sprite_index = baddieSpriteWalk;
		}
		exit;
	}
	
	if (sprite_index == spr_sluggy_undergroundjumpstart || sprite_index == spr_sluggy_jumpstart)
	{
		movespeed = approach(movespeed, 0, 0.5);
		
		if (sprite_animation_end())
		{
			sprite_index = spr_sluggy_jump;
			image_index = 0;
			vsp = -11;
		}
		exit;
	}
	
	if (sprite_index == spr_sluggy_jump)
		movespeed = 4;
	
	if grounded
	{
		sprite_index = spr_sluggy_land;
		image_index = 0;
	}
};

enemyCustomStates = function()
{
	enemyAttackTimer = 0;
	image_speed = 0.35;
	scr_conveyorBeltKinematics();
	
	if (sprite_index == spr_sluggy_burrow)
	{
		hsp = 0;
		fmod_studio_event_instance_start(sndSluggyDig);
		
		if (sprite_animation_end())
			sprite_index = spr_sluggy_underground;
		exit;
	}
	
	hsp = (image_xscale * movespeed) + slide;
	slide = approach(slide, 0, 0.2);
	movespeed = 8;
	var target_player = get_nearestPlayer(x, y);
	var playerposition = x - target_player.x;
	var player_present = target_player.x > (x - 40) && target_player.x < (x + 40) && y <= (target_player.y + 250) && y >= (target_player.y - 30);
	if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES))
		slide = -image_xscale * (movespeed + 4);
	
	if (playerposition != 0 && image_xscale != -sign(playerposition))
	{
		image_xscale = -sign(playerposition);
		slide = -image_xscale * (movespeed + 4);
	}
	
	enemyAttack_TriggerEvent();
	
	if !instance_exists(digDustEffect) && grounded
	{
		digDustEffect = instance_create(x, y, obj_dashCloud, 
		{
			sprite_index: spr_dirtDigEffect,
			image_xscale: image_xscale
		});
	}
	
	if !place_meeting(x, y + 1, obj_dirtpatch)
		jumpEvent(false);
};

enemyDraw_extra = function()
{
	var is_underground = grounded && (sprite_index == spr_sluggy_underground || (sprite_index == spr_sluggy_undergroundjumpstart && image_index <= 6) || (sprite_index == spr_sluggy_burrow && image_index >= 6));
	if is_underground
	{
		digOverlayEffect.draw(x, y, sign(image_xscale), 1, 0, c_white, 1);
		digOverlayEffect.update((abs(hsp) / 8) * 0.5);
	}
};
