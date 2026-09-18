function scr_enemy_idle()
{
	if (vsp > 1 && grounded)
	{
		instance_create(x, y, obj_landcloud);
		image_index = 0;
	}
	
	if (grounded && vsp > 0)
		hsp = 0;
	else if (!grounded)
		hsp = approach(hsp, 0, 0.1);
	
	scr_conveyorBeltKinematics();
	
	if (object_index != obj_charCherry && sprite_index != spr_boxfrog_land)
		sprite_index = baddieSpriteIdle;
	
	image_speed = 0.35;
	
	if (object_index == obj_charCherry && sprite_animation_end())
	{
		state = enemystates.charcherry;
		sprite_index = spr_charcherry_run;
		movespeed = 8;
		vsp = 0;
		exit;
	}
	
	if (sprite_animation_end() && grounded)
	{
		state = enemystates.normal;
		image_index = 0;
		exit;
	}
}
