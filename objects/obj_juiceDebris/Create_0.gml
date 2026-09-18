image_speed = 0;
vsp = random_range(-10, 10);
hsp = random_range(-10, 10);
grav = 0.4;
image_angle = random_range(1, 270);
paletteSprite = spr_juicePalette;

switch (global.InternalLevelName)
{
	case "entryway":
		paletteSelect = 1;
		break;
	default:
		paletteSelect = 2;
		break;
	case "molasses":
		paletteSelect = 3;
		break;
	case "mines":
		paletteSelect = 4;
		break;
	case "fudge":
		paletteSelect = 5;
		break;
}
