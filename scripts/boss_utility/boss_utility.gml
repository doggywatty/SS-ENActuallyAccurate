function face_obj(arg0)
{
	var dir = sign(arg0.x - x);
	
	if (dir == 0)
		dir = 1;
	
	return dir;
}
