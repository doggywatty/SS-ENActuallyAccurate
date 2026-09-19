//PADDINGPADDINGPADDINGPADDI
event_inherited();

canCollide = function(arg0, arg1 = obj_parent_player)
{
	var in_object = false;
	
	with (arg1)
		in_object = place_meeting(xprevious, yprevious, arg0);
	
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? arg1.frozenState : arg1.state;
			return !in_object || _state == states.cheesepep || _state == states.machfreefall;
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
