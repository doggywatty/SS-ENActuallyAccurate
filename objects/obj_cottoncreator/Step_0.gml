var target_player = get_primaryPlayer();
if (global.freezeframe || instance_exists(obj_cutsceneManager) || target_player.state == States.actor)
	exit;

visible = !(target_player.sprite_index == target_player.spr_cottonIntroLeft || target_player.sprite_index == target_player.spr_cottonIntroRight);

if (target_player.state == States.cotton || target_player.state == States.cottondig || target_player.state == States.cottondrill || target_player.state == States.cottonroll)
	sprite_index = spr_cottonmakerzzz;
else
	sprite_index = spr_cottonmaker;
