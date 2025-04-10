var x_component = -sign(image_xscale) * dcos(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
var y_component = sign(image_yscale) * dsin(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
var epsilon = 0.01;
if (abs(x_component) < epsilon)
	x_component = 0;
if (abs(y_component) < epsilon)
	y_component = 0;
draw_sprite_ext(sprite_index, image_index, x + (x_component * bumpRecessDistance), y + (y_component * bumpRecessDistance), image_xscale, image_yscale, image_angle, c_white, 1);
