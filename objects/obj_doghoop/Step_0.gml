if (place_meeting(x + 4, y, obj_parent_player) && (obj_parent_player.state == states.punch || obj_parent_player.state == states.backkick || obj_parent_player.state == states.shoulder))
{
	instance_destroy();
	ds_list_add(global.SaveRoom, id);
}
