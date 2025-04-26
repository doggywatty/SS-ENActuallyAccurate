draw_sprite_tiled_ext(bg_credits, 0, bgCredits.x, 0, 1, 1, bgCredits.image_blend, bgCredits.image_alpha);
draw_sprite_ext(spr_biggnomestudios_logosimple, 0, 0, 0, 1, 1, 0, c_white, showLogo * logoAlpha);
if (creditPhase == 1)
{
	if (currentCategory >= 0 && currentCategory < categoryCount)
	{
		for (var i = 0; i < categoryCount; i++)
		{
			var _nameArr = creditEntries[i][1];
			array_foreach(_nameArr, function(_creditEntry, _category)
			{
				_creditEntry.draw();
			});
		}
		draw_set_color(c_white);
		if (killCounterArr[currentCategory] == array_length(creditEntries[currentCategory][1]))
			draw_set_color(c_yellow);
		draw_text_scribble(camera_get_view_width(view_camera[0]) / 2, 100, $"[fa_center][fa_middle][smallfont]{string_upper(creditEntries[currentCategory][0])}");
		draw_set_color(c_white);
	}
}

endScreenSpr.draw(0, 0);
curtainSpr.draw();
with pizzelleFlick
{
	palette_as_player();
	draw();
	pal_swap_reset();
}

draw_set_alpha(fadeAlpha);
draw_rectangle_color(0, 0, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
