var _check;

with (other)
	_check = movespeed >= 12 && sprite_index != spr_longJump && sprite_index != spr_longJump_intro && (state == PlayerState.mach2 || state == PlayerState.mach3 || (state == PlayerState.run && movespeed >= 12) || (state == PlayerState.machroll && mach3Roll > 0));

if (_check && ds_list_find_index(global.SaveRoom, id) == -1)
{
	visible = true;
	ds_list_add(global.SaveRoom, id);
}
