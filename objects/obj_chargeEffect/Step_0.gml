updateEffectPosition();

if (playerID.sprite_index == playerID.spr_dive || (playerID.state != states.shotgun && !(playerID.state == states.Nhookshot && playerID.movespeed >= 12) && !(playerID.state == states.climbdownwall && playerID.mach3Roll > 0) && playerID.state != states.backbreaker && playerID.sprite_index != spr_player_PZ_flicked))
	instance_destroy();
