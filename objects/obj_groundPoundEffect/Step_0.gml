updateEffectPosition();

if (playerID.state != states.slam && playerID.state != states.pal && playerID.state != states.cheesepep && playerID.state != states.highjump && playerID.state != states.secondjump)
	instance_destroy();

if (playerID.state == states.secondjump && playerID.sprite_index == playerID.spr_piledriverland)
	instance_destroy();
