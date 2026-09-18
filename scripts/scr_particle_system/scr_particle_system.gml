global.particleSystem = part_system_create();
global.particlesMap = ds_map_create();
global.particles = part_emitter_create(global.particleSystem);
global.particleList = ds_list_create();
global.collectParticleList = ds_list_create();
particle_init(spr_parryeffect, 0.35, -100);
particle_init(spr_landcloud, 0.35, 0);
particle_init(spr_bangEffect, 0.35, 0);
particle_init(spr_paintSplash, 0.35, 0);
particle_init(spr_cloudEffect, 0.5, 0);
particle_init(spr_highJumpCloud1, 0.5, 0);
particle_init(spr_highJumpCloud2, 0.5, 0);
particle_init(spr_jumpdust, 0.35, 0);
particle_init(spr_genericPoofEffect, 0.35, 0);
particle_init(spr_keyparticles, 0.35, 0);
particle_init(spr_landcloud, 0.35, 0);
particle_init(spr_groundpoundLandEffect, 0.35, 0);
particle_init(spr_enemypuncheffect, 0.35, 0);
particle_init(spr_kungfuEffect, 0.35, -99);
particle_init(spr_stompEffect, 0.35, 0);
particle_init(spr_grabRing, 0.35, -99);
particle_init(spr_dirtDigEffect, 0.35, 0);
particle_init(spr_groundPoundClouds, 0.35, 0);
particle_init(spr_punchdust, 0.35, 0);
particle_init(spr_poofeffect, 0.35, 0);
particle_init(spr_teleportEffect, 0.35, 0);
particle_init(spr_smallpoof, 0.35, 0);
particle_init(spr_flingparticle, 0.35, 0);
particle_init(spr_flingparticle2, 0.35, 0);

function particle_init(arg0, arg1, arg2)
{
	ds_map_set(global.particlesMap, arg0, 
	{
		image_speed: arg1,
		depth: arg2
	});
}

function create_particle(arg0, arg1, arg2, arg3 = 0, arg4 = 1, arg5 = 1, arg6 = {})
{
	var particle_id = instance_create(arg0 + irandom_range(-arg3, arg3), arg1 + irandom_range(-arg3, arg3), obj_fade_particle, arg6);
	particle_id.sprite_index = arg2;
	particle_id.particle_scale(arg4, arg5);
	var _Map = ds_map_find_value(global.particlesMap, arg2);
	
	if (!is_undefined(_Map))
	{
		particle_id.particle_depth(_Map.depth);
		particle_id.particle_imgspd(_Map.image_speed);
	}
	
	return particle_id;
}

function create_radiating_particle(arg0, arg1, arg2, arg3 = 0.25, arg4 = true, arg5 = 2, arg6 = 5, arg7 = -1)
{
	return instance_create(arg0, arg1, obj_radiating_particle, 
	{
		sprite_index: arg2,
		canRotate: arg4,
		image_speed: arg3,
		minSpd: arg5,
		maxSpd: arg6,
		lifeTime: arg7
	});
}

function create_destroyable_smoke(arg0, arg1, arg2 = 152734, arg3 = 0, arg4 = 1, arg5 = arg4)
{
	var _x = random_range(arg0 - arg3, arg0 + arg3);
	var _y = random_range(arg1 - arg3, arg1 + arg3);
	return instance_create(_x, _y, obj_destroyableSmoke, 
	{
		image_blend: arg2,
		image_xscale: arg4,
		image_yscale: arg5
	});
}

function sprite_get_destroyable_smoke(arg0 = debrisSprite)
{
	switch (arg0)
	{
		case spr_debris_entryway_wafer:
		case spr_debris_entryway_metal:
		case spr_debris_entryway_brick:
		case spr_minesdebris_dirt:
			smokeColor = [82087];
			break;
		case spr_towndebris:
			smokeColor = [4202592];
			break;
		case spr_clockdebris:
		case spr_clockblockdebris:
			smokeColor = [8431864];
			break;
		case spr_minesdebris_stone_section1:
		case spr_minesdebris_stone_section2:
		case spr_minesdebris_dirt_section1:
			smokeColor = [12619920];
			break;
		case spr_debris_molasses_mud:
			smokeColor = [2959217];
			break;
		case spr_debris_molasses_temple:
			smokeColor = [12464, 5322880];
			break;
	}
	
	if (place_meeting(x, y, obj_secretPortal))
		smokeColor = [11230063];
}

function create_debris(arg0, arg1, arg2, arg3 = 0)
{
	var img_num = sprite_get_number(arg2);
	var _struct = 
	{
		x: arg0,
		y: arg1,
		sprite_index: arg2,
		image_number: img_num,
		image_index: irandom_range(0, img_num),
		image_angle: random_range(0, 360),
		image_speed: sprite_get_speed(arg2) * arg3,
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

function create_collect_effect(arg0, arg1, arg2 = undefined, arg3, arg4 = undefined)
{
	if (is_undefined(arg2))
	{
		switch (global.playerCharacter)
		{
			default:
				arg2 = choose(spr_collect1, spr_collect2, spr_collect3, spr_collect4, spr_collect5);
				break;
		}
		
		if (is_undefined(arg4))
			arg4 = irandom_range(1, 5);
	}
	
	var struct = 
	{
		sprite_index: arg2,
		image_index: 0,
		image_speed: 0.35,
		x: arg0 - camera_get_view_x(view_camera[0]),
		y: arg1 - camera_get_view_y(view_camera[0]),
		paletteSelect: arg4,
		usePalette: !is_undefined(arg4),
		value: arg3
	};
	ds_list_add(global.collectParticleList, struct);
	return struct;
}

function create_baddiedebris(arg0 = x, arg1 = y, arg2 = choose(spr_slapstar, spr_baddieGibs))
{
	var q = instance_create(arg0, arg1, obj_baddieGibs);
	q.sprite_index = arg2;
	q.hsp = random_range(-5, 5);
	q.vsp = random_range(-10, 10);
	return q;
}
