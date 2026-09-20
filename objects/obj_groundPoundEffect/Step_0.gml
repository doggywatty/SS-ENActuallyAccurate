updateEffectPosition();

if (playerID.state != PlayerState.freefall && playerID.state != PlayerState.frostburnjump && playerID.state != PlayerState.climbwall && playerID.state != PlayerState.Sjump && playerID.state != PlayerState.superslam)
	instance_destroy();

if (playerID.state == PlayerState.superslam && playerID.sprite_index == playerID.spr_piledriverland)
	instance_destroy();
