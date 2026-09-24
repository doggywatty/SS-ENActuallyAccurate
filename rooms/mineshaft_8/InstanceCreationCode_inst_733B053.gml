flags.do_once_per_save = true;
condition = function()
{
	return ds_list_find_index(global.SaveRoom, inst_58BD3163) != -1 && global.minesProgress == false;
};
//PADDINGP
output = function()
{
	global.minesProgress = true;
};
