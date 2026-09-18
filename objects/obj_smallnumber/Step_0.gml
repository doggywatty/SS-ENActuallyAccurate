if (flash && alarm[0] <= 0)
	alarm[0] = 8;

if (alarm[1] > 0)
	exit;

numberScale = approach(numberScale, scaleTarget, (scaleTarget <= 0) ? 0.15 : 0.05);

if (numberScale >= scaleTarget && scaleTarget > 0)
{
	flash = true;
	scaleTarget = 0;
}

if (numberScale <= 0)
	instance_destroy();
