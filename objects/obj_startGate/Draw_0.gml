draw_set_color(c_white);
draw_self();
draw_sprite(sprite_index, 2, x, y);
scr_startgate_draw_normal();
if hideDetails
	exit;
for (var i = 0; i < array_length(secretCanvas); i++)
{
	var secret_canvas = secretCanvas[i];
	draw_sprite_ext(secret_canvas.sprite_index, secret_canvas.image_index, secret_canvas.x, secret_canvas.y, 1, 1, 0, c_white, secret_canvas.visible);
}
if rank == "none"
	exit;
if gatePointDisplay.visible
{
	draw_sprite_ext(spr_cakehud, 0, gatePointDisplay.x, gatePointDisplay.y, 1, 1, 0, c_white, 1);
	var rank_toppings = [spr_null, spr_cranktopping, spr_branktopping, spr_aranktopping, spr_sranktopping, spr_null];
	for (var i = 0; i < array_length(rank_toppings); i++)
	{
		if (i <= rank_checker(rank))
			draw_sprite(rank_toppings[i], 0, gatePointDisplay.x, gatePointDisplay.y);
	}
	var point_string = string(highscore);
	var point_string_length = string_length(point_string);
	draw_set_font(global.candlefont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	for (var i = 0; i < point_string_length; i++)
	{
		var palette_select = gatePointDisplay.pointText[i].palette;
		var point_y = gatePointDisplay.pointText[i].y;
		pal_swap_set(spr_palcandle, palette_select, false);
		var x_offset = ((string_width(point_string) / point_string_length) * i) - (string_width(point_string) / 2);
		var y_offset = (i % 2) ? 0 : -6;
		draw_text(x + 16 + x_offset, (point_y - 67) + y_offset, string_char_at(point_string, i + 1));
		pal_swap_reset();
	}
}
if gateRankBubble.visible
{
	var offset_x = (sprite_get_width(gateRankBubble.sprite_index) / 2) * gateRankBubble.bubbleScale;
	var offset_y = (sprite_get_height(gateRankBubble.sprite_index) / 2) * gateRankBubble.bubbleScale;
	draw_sprite_ext(gateRankBubble.sprite_index, 0, gateRankBubble.x - offset_x, gateRankBubble.y - offset_y, gateRankBubble.bubbleScale, gateRankBubble.bubbleScale, 0, c_white, 1);
}
