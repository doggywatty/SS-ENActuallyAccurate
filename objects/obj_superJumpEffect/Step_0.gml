updateEffectPosition();

if ((playerID.state != states.cheesepep && playerID.state != states.highjump) || playerID.sprite_index == playerID.spr_superjumpCancelIntro)
	instance_destroy();
