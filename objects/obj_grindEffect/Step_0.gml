x = playerID.x;
y = playerID.y;

if ((playerID.state != states.chainsawbump && playerID.state != states.victory) || !playerID.grounded)
	instance_destroy();
