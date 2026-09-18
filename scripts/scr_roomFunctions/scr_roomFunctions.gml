global.NextRoom = rm_missing;

function room_goto_fixed(arg0)
{
	global.NextRoom = arg0;
	room_goto(arg0);
}
