event_inherited();

canCollide = function(player = obj_parent_player)
{
	switch player
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? player.frozenState : player.state;
			return !place_meeting(x, y, player) || _state == States.climbwall || _state == States.machslide;
			break;
		case obj_escaperosette:
			return false;
			break;
		default:
			return !place_meeting(x, y, player);
			break;
	}
};

scr_collision_init();
grav = 0.5;
dhsp = 0;
dvsp = 0;
spinspeed = 0;
