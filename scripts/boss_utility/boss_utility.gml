function face_obj(_obj)
{
	var dir = sign(_obj.x - x);
	if (dir == 0)
		dir = 1;
	return dir;
}
