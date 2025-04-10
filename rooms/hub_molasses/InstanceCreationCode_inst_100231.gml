flags.allowCondition = scr_check_completion();
flags.do_save = false;
flags.do_once = false;

if flags.allowCondition
{
	with obj_painterbubble
		instance_destroy();
}
else
{
	with instance_place(x, y, obj_door)
		instance_destroy();
}

condition = function()
{
	return flags.allowCondition == true;
};

output = function()
{
	var target_alpha = 0;
	if place_meeting(x, y, obj_parent_player)
		target_alpha = 1;
	if !instance_exists(obj_npc)
		target_alpha = 1;
	
	with obj_door
	{
		if (sprite_index != spr_door_mindpalace && sprite_index != spr_door_mindpalace2)
			continue;
		image_alpha = approach(image_alpha, target_alpha, 0.05);
		if (image_alpha <= 0)
			y = 540;
		else
			y = ystart;
	}
};
