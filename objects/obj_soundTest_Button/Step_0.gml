with (obj_parent_player)
{
	if (place_meeting(x, y, other.id) && alarm[0] <= 0 && !instance_exists(obj_fadeoutTransition) && key_up2 && grounded && (state == states.normal || state == states.chainsaw || state == states.pistol || state == states.shotgun || state == states.Nhookshot) && state != states.grab && state != states.shotgunjump && state != states.stunned)
	{
		with (other)
		{
			sprite_index = spr_soundTest_buttonPressed;
			alarm[0] = 5;
		}
	}
}
