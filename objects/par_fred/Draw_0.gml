var y_diff = (pit ? pit_y : (y + sprite_height)) - fred_y;
var _realYscale = y_diff / sprite_get_height(sprite_index);
draw_sprite_ext(sprite_index, image_index, x, fred_y, image_xscale, _realYscale, image_angle, image_blend, image_alpha);
