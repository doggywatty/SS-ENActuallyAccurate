x += (image_xscale * 6);

if (scr_solid(x + image_xscale, y) && bumpcount < 1)
{
	image_xscale *= -1;
	bumpcount += 1;
}

if (scr_solid(x + image_xscale, y) && bumpcount >= 1)
{
	instance_create(x, y, obj_bumpEffect);
	instance_destroy();
}
