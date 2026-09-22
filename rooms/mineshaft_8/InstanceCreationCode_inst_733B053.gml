flags.do_once_per_save = true;
condition = function()
{
	return ds_list_find_index(global.SaveRoom, inst_1B9C068F) != -1 && global.minesProgress == false;
};
//PADDINGP
output = function()
{
	global.minesProgress = true;
};
