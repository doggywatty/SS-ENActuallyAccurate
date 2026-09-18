image_speed = 0.35;
depth = 0;

if (!instance_exists(baddieID))
{
	instance_destroy();
	exit;
}

updateBirdPosition = function()
{
	x = baddieID.x;
	y = baddieID.y - 40;
	image_xscale = baddieID.image_xscale;
	image_yscale = baddieID.image_yscale;
};

updateBirdPosition();
