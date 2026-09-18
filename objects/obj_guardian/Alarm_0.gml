if ((global.panic || ds_list_size(global.KeyFollowerList) > 0) && chaseActive && state == states.Nhookshot)
	create_afterimage(afterimagetypes.red);

alarm[0] = 10;
