function get_control_string(_ctrl)
{
	switch _ctrl
	{
		default:
			return "[unknown]";
			break;
		case vk_escape:
			return "Escape";
			break;
		case vk_f1:
			return "F1";
			break;
		case vk_f2:
			return "F2";
			break;
		case vk_f3:
			return "F3";
			break;
		case vk_f4:
			return "F4";
			break;
		case vk_f5:
			return "F5";
			break;
		case vk_f6:
			return "F6";
			break;
		case vk_f7:
			return "F7";
			break;
		case vk_f8:
			return "F8";
			break;
		case vk_f9:
			return "F9";
			break;
		case vk_f10:
			return "F10";
			break;
		case vk_f11:
			return "F11";
			break;
		case vk_f12:
			return "F12";
			break;
		case vk_printscreen:
			return "Print Screen";
			break;
		case vk_pause:
			return "Pause";
			break;
		case 49:
			return "[1]";
			break;
		case 50:
			return "[2]";
			break;
		case 51:
			return "[3]";
			break;
		case 52:
			return "[4]";
			break;
		case 53:
			return "[5]";
			break;
		case 54:
			return "[6]";
			break;
		case 55:
			return "[7]";
			break;
		case 56:
			return "[8]";
			break;
		case 57:
			return "[9]";
			break;
		case 48:
			return "[0]";
			break;
		case 8:
			return "Backspace";
			break;
		case vk_insert:
			return "Insert";
			break;
		case vk_home:
			return "Home";
			break;
		case vk_pageup:
			return "Page Up";
			break;
		case 9:
			return "Tab";
			break;
		case 81:
			return "Q";
			break;
		case 87:
			return "W";
			break;
		case 69:
			return "E";
			break;
		case 82:
			return "R";
			break;
		case 84:
			return "T";
			break;
		case 89:
			return "Y";
			break;
		case 85:
			return "U";
			break;
		case 73:
			return "I";
			break;
		case 79:
			return "O";
			break;
		case 80:
			return "P";
			break;
		case vk_end:
			return "End";
			break;
		case vk_pagedown:
			return "Page Down";
			break;
		case vk_numpad7:
			return "Num 7";
			break;
		case vk_numpad8:
			return "Num 8";
			break;
		case vk_numpad9:
			return "Num 9";
			break;
		case 43:
			return "[+]";
			break;
		case 65:
			return "A";
			break;
		case 83:
			return "S";
			break;
		case 68:
			return "D";
			break;
		case 70:
			return "F";
			break;
		case 71:
			return "G";
			break;
		case 72:
			return "H";
			break;
		case 74:
			return "J";
			break;
		case 75:
			return "K";
			break;
		case 76:
			return "L";
			break;
		case vk_enter:
			return "Enter";
			break;
		case vk_numpad4:
			return "Num 4";
			break;
		case vk_numpad5:
			return "Num 5";
			break;
		case vk_numpad6:
			return "Num 6";
			break;
		case 16:
			return "$";
			break;
		case 90:
			return "Z";
			break;
		case 88:
			return "X";
			break;
		case 67:
			return "C";
			break;
		case 86:
			return "V";
			break;
		case 66:
			return "B";
			break;
		case 78:
			return "N";
			break;
		case 77:
			return "M";
			break;
		case 38:
			return "&";
			break;
		case vk_numpad1:
			return "Num 1";
			break;
		case vk_numpad2:
			return "Num 2";
			break;
		case vk_numpad3:
			return "Num 3";
			break;
		case 17:
			return "/";
			break;
		case vk_alt:
			return "Alt";
			break;
		case 32:
			return "%";
			break;
		case 37:
			return ")";
			break;
		case 39:
			return "*";
			break;
		case 40:
			return "(";
			break;
		case vk_numpad0:
			return "Num 0";
			break;
	}
}

function get_control_string_npc(_ctrl)
{
	switch _ctrl
	{
		default:
			return "[unknown]";
			break;
		case vk_escape:
			return "Escape";
			break;
		case vk_f1:
			return "F1";
			break;
		case vk_f2:
			return "F2";
			break;
		case vk_f3:
			return "F3";
			break;
		case vk_f4:
			return "F4";
			break;
		case vk_f5:
			return "F5";
			break;
		case vk_f6:
			return "F6";
			break;
		case vk_f7:
			return "F7";
			break;
		case vk_f8:
			return "F8";
			break;
		case vk_f9:
			return "F9";
			break;
		case vk_f10:
			return "F10";
			break;
		case vk_f11:
			return "F11";
			break;
		case vk_f12:
			return "F12";
			break;
		case vk_printscreen:
			return "Print Screen";
			break;
		case vk_pause:
			return "Pause";
			break;
		case 49:
			return "[1]";
			break;
		case 50:
			return "[2]";
			break;
		case 51:
			return "[3]";
			break;
		case 52:
			return "[4]";
			break;
		case 53:
			return "[5]";
			break;
		case 54:
			return "[6]";
			break;
		case 55:
			return "[7]";
			break;
		case 56:
			return "[8]";
			break;
		case 57:
			return "[9]";
			break;
		case 48:
			return "[0]";
			break;
		case 8:
			return "Backspace";
			break;
		case vk_insert:
			return "Insert";
			break;
		case vk_home:
			return "Home";
			break;
		case vk_pageup:
			return "Page Up";
			break;
		case 9:
			return "Tab";
			break;
		case 81:
			return "Q";
			break;
		case 87:
			return "W";
			break;
		case 69:
			return "E";
			break;
		case 82:
			return "R";
			break;
		case 84:
			return "T";
			break;
		case 89:
			return "Y";
			break;
		case 85:
			return "U";
			break;
		case 73:
			return "I";
			break;
		case 79:
			return "O";
			break;
		case 80:
			return "P";
			break;
		case vk_end:
			return "End";
			break;
		case vk_pagedown:
			return "Page Down";
			break;
		case vk_numpad7:
			return "Num 7";
			break;
		case vk_numpad8:
			return "Num 8";
			break;
		case vk_numpad9:
			return "Num 9";
			break;
		case 43:
			return "[+]";
			break;
		case 65:
			return "A";
			break;
		case 83:
			return "S";
			break;
		case 68:
			return "D";
			break;
		case 70:
			return "F";
			break;
		case 71:
			return "G";
			break;
		case 72:
			return "H";
			break;
		case 74:
			return "J";
			break;
		case 75:
			return "K";
			break;
		case 76:
			return "L";
			break;
		case vk_enter:
			return "Enter";
			break;
		case vk_numpad4:
			return "Num 4";
			break;
		case vk_numpad5:
			return "Num 5";
			break;
		case vk_numpad6:
			return "Num 6";
			break;
		case vk_shift:
			return "Shift";
			break;
		case 90:
			return "Z";
			break;
		case 88:
			return "X";
			break;
		case 67:
			return "C";
			break;
		case 86:
			return "V";
			break;
		case 66:
			return "B";
			break;
		case 78:
			return "N";
			break;
		case 77:
			return "M";
			break;
		case vk_up:
			return "Up Arrow";
			break;
		case vk_numpad1:
			return "Num 1";
			break;
		case vk_numpad2:
			return "Num 2";
			break;
		case vk_numpad3:
			return "Num 3";
			break;
		case vk_control:
			return "Control";
			break;
		case vk_alt:
			return "Alt";
			break;
		case vk_space:
			return "Spacebar";
			break;
		case vk_left:
			return "Left Arrow";
			break;
		case vk_right:
			return "Right Arrow";
			break;
		case vk_down:
			return "Down Arrow";
			break;
		case vk_numpad0:
			return "Num 0";
			break;
	}
}
