if (array_length(load_arr) <= 0)
{
	alarm[3] = -1;
	loaded = true;
	exit;
}

var _tex = array_pop(load_arr);
if !texture_is_ready(_tex)
	texture_prefetch(_tex);

alarm[3] = 1;
