var next_room = firstRoom ? room_first : room;
do
	next_room = room_next(next_room);
until
	(next_room == room_last || next_room == -1 || scr_roomcheck(next_room));

if (next_room == room_last || next_room == -1)
{
	show_debug_message(obj_parent_player.roomName);
	show_debug_message("end of the line bucko");
}
else
{
	show_debug_message(obj_parent_player.roomName);
	show_debug_message("ok good");
}
firstRoom = false;
if (scr_roomcheck(next_room) && next_room != -1)
	room_goto_fixed(next_room);
if (next_room != room_last && next_room != -1)
	alarm[0] = 5;
else
	alarm[1] = 5;
