if (obj_parent_player.state == states.frozen)
	fadealpha = approach(fadealpha, 0.75, 0.05);
else
	fadealpha = approach(fadealpha, -0.0000001, 0.05);

if (fadealpha <= -0.0000001)
	instance_destroy();
