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
		case ord("1"):
			return "[1]";
			break;
		case ord("2"):
			return "[2]";
			break;
		case ord("3"):
			return "[3]";
			break;
		case ord("4"):
			return "[4]";
			break;
		case ord("5"):
			return "[5]";
			break;
		case ord("6"):
			return "[6]";
			break;
		case ord("7"):
			return "[7]";
			break;
		case ord("8"):
			return "[8]";
			break;
		case ord("9"):
			return "[9]";
			break;
		case ord("0"):
			return "[0]";
			break;
		case vk_backspace:
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
		case vk_tab:
			return "Tab";
			break;
		case ord("Q"):
			return "Q";
			break;
		case ord("W"):
			return "W";
			break;
		case ord("E"):
			return "E";
			break;
		case ord("R"):
			return "R";
			break;
		case ord("T"):
			return "T";
			break;
		case ord("Y"):
			return "Y";
			break;
		case ord("U"):
			return "U";
			break;
		case ord("I"):
			return "I";
			break;
		case ord("O"):
			return "O";
			break;
		case ord("P"):
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
		case ord("+"):
			return "[+]";
			break;
		case ord("A"):
			return "A";
			break;
		case ord("S"):
			return "S";
			break;
		case ord("D"):
			return "D";
			break;
		case ord("F"):
			return "F";
			break;
		case ord("G"):
			return "G";
			break;
		case ord("H"):
			return "H";
			break;
		case ord("J"):
			return "J";
			break;
		case ord("K"):
			return "K";
			break;
		case ord("L"):
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
		case vk_dollarsign:
			return "$";
			break;
		case ord("Z"):
			return "Z";
			break;
		case ord("X"):
			return "X";
			break;
		case ord("C"):
			return "C";
			break;
		case ord("V"):
			return "V";
			break;
		case ord("B"):
			return "B";
			break;
		case ord("N"):
			return "N";
			break;
		case ord("M"):
			return "M";
			break;
		case ord("&"):
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
		case vk_forwardslash:
			return "/";
			break;
		case vk_alt:
			return "Alt";
			break;
		case vk_percent:
			return "%";
			break;
		case vk_rightanglebracket:
			return ")";
			break;
		case vk_asterisk:
			return "*";
			break;
		case ord("("):
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
		case ord("1"):
			return "[1]";
			break;
		case ord("2"):
			return "[2]";
			break;
		case ord("3"):
			return "[3]";
			break;
		case ord("4"):
			return "[4]";
			break;
		case ord("5"):
			return "[5]";
			break;
		case ord("6"):
			return "[6]";
			break;
		case ord("7"):
			return "[7]";
			break;
		case ord("8"):
			return "[8]";
			break;
		case ord("9"):
			return "[9]";
			break;
		case ord("0"):
			return "[0]";
			break;
		case vk_backspace:
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
		case vk_tab:
			return "Tab";
			break;
		case ord("Q"):
			return "Q";
			break;
		case ord("W"):
			return "W";
			break;
		case ord("E"):
			return "E";
			break;
		case ord("R"):
			return "R";
			break;
		case ord("T"):
			return "T";
			break;
		case ord("Y"):
			return "Y";
			break;
		case ord("U"):
			return "U";
			break;
		case ord("I"):
			return "I";
			break;
		case ord("O"):
			return "O";
			break;
		case ord("P"):
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
		case ord("+"):
			return "[+]";
			break;
		case ord("A"):
			return "A";
			break;
		case ord("S"):
			return "S";
			break;
		case ord("D"):
			return "D";
			break;
		case ord("F"):
			return "F";
			break;
		case ord("G"):
			return "G";
			break;
		case ord("H"):
			return "H";
			break;
		case ord("J"):
			return "J";
			break;
		case ord("K"):
			return "K";
			break;
		case ord("L"):
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
		case ord("Z"):
			return "Z";
			break;
		case ord("X"):
			return "X";
			break;
		case ord("C"):
			return "C";
			break;
		case ord("V"):
			return "V";
			break;
		case ord("B"):
			return "B";
			break;
		case ord("N"):
			return "N";
			break;
		case ord("M"):
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