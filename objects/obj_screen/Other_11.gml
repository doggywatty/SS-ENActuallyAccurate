var letterbox_spr = spr_letterboxBg_simple;
var letterbox_ind = 0;
if (room == rm_preinitializer || room == rm_initializer)
	exit;
switch global.Letterbox
{
	default:
		letterbox_spr = spr_letterboxBg_simple;
		letterbox_ind = 0;
		break;
	case LetterboxMode.Doodle:
		letterbox_spr = spr_letterboxBg_doodle;
		letterbox_ind = 0;
		break;
	case LetterboxMode.Dynamic:
		letterbox_spr = spr_letterboxBg_dynamic;
		switch global.InternalLevelName
		{
			default:
				letterbox_ind = 0;
				break;
			case "tutorial":
				letterbox_ind = 1;
				break;
			case "entryway":
				letterbox_ind = 2;
				break;
			case "steamy":
				letterbox_ind = 3;
				break;
			case "mineshaft":
				letterbox_ind = 4;
				break;
			case "molasses":
				letterbox_ind = 5;
				break;
		}
		break;
}

if (letterbox_spr != bgSprite.sprite_index || letterbox_ind != bgSprite.image_index)
	updateLetterBox(letterbox_spr, letterbox_ind);
