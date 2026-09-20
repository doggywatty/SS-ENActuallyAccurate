x = playerID.x;
y = playerID.y;
image_xscale = playerID.xscale;

if (playerID.state != PlayerState.mach3)
	instance_destroy();
