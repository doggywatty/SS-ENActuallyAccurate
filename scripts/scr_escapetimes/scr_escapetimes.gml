function scr_escapetimes(_room = room)
{
	var seconds = 0;
	var minutes = 0;
	switch _room
	{
		case steamy_12:
			minutes = 3;
			seconds = 30;
			break;
		case entryway_11:
			minutes = 3;
			seconds = 0;
			break;
		case molasses_10:
			minutes = 4;
			seconds = 0;
			break;
		case mineshaft_12:
			minutes = 3;
			seconds = 30;
			break;
		case mountain_11:
			minutes = 5;
			seconds = 0;
			break;
		case entryway_1:
			minutes = 5;
			seconds = 0;
			break;
		case cafe_10:
			minutes = 4;
			seconds = 30;
			break;
		default:
			minutes = 3;
			seconds = 0;
			break;
	}
	var time_array;
	time_array[0] = minutes;
	time_array[1] = seconds;
	return time_array;
}
