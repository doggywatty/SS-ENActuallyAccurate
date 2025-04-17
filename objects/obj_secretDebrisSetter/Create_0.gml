var list_of_objects = [obj_secret_brainBlock, obj_secretdestroyable, obj_secretdestroyable_metal, obj_secretdestroyable_big];
for (var i = 0; i < array_length(list_of_objects); i++)
{
	with list_of_objects[i]
	{
		if (place_meeting(x, y, other))
			debrisSprite = other.debrisSprite;
	}
}
instance_destroy();
