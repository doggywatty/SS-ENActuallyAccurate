image_speed = (sprite_index == spr_caramel_alive) ? 0.5 : 0.35;
if (sprite_index == spr_caramel_idle)
{
	destroyed = false;
	if place_meeting(x, y - 1, obj_parent_player)
	{
		image_index = 0;
		sprite_index = spr_caramel_dissolve;
	}
}

if (sprite_index == spr_caramel_dissolve)
{
	if (sprite_animation_end(sprite_index, image_index, 9))
        destroyed = true;
	if (sprite_animation_end())
	{
		sprite_index = spr_caramel_dead;
		dissolveBuffer = dissolveBufferMax;
	}
}

if (sprite_index == spr_caramel_dead && dissolveBuffer-- < 0)
{
	sprite_index = spr_caramel_alive;
	image_index = 0;
	image_speed = 0.5;
}

if (sprite_index == spr_caramel_alive)
{
	if (sprite_animation_end(sprite_index, image_index, 17))
		destroyed = false;
    if (sprite_animation_end())
        sprite_index = spr_caramel_idle;
}
