if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_baddieDead))
		sprite_index = other.onewayDeathSprite;
	
	repeat (3)
	{
		instance_create(bbox_xrange, bbox_yrange, obj_slapstar);
		instance_create(bbox_xrange, bbox_yrange, obj_baddieGibs);
	}
	
	create_particle(bbox_xrange, bbox_yrange, spr_bangEffect);
	event_play_oneshot("event:/SFX/enemies/kill");
	ds_list_add(global.SaveRoom, id);
}

if (instance_exists(solidid))
{
	with (solidid)
		instance_destroy();
}

ini_open(global.SaveFileName);
ini_write_string("PlantBlocks", $"Block{onewayRank}", 1);
ini_close();
