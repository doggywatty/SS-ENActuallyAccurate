if (place_meeting(x + 4, y, obj_parent_player) && (obj_parent_player.state == PlayerState.doughmount || obj_parent_player.state == PlayerState.doughmountspin || obj_parent_player.state == PlayerState.doughmountballoon))
{
	instance_destroy();
	ds_list_add(global.SaveRoom, id);
}
