var _slope = instance_place(x, y, obj_slope);
var _xscl = 1;
var _yscl = 1;
var can_bumpX = 1;
var can_bumpY = 1;
var x_adj, y_adj;

with _slope
{
	_xscl = sign(_slope.image_xscale);
	_yscl = sign(_slope.image_yscale);
	can_bumpX = _xscl ? (obj_player1.x >= ((x - sprite_xoffset) + (sprite_width / 2))) : (obj_player1.x <= ((x - sprite_xoffset) + (sprite_width / 2)));
	can_bumpY = _yscl ? (obj_player1.y <= ((y - sprite_yoffset) + (sprite_height / 2))) : (obj_player1.y >= ((y - sprite_yoffset) + (sprite_height / 2)));
	x_adj = !_xscl ? 0 : (sprite_width / 2);
	y_adj = _yscl ? 0 : (sprite_height / 2);
	if other.vertical
	{
		can_bumpX = _xscl ? (obj_player1.x <= ((x - sprite_xoffset) + (sprite_width / 2))) : (obj_player1.x >= ((x - sprite_xoffset) + (sprite_width / 2)));
		can_bumpY = _yscl ? (obj_player1.bbox_bottom >= ((y - sprite_yoffset) + (sprite_height / 2))) : (obj_player1.y <= ((y - sprite_yoffset) + (sprite_height / 2)));
		x_adj = _xscl ? 0 : (sprite_width / 2);
		y_adj = !_yscl ? 0 : (sprite_height / 2);
	}
}

var _c = c_red;
if (vertical)
	_c = c_orange;
if (can_bumpX && can_bumpY)
	_c = c_green;

draw_rectangle_color(x + x_adj, y + y_adj, x + (sprite_width / 2) + x_adj, y + (sprite_height / 2) + y_adj, _c, _c, _c, _c, false);
draw_text(x, y - 32, string($"{_xscl}, {_yscl}, CHECKS {can_bumpX}, {can_bumpY}"));
