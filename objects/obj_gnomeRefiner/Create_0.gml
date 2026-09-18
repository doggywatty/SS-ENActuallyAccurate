depth = 4;
image_speed = 0.5;
donutIndex = 0;

if (ds_list_find_index(global.SaveRoom, id) == -1)
	ds_list_add(global.SaveRoom, id, 0);

gemsRefined = 0;
random_set_seed(global.RandomSeed + x + y);
colorID = irandom_range(0, 5);
random_set_seed(global.RandomSeed);
