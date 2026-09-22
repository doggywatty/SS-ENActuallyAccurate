if ((global.panic || ds_list_size(global.KeyFollowerList) > 0) && chaseActive && state == PlayerState.run)
	create_afterimage(afterimagetypes.baddie);

alarm[0] = 10;
