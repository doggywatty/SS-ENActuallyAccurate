var target_player = get_primaryPlayer();

if (global.freezeframe || instance_exists(obj_cutsceneManager) || target_player.state == states.mach3)
	exit;

visible = !(target_player.sprite_index == target_player.spr_cottonIntroLeft || target_player.sprite_index == target_player.spr_cottonIntroRight);

if (target_player.state == states.bossintro || target_player.state == states.slipnslide || target_player.state == states.keyget || target_player.state == states.tackle)
	sprite_index = spr_cottonmakerzzz;
else
	sprite_index = spr_cottonmaker;
