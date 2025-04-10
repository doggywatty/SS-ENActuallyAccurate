scr_input_varinit();

if (instance_number(object_index) > 1)
	instance_destroy();

selected = -2;
select2 = 0;
reading = false;
gamepad = false;
depth = -500;
prompt_changes = false;
exiting = false;

function inputDisplay(_name, _iconInd) constructor
{
	static create = function()
	{
		parentInput = input_get(name);
		array_copy(savedKeys, 0, parentInput.keyInputs, 0, array_length(parentInput.keyInputs));
		array_copy(savedGPs, 0, parentInput.gpInputs, 0, array_length(parentInput.gpInputs));
		return update();
	};
	
	static draw = function(_text, _Offset, _blend)
	{
		inputText.blend(_blend, 1);
		inputText.draw(_text, _Offset);
		for (var i = 0; i < array_length(keyname_arr); i++)
		{
			var offset = inputOffsets[i];
			keyname_arr[i].draw(_text - offset.x, _Offset - offset.y);
		}
	};
	
	static update = function()
	{
		currentInputs = isGP ? parentInput.gpInputs : parentInput.keyInputs;
		inputIcons = scr_input_get_icon(name, true);
		lineCount = floor((array_length(inputIcons) - 1) / 3) + 1;
		inputOffsets = [];
		var txt = "";
		keyname_arr = [];
		var iconLen = array_length(inputIcons);
		
		for (var i = 0; i < iconLen; i++)
		{
			txt += string($"[{sprite_get_name(inputIcons[i][0])},{inputIcons[i][1]}]");
			
			var ii = i + 1;
			if ((ii % 3) == 0)
				txt += "\n";
			
			if (inputIcons[i][0] == spr_key_empty)
			{
				var yy = floor(i / 3) * 32;
				var xx = 32;
				if (iconLen >= (ii + 1) && (ii % 3) != 0)
				{
					if ((ii % 3) == 1 && iconLen >= (ii + 2))
						xx += 32;
					xx += 32;
				}
				
				var keyName = string_copy(scr_keyname(inputIcons[i][2]), 1, 3);
				array_push(inputOffsets, 
				{
					x: xx - 16,
					y: -yy
				});
				var keytext = scribble(keyName).align(1, 1).starting_format(font_get_name(global.keyDrawFont), 0);
				array_push(keyname_arr, keytext);
			}
		}
		var lh = isGP ? 48 : 32;
		inputText = scribble(txt).align(2, 0).origin(0, 16).line_height(lh, lh);
		return self;
	};
	
	displayname = _name;
	name = _name;
	iconIndex = _iconInd;
	text = string_upper(lang_get($"opt_keyconfig_{_name}"));
	lineCount = 1;
	isGP = false;
	inputText = "";
	parentInput = input_get(_name);
	savedKeys = [];
	savedGPs = [];
	currentInputs = [];
	inputIcons = [];
	keyname_arr = [];
	inputOffsets = [];
	return create();
}

restore_inputs = function()
{
	for (var i = 0; i < array_length(inputs); i++)
	{
		with (inputs[i])
		{
			var p = parentInput;
			if (!(array_equals(savedKeys, p.keyInputs) && array_equals(savedGPs, p.gpInputs)))
			{
				p.keyInputs = savedKeys;
				p.gpInputs = savedGPs;
				input_save(p);
			}
		}
	}
};

inputs = [
	new inputDisplay("up", 0), new inputDisplay("down", 1),
	new inputDisplay("left", 2), new inputDisplay("right", 3),
	new inputDisplay("jump", 4), new inputDisplay("slap", 5),
	new inputDisplay("taunt", 6), new inputDisplay("attack", 7),
	new inputDisplay("superjump", 8), new inputDisplay("groundpound", 9),
	new inputDisplay("start", 10), new inputDisplay("menuup", -1),
	new inputDisplay("menudown", -1), new inputDisplay("menuleft", -1),
	new inputDisplay("menuright", -1), new inputDisplay("menuconfirm", -1),
	new inputDisplay("menuback", -1), new inputDisplay("menudelete", -1)
];
scroll_y = 0;
scroll_pos = 0;
scroll_pad = 64;
