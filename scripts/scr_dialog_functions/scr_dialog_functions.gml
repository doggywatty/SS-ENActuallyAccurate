function queue_dialogue(arg0, arg1 = false)
{
	reset_dialogue();
	
	if (!instance_exists(obj_dialogue))
		instance_create(0, 0, obj_dialogue);
	
	with (obj_dialogue)
	{
		if (obj_dialogue.state == dialogstate.outro)
			obj_dialogue.state = dialogstate.intro;
		
		if (arg1)
			obj_dialogue.state = dialogstate.normal;
		
		obj_dialogue.curmsg = 0;
	}
	
	global.DialogMessage = arg0;
}

function reset_dialogue()
{
	instance_destroy(obj_dialogue);
	instance_destroy(obj_dialogue_choices);
	global.DialogMessage = -4;
	global.dialogchoices = -4;
	global.choiced = -4;
}

function create_dialogue(arg0, arg1 = -4, arg2 = -4)
{
	return [arg0, arg1, arg2];
}

function create_choice(arg0, arg1)
{
	return [arg0, arg1];
}

function queue_choices(arg0, arg1)
{
	reset_dialogue();
	
	with (instance_create(x, y, obj_dialogue_choices))
		msg_text = arg1;
	
	global.dialogchoices = arg0;
	show_debug_message($"Dialogue Choices: {global.dialogchoices}");
}

function text_wrap(arg0, arg1, arg2, arg3)
{
	var pos_space = -1;
	var pos_current = 1;
	var text_current = arg0;
	var text_output = "";
	
	if (is_real(arg2))
		arg2 = "#";
	
	while (string_length(text_current) >= pos_current)
	{
		if (string_width(string_copy(text_current, 1, pos_current)) > arg1)
		{
			if (pos_space != -1)
			{
				text_output += (string_copy(text_current, 1, pos_space) + string(arg2));
				text_current = string_copy(text_current, pos_space + 1, string_length(text_current) - pos_space);
				pos_current = 1;
				pos_space = -1;
			}
			else if (arg3)
			{
				text_output += (string_copy(text_current, 1, pos_current - 1) + string(arg2));
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
