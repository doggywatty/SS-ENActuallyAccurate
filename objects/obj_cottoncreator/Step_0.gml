var target_player = get_primaryPlayer();

if (global.freezeframe || instance_exists(obj_cutsceneManager) || target_player.state == PlayerState.actor)
	exit;

visible = !(target_player.sprite_index == target_player.spr_cottonIntroLeft || target_player.sprite_index == target_player.spr_cottonIntroRight);

if (target_player.state == PlayerState.cotton || target_player.state == PlayerState.cottondig || target_player.state == PlayerState.cottondrill || target_player.state == PlayerState.cottonroll)
	sprite_index = spr_cottonmakerzzz;
else
	sprite_index = spr_cottonmaker;
