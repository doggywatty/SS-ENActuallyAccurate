event_inherited();
baddieSpriteIdle = spr_boxfrog_boxidle;
baddieSpriteWalk = spr_boxfrog_boxidle;
baddieSpriteStun = spr_boxfrog_stun;
baddieSpriteScared = spr_boxfrog_scared;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_boxfrog_die;
wearingBox = true;
oldWearingBox = wearingBox;
canGetScared = false;
defaultMovespeed = 0;
enemyAttackTimerMax = 120;

enemyAttack_TriggerEvent = function()
{
	if (enemyAttackTimer <= 0 && scr_enemy_playerisnear(400, 60) && grounded && state == States.frozen)
	{
		enemyAttackTimer = enemyAttackTimerMax;
		var _player = get_nearestPlayer();
		state = States.titlescreen;
		image_xscale = face_obj(_player);
		vsp = -8;
		movespeed = 4;
		hsp = image_xscale * movespeed;
		sprite_index = spr_boxfrog_jump;
		image_index = 0;
		wearingBox = false;
	}
};

enemyState_Attack = function()
{
	wearingBox = false;
	image_speed = 0.35;
	
	if (sprite_index == spr_boxfrog_land)
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
	
	hsp = image_xscale * movespeed;
	
	if (sprite_index == spr_boxfrog_jump && sprite_animation_end())
	{
		image_index = 0;
		sprite_index = spr_boxfrog_fall;
	}
	
	if grounded
	{
		sprite_index = spr_boxfrog_land;
		image_index = 0;
	}
};
