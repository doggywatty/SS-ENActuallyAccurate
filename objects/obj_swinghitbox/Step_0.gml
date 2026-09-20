x = playerID.x;
y = playerID.y;

if (mach && playerID.state != PlayerState.mach3 && !global.freezeframe)
	instance_destroy();
