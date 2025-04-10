if !DrawHUD
	exit;

if !global.ShowHUD
	exit;

var collectable_shake_x = pointCollectShake * random_range(-1, 1);
var collectable_shake_y = pointCollectShake * random_range(-1, 1);
var visual_score = global.Collect - global.ComboScore;

with obj_particlecontroller
{
	for (var i = 0; i < ds_list_size(global.collectParticleList); i++)
	{
		var _id = ds_list_find_value(global.collectParticleList, i);
		visual_score -= _id.value;
	}
}

with obj_comboEndEffect
	visual_score -= comboScore;

visual_score = max(visual_score, 0);
cakeHud.x = cakeHud.xstart + collectable_shake_x;
cakeHud.y = DrawY + cakeHud.ystart + collectable_shake_y + 10;
draw_sprite(spr_cakehud, cakeHud.image_index, cakeHud.x, cakeHud.y);
drawCakeHudTopping(spr_cranktopping, global.crank);
drawCakeHudTopping(spr_branktopping, global.brank);
drawCakeHudTopping(spr_aranktopping, global.arank);
drawCakeHudTopping(spr_sranktopping, global.srank);
var hud_bounce = cakeHud.hudBounce[clamp(floor(cakeHud.image_index), 0, array_length(cakeHud.hudBounce) - 1)];
var point_x = cakeHud.x + cakeHud.pointX;
var point_y = cakeHud.y + cakeHud.pointY + hud_bounce;
var point_string = string(visual_score);
var point_string_length = string_length(point_string);
if (oldPointCollect != point_string)
{
	array_resize(cakeHud.pointColors, point_string_length);
	for (var i = 0; i < point_string_length; i++)
		cakeHud.pointColors[i] = (((point_string_length - i) * 3) + real(string_char_at(point_string, i + 1))) % 7;
	oldPointCollect = point_string;
}

draw_set_font(global.candlefont);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

for (var i = 0; i < point_string_length; i++)
{
	var palette_select = cakeHud.pointColors[i];
	pal_swap_set(spr_palcandle, palette_select, false);
	var x_offset = (((string_width(point_string) / point_string_length) * i) - (string_width(point_string) / 2)) + 5;
	var y_offset = (i % 2) ? 0 : -6;
	draw_text(point_x + x_offset, point_y + y_offset, string_char_at(point_string, i + 1));
	pal_swap_reset();
}

if (global.InternalLevelName != "none" && room != timesuproom && room != rank_room && room != timesuproom)
{
	if !instance_exists(obj_startGate)
	{
		var bubbleempty = spr_rankbubble_d;
		var bubblefilled = spr_rankbubble_dfilled;
		var local_rank = global.crank;
		var minus_moment = 0;
		var bubbleframe = 0;
		switch global.currentrank
		{
			case "P":
				bubbleempty = spr_rankbubble_p;
				bubblefilled = spr_rankbubble_pfilled;
				local_rank = global.srank;
				minus_moment = global.srank;
				bubbleframe = 0;
				break;
			case "S":
				bubbleempty = spr_rankbubble_s;
				bubblefilled = spr_rankbubble_sfilled;
				local_rank = global.srank;
				minus_moment = global.arank;
				bubbleframe = 0;
				break;
			case "A":
				bubbleempty = spr_rankbubble_a;
				bubblefilled = spr_rankbubble_afilled;
				local_rank = global.srank;
				minus_moment = global.arank;
				bubbleframe = 1;
				break;
			case "B":
				bubbleempty = spr_rankbubble_b;
				bubblefilled = spr_rankbubble_bfilled;
				local_rank = global.arank;
				minus_moment = global.brank;
				bubbleframe = 2;
				break;
			case "C":
				bubbleempty = spr_rankbubble_c;
				bubblefilled = spr_rankbubble_cfilled;
				local_rank = global.brank;
				minus_moment = global.crank;
				bubbleframe = 3;
				break;
			default:
				bubbleempty = spr_rankbubble_d;
				bubblefilled = spr_rankbubble_dfilled;
				local_rank = global.crank;
				minus_moment = 0;
				bubbleframe = 4;
				break;
		}
		
		var bubbleWidth = sprite_get_width(bubblefilled);
		var bubbleHeight = sprite_get_height(bubblefilled);
		var rankpercent = (global.Collect - minus_moment) / (local_rank - minus_moment);
		
		if (surface_exists(rankbubblesurface))
		{
			surface_set_target(rankbubblesurface);
			draw_clear_alpha(c_white, 0);
			draw_sprite_ext(spr_rankbubble_bg, bubbleframe, surface_get_width(rankbubblesurface) / 2, surface_get_height(rankbubblesurface) / 2, 1, 1, 0, c_white, 1);
			
			if (global.currentrank == "P")
				draw_sprite_ext(spr_rankbubble_pfilled, -1, 16, 16, 1, 1, 0, c_white, 1);
			else if (global.currentrank == "S")
				draw_sprite_ext(spr_rankbubble_sfilled, -1, 16, 16, 1, 1, 0, c_white, 1);
			else
			{
				draw_sprite_ext(bubbleempty, -1, 16, 16, 1, 1, 0, c_white, 1);
				draw_sprite_part_ext(bubblefilled, -1, 0, bubbleHeight - (bubbleHeight * rankpercent), bubbleWidth, bubbleHeight * rankpercent, 16, 16 + ((bubbleHeight - (bubbleHeight * rankpercent)) + DrawY), 1, 1, c_white, 1);
			}
			
			surface_reset_target();
			draw_surface_ext(rankbubblesurface, (cakeHud.x + 142) - ((surface_get_width(rankbubblesurface) / 2) * (bubblescale + 1)), cakeHud.y - 22 - ((surface_get_height(rankbubblesurface) / 2) * (bubblescale + 1)), bubblescale + 1, bubblescale + 1, 0, c_white, alpha);
		}
		else
			rankbubblesurface = surface_create(96, 96);
	}
}

if (global.screenflash > 0)
	draw_rectangle_color(-64, -64, 1024, 604, c_white, c_white, c_white, c_white, false);
