canCollide = function(stpl, player = obj_parent_player)
{
	return false;
};

bumpRecessDistance = 10;
artificialYOffset = 0;
clone = false;
depth = 105;
DestroyedBy = -4;
realBump = -4;
bumpOffset = 0;
linkedWorm = -4;
bumpID = $"bump{id}";
var x_component = -sign(image_xscale) * dcos(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
var y_component = sign(image_yscale) * dsin(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
linkedWorm = instance_place(x + x_component, y + y_component, obj_gummyWorm);
if (linkedWorm == -4 || !instance_exists(linkedWorm) || ds_list_find_index(global.SaveRoom, linkedWorm) != -1)
{
	show_debug_message(x_component);
	show_debug_message(y_component);
	instance_destroy(id, false);
	exit;
}

bumpOffset = ceil(distance_to_point(linkedWorm.x, linkedWorm.y));
linkedWorm.hasBump = true;
with instance_copy(false)
{
	image_angle = other.image_angle;
	canCollide = other.canCollide;
	bumpRecessDistance = other.bumpRecessDistance;
	linkedWorm = other.linkedWorm;
	bumpID = other.bumpID;
	if (linkedWorm == -4 || !instance_exists(linkedWorm))
	{
		x_component = -sign(image_xscale) * dcos(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
		y_component = sign(image_yscale) * dsin(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
		linkedWorm = instance_place(x + x_component, y + y_component, obj_gummyWorm);
	}
	if (linkedWorm == -4 || !instance_exists(linkedWorm))
	{
		instance_destroy(id, false);
		exit;
	}
	
	DestroyedBy = -4;
	realBump = other.id;
	var offset = round(linkedWorm.sprite_width);
	var x_offset = offset * -linkedWorm.x_direction * sign(linkedWorm.image_xscale);
	var y_offset = offset * -linkedWorm.y_direction * sign(linkedWorm.image_xscale);
	x += x_offset;
	y -= y_offset;
	bumpOffset = ceil(distance_to_point(linkedWorm.x, linkedWorm.y));
	clone = true;
	depth = other.depth;
	box2 = [bbox_left, bbox_top, bbox_right, bbox_bottom];
}
