function subSprite(_spr_ind, _img_ind = 0, _img_spd = 0.35, _doWrap = true) constructor
{
    static update = function(_img_spd = image_speed)
    {
        image_number = sprite_get_number(sprite_index);
        image_index += _img_spd;
        if doWrap
            image_index = wrap(image_index, 0, image_number);
        else
            image_index = clamp(image_index, 0, image_number);
        return image_index;
    };
    
    static setPosition = function(_x, _y)
    {
        x = _x;
        y = _y;
        return self;
    };
    
    static draw = function(_x = x, _y = y, _img_xscale = image_xscale, _img_yscale = image_yscale, _img_angle = image_angle, _img_blend = image_blend, _img_alpha = image_alpha)
    {
        if !visible
            exit;
        draw_sprite_ext(sprite_index, image_index, _x, _y, _img_xscale, _img_yscale, _img_angle, _img_blend, _img_alpha);
        return self;
    };
    
    static setFunction = function(_func)
    {
        custom_func = method(self, _func);
        return self;
    };
    
    sprite_index = _spr_ind;
    image_index = _img_ind;
    image_speed = _img_spd;
    doWrap = _doWrap;
    image_xscale = 1;
    image_yscale = 1;
    visible = true;
    image_angle = 0;
    image_blend = c_white;
    image_alpha = 1;
    x = 0;
    y = 0;
    image_number = sprite_get_number(sprite_index);
    finalFrame = image_number;
    custom_func = -4;
    return self;
}
