global.NextRoom = rm_missing;

function room_goto_fixed(_room)
{
    global.NextRoom = _room;
    room_goto(_room);
}
