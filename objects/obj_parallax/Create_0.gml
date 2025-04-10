depth = -5;
global.ScrollOffset = 0;
lapDeco = ds_list_create();

if instance_number(obj_parallax) > 1
{
	var _first = instance_find(obj_parallax, 0);
	if id != _first
	{
		instance_destroy();
		exit;
	}
}

layerArray = [];
var i = 5;
repeat 5
	layers[i--] = -4;

asset_layers = array_create(5, undefined);
asset_sprites = array_create(5, undefined);
layerNum = 0;
assetNum = 0;
spriteNum = 0;
target_panic_id = 0;
target_time_id = 0;
bgflash = 0;
greyscalefade = 0;
scroll1 = 0;
RealSurface = -4;
use_war = false;

safe_layer_set_depth = function(_layer_id, _depth)
{
	if (layer_exists(_layer_id) && number_in_range(_depth, -16000, 16000))
		layer_depth(_layer_id, _depth);
};

set_layer_depths = function()
{
	var temp_map = ds_map_create();
	ds_map_set(temp_map, "Tiles_Foreground", 50);
	ds_map_set(temp_map, "Tiles_", 100);
	ds_map_set(temp_map, "Tiles_BG", 200);
	ds_map_set(temp_map, "Assets_MG", 150);
	ds_map_set(temp_map, "Assets_BG", 210);
	ds_map_set(temp_map, "Assets_FG", -350);
	ds_map_set(temp_map, "Assets_Foreground", -350);
	ds_map_set(temp_map, "Effect_", -500);
	
	var a = layer_get_all();
	for (var i = 0; i < array_length(a); i++)
	{
		var layer_id = a[i];
		var layer_name = layer_get_name(layer_id);
		var nums = string_digits(layer_name);
		var nums_at = string_last_pos(nums, layer_name);
		var layer_check_name = (nums == "") ? layer_name : string_delete(layer_name, nums_at, real(nums));
		
		if (!is_undefined(ds_map_find_value(temp_map, layer_check_name)))
		{
			var sub = (string_digits(layer_name) == "") ? 0 : real(string_digits(layer_name));
			safe_layer_set_depth(a[i], ds_map_find_value(temp_map, layer_check_name) - sub);
		}
	}
	ds_map_destroy(temp_map);
};

createLapDeco = function(_deco = false)
{
	if (array_length(lapDecoBag) <= 0)
	{
		lapDecoBag = [bg_lappingdeco1, bg_lappingdeco2, bg_lappingdeco3];
		lapDecoBag = array_shuffle(lapDecoBag);
	}
	
	with (instance_create(irandom(room_width), _deco ? irandom(room_height) : (room_height + 276), obj_lappingdeco))
	{
		sprite_index = array_shift(other.lapDecoBag);
		vspeed = random_range(-2, -2.5);
		
		switch (sprite_index)
		{
			case bg_lappingdeco2:
				vspeed = random_range(-1, -2);
				break;
			case bg_lappingdeco3:
				vspeed = random_range(-0.5, -1);
				break;
		}
	}
};

subLayerArray = [];

defineSublayer = function(_mainLayer, _subLayers)
{
	array_push(subLayerArray, 
	{
		mainLayer: _mainLayer,
		subLayers: _subLayers
	});
};

createSubLayers = function()
{
	var all_layers = layer_get_all();
	var array_len = array_length(all_layers);
	var i = 0;
	for (var l = 0; l < array_len; l++)
	{
		var cur_layer = all_layers[l];
		var layer_name = layer_get_name(cur_layer);
		var back_id = layer_background_get_id_fixed(cur_layer);
		if (back_id != -1 && layer_get_visible(cur_layer))
		{
			var layer_sprite = layer_background_get_sprite(back_id);
			for (i = 0; i < array_length(subLayerArray); i++)
			{
				if (subLayerArray[i].mainLayer == layer_sprite)
				{
					for (var z = 0; z < array_length(subLayerArray[i].subLayers); z++)
					{
						var created_layer = layer_create(layer_get_depth(cur_layer) - z, layer_name);
						var bg_id = layer_background_create(created_layer, subLayerArray[i].subLayers[z]);
						layer_background_speed(bg_id, sprite_get_speed(subLayerArray[i].subLayers[z]));
						layer_background_htiled(bg_id, layer_background_get_htiled(back_id));
						layer_background_vtiled(bg_id, layer_background_get_vtiled(back_id));
						layer_x(created_layer, layer_get_x(cur_layer));
						layer_y(created_layer, layer_get_y(cur_layer));
					}
				}
			}
		}
	}
};

defineSublayer(bg_cottonClock2, [bg_cottonClock2_water]);
visualCooldown = 0;
lapDecoBag = [];
