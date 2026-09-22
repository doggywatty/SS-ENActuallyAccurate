canCollide = function(stpl, _player = obj_parent_player)
{
	switch (_player.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			return _player.state != PlayerState.cottondig && _player.sprite_index != spr_player_PZ_werecotton_spin;
			break;
		default:
			return true;
			break;
	}
};
