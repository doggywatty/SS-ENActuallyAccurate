event_inherited();
baddieSpriteIdle = undefined;
baddieSpriteWalk = spr_cottonblimp;
baddieSpriteStun = spr_cottonblimp_stun;
baddieSpriteScared = spr_cottonblimp;
baddieSpriteTurn = undefined;
baddieSpriteHit = spr_cottonblimp_stun;
baddieSpriteDead = spr_cottonblimp_dead;
canTurnSelf = true;
canGetScared = false;
isFlyingEnemy = true;
defaultMovespeed = 2;
turnTimerMax = 200;
turnTimer = turnTimerMax;
enemyAttackTimerMax = 300;

enemyAttack_TriggerEvent = function()
{
	if (enemyAttackTimer <= 0 && scr_enemy_playerisnear(60, 350) && state == States.frozen)
	{
		enemyAttackTimer = enemyAttackTimerMax;
		state = States.titlescreen;
		sprite_index = spr_cottonblimp_shoot;
		image_index = 0;
	}
};

enemyState_Attack = function()
{
	scr_enemyThrowDefault(spr_cottonblimp_shoot, 7, 0.35, function()
	{
		var y_offset = place_meeting_collision(x, y + 20) ? 0 : 20;
		instance_create(x, y + y_offset, obj_blimp_proj, 
		{
			baddieID: id,
			image_xscale: image_xscale,
			image_angle: image_angle
		});
	});
};

enemyDeath_SpawnBody = function()
{
	with instance_create(x, y, obj_baddieDead)
	{
		image_xscale = other.image_xscale;
		image_blend = other.image_blend;
		sprite_index = other.baddieSpriteDead;
		paletteSprite = other.paletteSprite;
		paletteSelect = other.paletteSelect;
	}
	instance_create(x, y, obj_bombExplosionPlayer, 
	{
		hurtBaddies: false
	});
};
