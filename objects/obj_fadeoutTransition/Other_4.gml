if (!instance_exists(obj_parent_player))
	exit;

if (obj_parent_player.state == states.titlescreen)
{
	obj_parent_player.vsp = 5;
	obj_parent_player.xscale = 1;
	obj_parent_player.movespeed = 11;
	obj_parent_player.state = states.gottreasure;
	obj_parent_player.sprite_index = spr_player_PZ_freeFallSpin;
}
