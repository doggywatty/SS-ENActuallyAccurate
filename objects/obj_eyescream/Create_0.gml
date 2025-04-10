event_inherited();
grav = 0;
hsp = 0;
vsp = 0;
movespeed = 1;
state = EnemyStates.eyescreampopout;
lerpamt = 0.2;
substate = 0;
targety = 0;
randomx = irandom_range(50, 100);
randomy = irandom_range(100, 200);
timer = irandom_range(60, 180);
cancollide = false;
maxtime = timer;
baddieStunTimer = 0;
alarm[0] = 150;
canRoam = true;
flying = 0;
straightthrow = 0;
thrown = 0;
reset = 0;
flash = false;
baddieSpriteIdle = spr_gumslime_stun;
baddieSpriteStun = spr_gumslime_stun;
baddieSpriteWalk = spr_gumslime_walk;
baddieSpriteTurn = spr_gumslime_walk;
baddieSpriteGrabbed = spr_eyescreamsandwich_dead;
baddieSpriteScared = spr_eyescreamsandwich_dead;
baddieSpriteDead = spr_eyescreamsandwich_dead;
hp = 10;
slapped = 0;
grounded = 1;
birdCreated = 0;
boundbox = 0;
idletimer = 200;

faceTowardsPlayerFunc = function()
{
	var target_player = get_nearestPlayer();
	image_xscale = sign(target_player.x - x);
	if (image_xscale == 0)
		image_xscale = target_player.image_xscale;
	if (image_xscale == 0)
		image_xscale = 1;
};
