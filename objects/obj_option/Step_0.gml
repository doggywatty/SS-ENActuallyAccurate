if (!(instance_exists(obj_option_keyconfig) || instance_exists(obj_option_confirm)
|| instance_exists(obj_option_lang) || instance_exists(obj_langSpriteLoader)))
	scr_getinput_menu();
else
	scr_input_varinit();

if inputBuffer > 0
{
	scr_input_varinit();
	inputBuffer--;
}
if scrollbuffer
	scrollbuffer--;
var v_move = key_down2 - key_up2;
var h_move = key_left2 + key_right2;
var h_move2 = key_left + key_right;
var background_ind = optionBG[optionMenu];
for (var i = 0; i < array_length(bg_alpha); i++)
{
	if (i == background_ind)
		bg_alpha[i] = approach(bg_alpha[i], 1, 0.1);
	else
		bg_alpha[i] = approach(bg_alpha[i], 0, 0.05);
}

bgx -= 1;
bgy -= 1;
var _total_options = array_length(options);
var selOption = (_total_options <= 0) ? -4 : options[optionSelected];
var selID = (_total_options <= 0) ? -4 : options[optionSelected].id;
if (h_move2 == 0)
	handle_savedoption();
if savedDesc != selID
{
	savedDesc = selID;
	if savedDesc != -4
	{
		old_desc = description;
		descfadeout = true;
		description = lang_get($"{savedDesc}_desc");
		showdesc = description != "" && !is_undefined(description);
	}
}

if showdesc
{
	descalp = approach(descalp, !descfadeout, 0.15);
	if (descfadeout && descalp <= 0)
		descfadeout = false;
}
else
	descalp = approach(descalp, 0, 0.15);

if (key_slap2 || key_start2)
{
	if backMenu != -4
	{
		event_play_oneshot("event:/SFX/ui/menuBack");
		option_goto(backMenu, backOption);
	}
	else
		instance_destroy();
	exit;
}

if (_total_options <= 0)
	exit;

if (v_move != 0)
{
	event_play_oneshot("event:/SFX/ui/step");
	optionSelected += v_move;
	optionSelected = clamp(optionSelected, 0, _total_options - 1);
	handle_savedoption();
}

var _option = options[optionSelected];
switch _option.type
{
	case OptionType.Button:
		if key_jump
		{
			if !is_undefined(_option.on_toggle)
			{
				if (_option.id != "opt_back")
					event_play_oneshot("event:/SFX/ui/menuSelect");
				_option.on_toggle();
			}
		}
		break;
	default:
		if (key_jump || h_move != 0)
		{
			if (key_jump)
				h_move = 1;
			
			_option.value += h_move;
			_option.value = wrap(_option.value, 0, array_length(_option.options) - 1);
			
			if !is_undefined(_option.on_toggle)
			{
				event_play_oneshot("event:/SFX/ui/menuSelect");
				_option.on_toggle(_option.value);
			}
		}
		
		break;
	case OptionType.Slider:
		if (((h_move2 != 0 && _option.moving) || (h_move != 0 && !_option.moving)) && !scrollbuffer)
		{
			if (is_struct(savedSliderOption) && savedSliderOption != _option)
				handle_savedoption();
			if !is_struct(savedSliderOption)
			{
				savedSliderOption = _option;
				if (savedSliderOption.sound != -4)
				{
					activeSFX = fmod_createEventInstance(savedSliderOption.sound);
					fmod_studio_event_instance_start(activeSFX);
				}
			}
			
			_option.value += h_move2;
			_option.value = clamp(_option.value, 0, 100);
			_option.moving = true;
			scrollbuffer = 1;
			
			if !is_undefined(_option.on_slide)
				_option.on_slide(_option.value);
			
			trace(_option.value);
		}
		break;
}
