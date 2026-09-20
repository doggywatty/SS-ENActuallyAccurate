updateEffectPosition();

if ((playerID.state != PlayerState.climbwall && playerID.state != PlayerState.Sjump) || playerID.sprite_index == playerID.spr_superjumpCancelIntro)
	instance_destroy();
