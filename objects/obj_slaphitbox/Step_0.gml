image_xscale = obj_parent_player.xscale;
x = obj_parent_player.x;
y = obj_parent_player.y;

if (obj_parent_player.image_index > 3 && obj_parent_player.state != states.pistalaim)
	instance_destroy();
