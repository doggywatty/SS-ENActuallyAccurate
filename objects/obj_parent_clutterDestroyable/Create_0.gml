event_inherited();
canCollide = function(stpl, player = obj_parent_player)
{
	var in_object = false;
	with player
		in_object = place_meeting(xprevious, yprevious, stpl);
	switch player.object_index
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? player.frozenState : player.state;
			return !in_object || _state == States.climbwall || _state == States.machslide;
			break;
		case obj_escaperosette:
			return false;
			break;
		default:
			return !in_object;
			break;
	}
};
scr_collision_init();
grav = 0.5;
dhsp = 0;
dvsp = 0;
spinspeed = 0;