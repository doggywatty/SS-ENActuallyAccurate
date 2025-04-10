var segment_width = 32;
var num_segments = abs(sprite_width) / segment_width;

if !surface_exists(wormSurface)
	wormSurface = surface_create(abs(sprite_width), abs(sprite_height));

surface_set_target(wormSurface);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < num_segments; i++)
{
	var segmentIndex = 1;
	if (i == 0)
		segmentIndex = 0;
	else if (i == (num_segments - 1))
		segmentIndex = 2;
	
	var segment_sprite = segments[segmentIndex];
	var segment_frame = segmentIndices[segmentIndex];
	var segment_position = (i * segment_width) - offset;
	if segment_position < 0
	{
		if ((segment_position + segment_width) >= 0)
			draw_sprite_part(segment_sprite, segment_frame, abs(segment_position), 0, segment_width - abs(segment_position), sprite_get_height(segment_sprite), 0, 0);
		segment_position = abs(sprite_width) + segment_position;
	}
	draw_sprite_part(segment_sprite, segment_frame, 0, 0, min(segment_width, abs(sprite_width) - segment_position), sprite_get_height(segment_sprite), segment_position, 0);
}

surface_reset_target();
draw_surface_ext(wormSurface, x, y, sign(image_xscale), image_yscale, image_angle, c_white, image_alpha);
