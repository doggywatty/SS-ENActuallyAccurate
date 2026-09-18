active = instance_exists(obj_creamThief) && obj_creamThief.state != states.frozen;

if (finale)
{
	sprite_index = spr_racelight_on;
}
else if (active)
{
	if (sprite_index == spr_racelight_deactive)
	{
		sprite_index = spr_racelight_switch;
		image_index = 0;
	}
	
	if (sprite_index != spr_racelight_switch || sprite_animation_end())
		sprite_index = spr_racelight_on;
}
else
{
	sprite_index = spr_racelight_deactive;
}
