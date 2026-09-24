if (ds_list_find_index(global.SaveRoom, id) == -1)
	create_debris(bbox_xrange, bbox_yrange, spr_bigdebris_hard);

event_inherited();
