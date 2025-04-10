function queue_dialogue(_dialogmsg, _dialogstate = false)
{
	reset_dialogue();
	if !instance_exists(obj_dialogue)
		instance_create(0, 0, obj_dialogue);
	with obj_dialogue
	{
		if (obj_dialogue.state == dialogstate.outro)
			obj_dialogue.state = dialogstate.intro;
		if _dialogstate
			obj_dialogue.state = dialogstate.normal;
		obj_dialogue.curmsg = 0;
	}
	global.DialogMessage = _dialogmsg;
}

function reset_dialogue()
{
	instance_destroy(obj_dialogue);
	instance_destroy(obj_dialogue_choices);
	global.DialogMessage = -4;
	global.dialogchoices = -4;
	global.choiced = -4;
}

function create_dialogue(_x, _y = -4, _dialog = -4)
{
	return [_x, _y, _dialog];
}

function create_choice(_x, _y)
{
	return [_x, _y];
}

function queue_choices(_dialogchoice, _msgtext)
{
	reset_dialogue();
	with instance_create(x, y, obj_dialogue_choices)
		msg_text = _msgtext;
	global.dialogchoices = _dialogchoice;
	show_debug_message($"Dialogue Choices: {global.dialogchoices}");
}

function text_wrap(text, max_width, line_break, force_break)
{
	var pos_space = -1;
	var pos_current = 1;
	var text_current = text;
	var text_output = "";
	if is_real(line_break)
		line_break = "#";
	while (string_length(text_current) >= pos_current)
	{
		if (string_width(string_copy(text_current, 1, pos_current)) > max_width)
		{
			if (pos_space != -1)
			{
				text_output += (string_copy(text_current, 1, pos_space) + string(line_break));
				text_current = string_copy(text_current, pos_space + 1, string_length(text_current) - pos_space);
				pos_current = 1;
				pos_space = -1;
			}
			else if force_break
			{
				text_output += (string_copy(text_current, 1, pos_current - 1) + string(line_break));
				text_current = string_copy(text_current, pos_current, string_length(text_current) - (pos_current - 1));
				pos_current = 1;
				pos_space = -1;
			}
		}
		pos_current += 1;
		if (string_char_at(text_current, pos_current) == " ")
			pos_space = pos_current;
	}
	if (string_length(text_current) > 0)
		text_output += text_current;
	return text_output;
}
