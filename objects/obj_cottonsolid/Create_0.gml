canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			return arg1.state != PlayerState.cottondig && arg1.sprite_index != spr_player_PZ_werecotton_spin;
			break;
		default:
			return true;
			break;
	}
};
