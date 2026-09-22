  event_inherited();
grav = 0.5;
hsp = 1;
vsp = 0;
movespeed = 0;
state = enemystates.float;
baddieStunTimer = 0;
alarm[0] = 150;
canRoam = true;
hitboxID = noone;
flying = 0;
straightthrow = 0;
hitboxcreate = 0;

enemyDeath_SpawnBody = function()
{
	instance_create(x, y, obj_candyCornEffect, 
	{
		image_xscale: image_xscale
	});
};

thrown = 0;
reset = 0;
flash = false;
baddieSpriteIdle = spr_snowcloudstun;
baddieSpriteStun = spr_snowcloudstun;
baddieSpriteWalk = spr_snowcloudwalk;
baddieSpriteTurn = spr_snowcloudwalk;
baddieSpriteGrabbed = spr_snowcloudstun;
baddieSpriteScared = spr_snowcloudscared;
baddieSpriteDead = spr_snowclouddead;
hp = 1;
slapped = 0;
grounded = 1;
birdCreated = 0;
boundbox = 0;
idletimer = 200;
substate = 0;
enemyAttackTimer = 0;
