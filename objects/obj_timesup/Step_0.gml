if (!grounded || floor(image_index) == (image_number - 1))
{
	image_speed = 0;
}
else
{
	image_speed = 0.35;
	alarm[2] = 15;
}

if (skippable && (obj_parent_player.key_jump || keyboard_check_pressed(vk_enter)))
	alarm[1] = 1;
