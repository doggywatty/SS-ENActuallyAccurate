if (playerID.state != states.gottreasure && playerID.state != states.gameover)
	instance_destroy();

image_xscale = playerID.xscale;
x = playerID.x;
y = playerID.y;

if (parryTimer-- <= 0)
	instance_destroy();
