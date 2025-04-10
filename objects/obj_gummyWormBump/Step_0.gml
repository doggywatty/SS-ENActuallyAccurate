event_inherited();
if instance_exists(linkedWorm)
{
	var _offset = bumpOffset;
	var _length = abs(linkedWorm.sprite_width);
	var overall_offset = (bumpOffset - linkedWorm.offset) + 32;
	while (overall_offset < -32)
		overall_offset += _length;
	while (overall_offset > (_length + 32))
		overall_offset -= _length;
	var x_component = sign(image_xscale) * dcos(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
	var y_component = -sign(image_yscale) * dsin(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
	x = linkedWorm.x + (overall_offset * -linkedWorm.x_direction);
	y = linkedWorm.y + (overall_offset * linkedWorm.y_direction);
}
else
	instance_destroy();
