x = playerID.x;
y = playerID.y;
image_xscale = playerID.xscale;

if (playerID.vsp > 0)
	fade = true;

if (fade)
{
	image_alpha -= 0.1;
	
	if (!image_alpha)
		instance_destroy();
}
