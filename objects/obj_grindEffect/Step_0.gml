x = playerID.x;
y = playerID.y;

if ((playerID.state != PlayerState.grind && playerID.state != PlayerState.minecart) || !playerID.grounded)
	instance_destroy();
