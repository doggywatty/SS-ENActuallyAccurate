sprite_index = openSpr;

if ((ds_list_find_index(global.SaveRoom, id) != -1 || !place_meeting(x, y, obj_player1)) && !global.panic)
	sprite_index = closedspr;

if (drop && ds_list_find_index(global.doorsave, id) != -1)
{
	drop_state = 1;
	y = drop_y;
}
