if ((global.panic || ds_list_size(global.KeyFollowerList) > 0) && chaseActive && state == States.run)
    create_afterimage(AfterImageType.baddie);

alarm[0] = 10;