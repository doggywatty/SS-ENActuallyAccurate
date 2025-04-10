function particle_init(_part, _img_spd, _depth)
{
	ds_map_set(global.particlesMap, _part, 
	{
		image_speed: _img_spd,
		depth: _depth
	});
}

function create_particle(_x, _y, _spr_ind, _x1 = 0, _xscale = 1, _yscale = 1)
{
	var particle_id = instance_create(_x + irandom_range(-_x1, _x1), _y + irandom_range(-_x1, _x1), obj_fade_particle);
	particle_id.sprite_index = _spr_ind;
	particle_id.particle_scale(_xscale, _yscale);
	var _Map = ds_map_find_value(global.particlesMap, _spr_ind);
	if !is_undefined(_Map)
	{
		particle_id.particle_depth(_Map.depth);
		particle_id.particle_imgspd(_Map.image_speed);
	}
	return particle_id;
}

function create_destroyable_smoke(x1, x2, _img_blend = #9E5402, y1 = 0, _img_xscale = 1, _img_yscale = _img_xscale)
{
	var _x = random_range(x1 - y1, x1 + y1);
	var _y = random_range(x2 - y1, x2 + y1);
	return instance_create(_x, _y, obj_destroyableSmoke, 
	{
		image_blend: _img_blend,
		image_xscale: _img_xscale,
		image_yscale: _img_yscale
	});
}

function sprite_get_destroyable_smoke(_spr = debrisSprite)
{
	switch _spr
	{
		case spr_debris_entryway_wafer:
		case spr_debris_entryway_metal:
		case spr_debris_entryway_brick:
		case spr_minesdebris_dirt:
			smokeColor = [ #A74001 ];
			break;
		case spr_towndebris:
			smokeColor = [ #602040 ];
			break;
		case spr_clockdebris:
		case spr_clockblockdebris:
			smokeColor = [ #F8A880 ];
			break;
		case spr_minesdebris_stone_section1:
		case spr_minesdebris_stone_section2:
		case spr_minesdebris_dirt_section1:
			smokeColor = [ #9090C0 ];
			break;
		case spr_debris_molasses_mud:
			smokeColor = [ #71272D ];
			break;
		case spr_debris_molasses_temple:
			smokeColor = [ #B03000, #803851 ];
			break;
	}
	if place_meeting(x, y, obj_secretPortal)
		smokeColor = [ #6F5BAB ];
}

function create_debris(_x, _y, _spr, _spd = 0)
{
	var img_num = sprite_get_number(_spr);
	var _struct = 
	{
		x: _x,
		y: _y,
		sprite_index: _spr,
		image_number: img_num,
		image_index: irandom_range(0, img_num),
		image_angle: random_range(0, 360),
		image_speed: sprite_get_speed(_spr) * _spd,
		image_xscale: 1,
		image_yscale: 1,
		image_blend: c_white,
		image_alpha: 1,
		hsp: random_range(-4, 4),
		vsp: random_range(-5, 5),
		grav: 0.4,
		spr_palette: spr_null,
		paletteSelect: 0,
		canPalette: false,
		terminalVelocity: 20,
		fading: false,
		stopAnimation: false
	};
	ds_list_add(global.particleList, _struct);
	return _struct;
}

function create_collect_effect(_x, _y, _spr_ind = undefined, _value, _pal = undefined)
{
	if is_undefined(_spr_ind)
	{
		switch global.playerCharacter
		{
			default:
				_spr_ind = choose(spr_collect1, spr_collect2, spr_collect3, spr_collect4, spr_collect5);
				break;
		}
		if is_undefined(_pal)
			_pal = irandom_range(1, 5);
	}
	var struct = 
	{
		sprite_index: _spr_ind,
		image_index: 0,
		image_speed: 0.35,
		x: _x - camera_get_view_x(view_camera[0]),
		y: _y - camera_get_view_y(view_camera[0]),
		paletteSelect: _pal,
		usePalette: !is_undefined(_pal),
		value: _value
	};
	ds_list_add(global.collectParticleList, struct);
	return struct;
}

function create_baddiedebris(_x = x, _y = y, _sprs = choose(spr_slapstar, spr_baddieGibs))
{
	var q = instance_create(_x, _y, obj_baddieGibs);
	q.sprite_index = _sprs;
	q.hsp = random_range(-5, 5);
	q.vsp = random_range(-10, 10);
	return q;
}
