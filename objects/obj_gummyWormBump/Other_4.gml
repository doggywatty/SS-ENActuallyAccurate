if (ds_list_find_index(global.SaveRoom, id) != -1)
{
	instance_destroy();
	exit;
}
if linkedWorm != -4
	exit;
var x_component = -sign(image_xscale) * dcos(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
var y_component = sign(image_yscale) * dsin(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
linkedWorm = instance_place(x + x_component, y + y_component, obj_gummyWorm);
if (linkedWorm == -4 || !instance_exists(linkedWorm))
{
	show_debug_message(x_component);
	show_debug_message(y_component);
	instance_destroy();
	exit;
}
bumpOffset = distance_to_point(linkedWorm.x, linkedWorm.y);
