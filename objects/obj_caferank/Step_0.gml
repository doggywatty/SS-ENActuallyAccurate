switch state
{
	case 0:
		var ty = y - 270;
		y -= mspd;
		if (abs(ty) < 200)
			mspd = approach(mspd, 1, 0.05);
		if (abs(ty) < 16)
		{
			y = 270;
			state = 1;
		}
		break;
	case 2:
		y += mspd;
		mspd += 0.5;
		if (y >= (540 + sprite_get_height(spr_caferank1)))
			instance_destroy();
		break;
}

if (collect <= 0 && state != 2)
{
	mspd = 2;
	state = 2;
}
else if (alarm[0] == -1)
	alarm[0] = 5;