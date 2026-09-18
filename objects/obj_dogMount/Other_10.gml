if (state == 0)
{
	instance_create(x, y, obj_puffEffect);
	x = obj_parent_player.x;
	y = obj_parent_player.y;
	instance_create(obj_parent_player.x, obj_parent_player.y, obj_puffEffect);
}
