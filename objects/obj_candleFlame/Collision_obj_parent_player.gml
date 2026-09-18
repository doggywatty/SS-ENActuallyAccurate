var _check;

with (other)
	_check = movespeed >= 12 && sprite_index != spr_longJump && sprite_index != spr_longJump_intro && (state == states.pistol || state == states.shotgun || (state == states.Nhookshot && movespeed >= 12) || (state == states.climbdownwall && mach3Roll > 0));

if (_check && ds_list_find_index(global.SaveRoom, id) == -1)
{
	visible = true;
	ds_list_add(global.SaveRoom, id);
}
