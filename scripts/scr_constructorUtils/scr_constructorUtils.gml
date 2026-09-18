function subSprite(arg0, arg1 = 0, arg2 = 0.35, arg3 = true) constructor
{
	static update = function(arg0 = image_speed)
	{
		image_number = sprite_get_number(sprite_index);
		image_index += arg0;
		
		if (doWrap)
			image_index = wrap(image_index, 0, image_number);
		else
			image_index = clamp(image_index, 0, image_number);
		
		return image_index;
	};
	
	static setPosition = function(arg0, arg1)
	{
		x = arg0;
		y = arg1;
		return self;
	};
	
	static draw = function(arg0 = x, arg1 = y, arg2 = image_xscale, arg3 = image_yscale, arg4 = image_angle, arg5 = image_blend, arg6 = image_alpha)
	{
		if (!visible)
			exit;
		
		draw_sprite_ext(sprite_index, image_index, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
		return self;
	};
	
	static draw_lang = function(arg0 = x, arg1 = y, arg2 = image_xscale, arg3 = image_yscale, arg4 = image_angle, arg5 = image_blend, arg6 = image_alpha)
	{
		if (!visible)
			exit;
		
		draw_sprite_ext(lang_get_sprite(sprite_index), image_index, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
		return self;
	};
	
	static setFunction = function(arg0)
	{
		custom_func = method(self, arg0);
		return self;
	};
	
	sprite_index = arg0;
	image_index = arg1;
	image_speed = arg2;
	doWrap = arg3;
	image_xscale = 1;
	image_yscale = 1;
	visible = true;
	image_angle = 0;
	image_blend = c_white;
	image_alpha = 1;
	x = 0;
	y = 0;
	xstart = 0;
	ystart = 0;
	image_number = sprite_get_number(sprite_index);
	finalFrame = image_number;
	custom_func = -4;
	return self;
}
