for (var i = 0; i < ds_list_size(global.particleList); i++)
{
	var b = ds_list_find_value(global.particleList, i);
	with b
	{
		if (vsp < terminalVelocity)
			vsp += grav;
		
		x += hsp;
		y += vsp;
		if (!(stopAnimation && sprite_animation_end()))
			image_index += image_speed;
		else
			image_index = image_number - 1;
		
		var _killX = x > (room_width + sprite_get_width(sprite_index)) || x < -sprite_get_width(sprite_index);
		var _killY = y > (room_height + sprite_get_height(sprite_index)) || y < -sprite_get_height(sprite_index);
		if fading
			image_alpha = approach(image_alpha, 0, 0.1);
		if (_killX || _killY || !image_alpha)
		{
			delete b;
			ds_list_delete(global.particleList, i);
			i--;
		}
	}
}

for (var i = 0; i < ds_list_size(global.collectParticleList); i++)
{
	var b = ds_list_find_value(global.collectParticleList, i);
	with b
	{
		var angle = point_direction(x, y, obj_camera.cakeHud.x, obj_camera.cakeHud.y);
		x = approach(x, obj_camera.cakeHud.x, lengthdir_x(20, angle));
		y = approach(y, obj_camera.cakeHud.y, lengthdir_y(20, angle));
		image_index += image_speed;
		var _killX = x <= (obj_camera.cakeHud.x + 10);
		var _killY = y <= (obj_camera.cakeHud.y + 10);
		if (_killX && _killY)
		{
			with obj_camera
				pointCollectShake = clamp(pointCollectShake + 5, 2, 10);
			
			delete b;
			ds_list_delete(global.collectParticleList, i);
			i--;
		}
	}
}
