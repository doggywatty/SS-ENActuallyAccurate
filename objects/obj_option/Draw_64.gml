draw_rectangle_color(0, 0, 960, 540, c_black, c_black, c_black, c_black, false);
for (var i = 0; i < array_length(bg_alpha); i++)
	draw_sprite_tiled_ext(bg_options, i, bgx, bgy, 1, 1, c_white, bg_alpha[i]);
if (instance_exists(obj_option_keyconfig) || instance_exists(obj_option_confirm) || instance_exists(obj_option_lang) || instance_exists(obj_langSpriteLoader))
	exit;
draw_set_font(global.fontDefault);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var _optLength = array_length(options);
var _strHeight = string_height("A") + 12;
var _realstrHeight = string_height("A");
var _xx = 150;
if alignCenter
{
	_xx = camera_get_view_width(view_camera[0]) / 2;
	draw_set_halign(fa_center);
}

for (var i = 0; i < _optLength; i++)
{
	var _option = options[i];
	var _yy = (camera_get_view_height(view_camera[0]) / 2) + round(-((_optLength - 1) * _strHeight * 0.5)) + (i * _strHeight);
	var _iColor = (i == optionSelected) ? c_white : c_gray;
	_option.icon_alpha = approach(_option.icon_alpha, i == optionSelected, 0.2);
	switch (_option.type)
	{
		default:
			var _finalStr = _option.translate_name ? lang_get(_option.id) : _option.id;
			var _optStr = "";
			var _old_font = draw_get_font();
			if (array_length(_option.options))
				_optStr = _option.translate_opt ? lang_get(_option.options[_option.value]) : _option.options[_option.value];
			if (alignCenter && array_length(_option.options))
				_finalStr = $"{_finalStr} {_optStr}";
			
			_finalStr = string_upper(_finalStr);
			
			var _max_length = 490;
			var _option_max_length = 0;
			for (var z = 0; z < array_length(_option.options); z++)
			{
				var _string = lang_get(_option.options[z]);
				_option_max_length = max(_option_max_length, string_width(_string));
			}
			_max_length -= _option_max_length;
			if (string_width(_finalStr) > _max_length || string_height(_finalStr) > _realstrHeight)
			{
				draw_set_font(global.smallfont);
				draw_text_ext_color(_xx, _yy, _finalStr, 16, _max_length / 2, _iColor, _iColor, _iColor, _iColor, 1);
			}
			else
			{
				draw_set_font(global.fontDefault);			
				draw_text_color(_xx, _yy, _finalStr, _iColor, _iColor, _iColor, _iColor, 1);
			}
			
			if (_option.sprite_index != -4)
			{
				var _icon_x = alignCenter ? (_xx + (string_width(_finalStr) / 2)) : (_xx + string_width(_finalStr));
				_icon_x += 50;
				draw_sprite_ext(_option.sprite_index, _option.image_index, _icon_x + irandom_range(-1, 1), _yy + irandom_range(-1, 1), 1, 1, 0, c_white, _option.icon_alpha);
			}
			
			draw_set_font(_old_font);
			
			if !alignCenter && array_length(_option.options)
			{
				var old_halign = draw_get_halign();
				draw_set_halign(fa_right - old_halign);
				draw_text_color(camera_get_view_width(view_camera[0]) - _xx, _yy, _optStr, _iColor, _iColor, _iColor, _iColor, 1);
				draw_set_halign(old_halign);
			}
			break;
		case OptionType.Slider:
			var old_halign = draw_get_halign();
			_xx = 150;
			draw_set_halign(fa_left);
			var _finalStr = _option.translate_name ? lang_get(_option.id) : _option.id;
			draw_text_color(_xx, _yy, _finalStr, _iColor, _iColor, _iColor, _iColor, 1);
			var _ov = _option.value / 100;
			var bar_start_x, barPad;
			
			if (sliderSprite != spr_optionslide_bar)
			{
				draw_sprite_ext(sliderSprite, 0, camera_get_view_width(view_camera[0]) - _xx, _yy, 1, 1, 0, _iColor, 1);
				barPad = 20;
				bar_start_x = (camera_get_view_width(view_camera[0]) - _xx - sprite_get_width(sliderSprite)) + barPad;
				var bar_end_x = camera_get_view_width(view_camera[0]) - _xx - barPad;
				var iconPos = lerp(bar_start_x, bar_end_x, _ov);
				draw_sprite(sliderIcon, _option.moving, iconPos, _yy);
			}
			else
			{
				var si = _option.moving ? 1 : 2;
				var xlen = 160;
				if (_ov <= 0)
					si = 0;
				draw_sprite_ext(sliderIcon, 0, camera_get_view_width(view_camera[0]) - _xx, _yy, 1, 1, 0, _iColor, 1);
				draw_sprite_stretched_ext(sliderSprite, si, camera_get_view_width(view_camera[0]) - _xx - xlen - 54, _yy - 24, 48 + (_ov * xlen), 48, _iColor, 1);
			}
			
			if _option.show_percent
			{
				draw_set_font(global.smallfont);
				draw_set_halign(fa_right);
				draw_text_color(bar_start_x - barPad, _yy, $"{_option.value}%", _iColor, _iColor, _iColor, _iColor, 1);
			}
			
			draw_set_halign(old_halign);
			draw_set_font(global.fontDefault);
			break;
	}
}

draw_set_font(global.smallfont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _desc_str = (descfadeout || !showdesc) ? old_desc : description;
var _desc_yy = camera_get_view_height(view_camera[0]) - 48;
var _desc_width = string_width(_desc_str) + 16;
draw_sprite_ext(spr_optionSubtitle, 0, camera_get_view_width(view_camera[0]) / 2, _desc_yy, _desc_width / 32, 1, 0, c_white, descalp);
draw_text_color(camera_get_view_width(view_camera[0]) / 2, _desc_yy, _desc_str, c_white, c_white, c_white, c_white, descalp);
