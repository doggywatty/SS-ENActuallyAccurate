if (movespeed > 0)
{
	movespeed = 0;
	roamTimer = 80 + irandom(110);
}
else
{
	image_xscale *= -1;
	movespeed = 2;
	roamTimer = 60 + irandom(130);
}
