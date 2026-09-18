x = playerID.x;
y = playerID.y;

if (mach && playerID.state != states.shotgun && !global.freezeframe)
	instance_destroy();
