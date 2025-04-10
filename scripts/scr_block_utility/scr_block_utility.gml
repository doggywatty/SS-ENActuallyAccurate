function scr_destroy_tile(_layertileId)
{
	var lay_id = layer_get_id(_layertileId);
	var map_id = layer_tilemap_get_id_fixed(lay_id);
	for (var i = 0; i < floor(sprite_width / tilemap_get_tile_width(map_id)); i++)
	{
		for (var z = 0; z < floor(sprite_height / tilemap_get_tile_height(map_id)); z++)
		{
			var data = tilemap_get_at_pixel(map_id, x + (i * tilemap_get_tile_width(map_id)) + 1, y + (z * tilemap_get_tile_height(map_id)) + 1);
			data = tile_set_empty(data);
			tilemap_set_at_pixel(map_id, data, x + (i * tilemap_get_tile_width(map_id)) + 1, y + (z * tilemap_get_tile_height(map_id)) + 1);
		}
	}
}

function scr_destroy_nearby_tiles()
{
	instance_destroy(instance_place(x + 1, y, obj_tiledestroyOLD));
	instance_destroy(instance_place(x - 1, y, obj_tiledestroyOLD));
	instance_destroy(instance_place(x, y + 1, obj_tiledestroyOLD));
	instance_destroy(instance_place(x, y - 1, obj_tiledestroyOLD));
	instance_destroy(instance_place(x + 1, y, obj_secretTileDestroy));
	instance_destroy(instance_place(x - 1, y, obj_secretTileDestroy));
	instance_destroy(instance_place(x, y + 1, obj_secretTileDestroy));
	instance_destroy(instance_place(x, y - 1, obj_secretTileDestroy));
	with obj_secret_cutoff
		alarm[0] = 1;
}

function manage_up_arrow(_upArrow)
{
	if !variable_instance_exists(self, "script_UpArrow")
		script_UpArrow = -4;
	if _upArrow
	{
		if !instance_exists(script_UpArrow)
		{
			script_UpArrow = instance_create(obj_parent_player.x, obj_parent_player.y, obj_uparrow);
			script_UpArrow.manual = true;
		}
	}
	else if instance_exists(script_UpArrow)
		instance_destroy(script_UpArrow);
	if !instance_exists(script_UpArrow)
		return -4;
	return script_UpArrow;
}
