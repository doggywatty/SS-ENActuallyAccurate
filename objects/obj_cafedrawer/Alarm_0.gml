global.cafeseconds += 1;
alarm[0] = 60;

if (global.cafeseconds > 59)
{
	global.cafeseconds = 0;
	global.cafeminutes++;
}
