function scr_confecti_unlock()
{
	sprite_index = spr_rudejanitor_unlock;
	
	if (sprite_index == spr_rudejanitor_unlock && sprite_animation_end())
		image_speed = 0;
	
	if (instance_exists(obj_fadeoutTransition) && obj_fadeoutTransition.fadealpha == 1 && sprite_index == spr_rudejanitor_unlock)
		instance_destroy();
}
