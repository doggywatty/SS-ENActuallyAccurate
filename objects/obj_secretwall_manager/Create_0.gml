if instance_number(object_index) > 1
{
	var first = instance_find(object_index, 0);
	if id != first
	{
		instance_destroy();
		exit;
	}
}

depth = -8;
global.secret_layers = [];
collision_arr = [obj_parent_enemy];
