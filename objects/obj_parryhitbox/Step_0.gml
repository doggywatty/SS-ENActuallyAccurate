if (playerID.state != States.taunt && playerID.state != States.parry)
	instance_destroy();

image_xscale = playerID.xscale;
x = playerID.x;
y = playerID.y;

if (parryTimer-- <= 0)
	instance_destroy();