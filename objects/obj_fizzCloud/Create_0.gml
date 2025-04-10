event_inherited();

enemyDeath_SpawnBody = function()
{
	instance_create(x, y, obj_thundercloudeffect, 
	{
		image_xscale: image_xscale
	});
};

grav = 0.5;
hsp = 1;
vsp = 0;
movespeed = 5;
state = EnemyStates.float;
baddieStunTimer = 0;
alarm[0] = 150;
canRoam = true;
flying = 0;
straightthrow = 0;
thrown = 0;
reset = 0;
flash = false;
baddieSpriteIdle = spr_thundercloud_stun;
baddieSpriteStun = spr_thundercloud_stun;
baddieSpriteWalk = spr_thundercloud;
baddieSpriteTurn = spr_thundercloud;
baddieSpriteGrabbed = spr_thundercloud_stun;
baddieSpriteScared = spr_thundercloud_scared;
baddieSpriteDead = spr_thundercloud_dead;
spr_throw = spr_thundercloud_throw;
throw_frame = 9;
enemyAttackTimer = 100;
hp = 1;
slapped = 0;
grounded = 1;
birdCreated = 0;
boundbox = 0;
idletimer = 200;
substate = 0;
roomname = room_get_name(room);
paletteSprite = spr_thundercloud_pal;

for (var i = 0; i < 11; i++)
{
	if (roomname == ("mountain_" + string(i)) && i < 7)
		paletteSelect = 0;
	
	if (roomname == ("mountain_" + string(i)) && i > 6)
	{
		paletteSelect = 1;
		if (roomname == ("mountain_" + string(i)) && i > 7)
			paletteSelect = 2;
	}
}

if (roomname == "mountain_escape1")
	paletteSelect = 2;
