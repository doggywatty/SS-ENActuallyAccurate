if (image_index >= 3)
{
	var _alpha = 0;
	with obj_soundTest
		_alpha = !musicArray[currentSelection].hasSpecial;

	draw_sprite_ext(spr_soundTest_specialInactive, 0, x, y, 1, 1, 0, c_white, _alpha);
}
draw_self();
