if (obj_parent_player.x != x)
	drawxscale = sign(obj_parent_player.x - x);

if (place_meeting(x, y, obj_geyservertical) || place_meeting(x, y, obj_molasseswater))
	wetTimer = approach(wetTimer, wetTimerMax, 15);

wetTimer = approach(wetTimer, 0, 3);

if (wetTimer > 0 && wetTimerEffect-- <= 0)
	wetTimerEffect = 3;

switch (state)
{
	case confectistate.normal:
		scr_confecti_normal();
		depth = -5 + ds_list_find_index(global.FollowerList, id);
		break;
	case confectistate.taunt:
		scr_confecti_taunt();
		break;
	case confectistate.appear:
		scr_confecti_appear();
		break;
	case confectistate.unlock:
		scr_confecti_unlock();
		break;
}

if (room == rank_room)
	visible = false;

var pos = ds_list_find_index(global.FollowerList, id);
