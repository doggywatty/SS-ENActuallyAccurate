scale = approach(scale, 0, 0.25);
if (image_speed > 0 && sprite_animation_end(sprite_index, image_index, end_image_index))
{
	image_index = end_image_index;
	image_speed = 0;
}