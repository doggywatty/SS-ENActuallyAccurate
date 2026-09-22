//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDING
function pal_swap_init_system(_shader, _html5_spr, _html5_surf)
{
	var swapper = 
	{
		shader: noone,
		html5: false,
		html5_sprite: noone,
		html5_surface: noone,
		texel_size: [0],
		uvs: [0],
		index: [0],
		texture: [0],
		layer_priority: 0,
		layer_temp_priority: 0,
		layer_map: 0,
		
		cleanup: function()
		{
			ds_priority_destroy(layer_priority);
			ds_priority_destroy(layer_temp_priority);
			ds_map_destroy(layer_map);
		}
	};
	swapper.html5 = false;
	
	if (!swapper.html5)
	{
		swapper.shader = _shader;
		swapper.texel_size[0] = shader_get_uniform(_shader, "u_pixelSize");
		swapper.uvs[0] = shader_get_uniform(_shader, "u_Uvs");
		swapper.index[0] = shader_get_uniform(_shader, "u_paletteId");
		swapper.texture[0] = shader_get_sampler_index(_shader, "u_palTexture");
	}
	else
	{
		if (_html5_spr == undefined || _html5_surf == undefined)
		{
			show_message("Must provide pal_swap_init_system() with 2 additional arguments for HTML5 Compatible Sprite and Surface Shaders");
			game_end();
		}
		
		swapper.html5_sprite = _html5_spr;
		swapper.html5_surface = _html5_surf;
		swapper.texel_size[1] = shader_get_uniform(_html5_spr, "u_pixelSize");
		swapper.uvs[1] = shader_get_uniform(_html5_spr, "u_Uvs");
		swapper.index[1] = shader_get_uniform(_html5_spr, "u_paletteId");
		swapper.texture[1] = shader_get_sampler_index(_html5_spr, "u_palTexture");
		swapper.texel_size[2] = shader_get_uniform(_html5_surf, "u_pixelSize");
		swapper.uvs[2] = shader_get_uniform(_html5_surf, "u_Uvs");
		swapper.index[2] = shader_get_uniform(_html5_surf, "u_paletteId");
		swapper.texture[2] = shader_get_sampler_index(_html5_surf, "u_palTexture");
	}
	
	swapper.layer_priority = ds_priority_create();
	swapper.layer_temp_priority = ds_priority_create();
	swapper.layer_map = ds_map_create();
	global.retro_pal_swapper = swapper;
}

function pal_swap_set(_spr, _val, _is_surf)
{
	var swapper = global.retro_pal_swapper;
	
	if (_val == 0)
		exit;
	
	var mode = 0;
	
	if (!_is_surf)
	{
		if (swapper.html5)
		{
			shader_set(swapper.html5_sprite);
			mode = 1;
		}
		else
		{
			shader_set(swapper.shader);
		}
		
		var tex = sprite_get_texture(_spr, 0);
		var UVs = sprite_get_uvs(_spr, 0);
		texture_set_stage(swapper.texture[mode], tex);
		var texel_x = texture_get_texel_width(tex);
		var texel_y = texture_get_texel_height(tex);
		var texel_hx = texel_x * 0.5;
		var texel_hy = texel_y * 0.5;
		shader_set_uniform_f(swapper.texel_size[mode], texel_x, texel_y);
		shader_set_uniform_f(swapper.uvs[mode], UVs[0] + texel_hx, UVs[1] + texel_hy, UVs[2], UVs[3]);
		shader_set_uniform_f(swapper.index[mode], _val);
	}
	else
	{
		if (swapper.html5)
		{
			shader_set(swapper.html5_surface);
			mode = 2;
		}
		else
		{
			shader_set(swapper.shader);
		}
		
		var tex = surface_get_texture(_spr);
		texture_set_stage(swapper.texture[mode], tex);
		var texel_x = texture_get_texel_width(tex);
		var texel_y = texture_get_texel_height(tex);
		var texel_hx = texel_x * 0.5;
		var texel_hy = texel_y * 0.5;
		shader_set_uniform_f(swapper.texel_size[mode], texel_x, texel_y);
		shader_set_uniform_f(swapper.uvs[mode], texel_hx, texel_hy, 1 + texel_hx, 1 + texel_hy);
		shader_set_uniform_f(swapper.index[mode], _val);
	}
}

function pal_swap_reset()
{
	var u_enabled = shader_get_uniform(shd_pal_swapper, "pattern_enabled");
	shader_set_uniform_i(u_enabled, false);
	
	if (shader_current() != -1)
		shader_reset();
}

function pal_swap_layer_init()
{
	ds_map_clear(global.retro_pal_swapper.layer_map);
	ds_priority_clear(global.retro_pal_swapper.layer_priority);
	ds_priority_clear(global.retro_pal_swapper.layer_temp_priority);
}

function pal_swap_set_layer(_spr, _ind, _val, _is_surf)
{
	var data = ds_map_find_value(global.retro_pal_swapper.layer_map, _val);
	
	if (data == undefined)
		exit;
	
	ds_map_set(global.retro_pal_swapper.layer_map, _layer_index, 
	{
		sprite: _spr,
		index: _ind,
		is_surf: _is_surf
	});
}

function pal_swap_enable_layer(_layer)
{
	if (!layer_exists(_layer))
		exit;
	
	var data = 
	{
		sprite: undefined,
		index: undefined,
		is_surf: undefined
	};
///PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDI
	layer_script_begin(_layer, function()
	{
		if (event_type == ev_draw)
		{
			var layer_id = ds_priority_delete_min(global.retro_pal_swapper.layer_priority);
			var data = ds_map_find_value(global.retro_pal_swapper.layer_map, layer_id);
			
			if (data == "<undefined>")
				exit;
			
			pal_swap_set(data.sprite, data.index, data.is_surf);
			ds_priority_add(global.retro_pal_swapper.layer_temp_priority, layer_id, layer_get_depth(layer_id));
		}
	});
///PADDINGPADDINGPADDINGPADDINGPADDINGPADDI
	layer_script_end(_layer, function()
	{
		if (event_type == ev_draw)
		{
			pal_swap_reset();
			
			if (ds_priority_empty(global.retro_pal_swapper.layer_priority))
			{
				ds_priority_copy(global.retro_pal_swapper.layer_priority, global.retro_pal_swapper.layer_temp_priority);
				ds_priority_clear(global.retro_pal_swapper.layer_temp_priority);
			}
		}
	});
	ds_map_set(global.retro_pal_swapper.layer_map, _layer, data);
	ds_priority_add(global.retro_pal_swapper.layer_priority, _layer, layer_get_depth(_layer));
}
