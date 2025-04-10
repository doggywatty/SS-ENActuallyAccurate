scr_collision_init();
hsp = 0;
vsp = 0;
grav = 0.5;
image_speed = 0.5;
grounded = 0;
sprite_index = spr_juicepuddleair;
mask_index = spr_juicepuddledone;
draw_angle = 0;
vsp = 0.2;
slipped = 0;
iceblock = new subSprite(spr_iceblock_puddle);
paletteSprite = spr_juicePalette;

switch global.InternalLevelName
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
	case "mineshaft":
		paletteSelect = 4;
		break;
	case "fudge":
		paletteSelect = 5;
		break;
}

depth = 10;
perma = false;
