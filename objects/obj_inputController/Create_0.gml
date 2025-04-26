depth = -99;

if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}

queueDisconnectScreen = false;
disconnectScreen = false;
switchBuffer = 0;
switchBufferMax = 25;
active = true;
device_found = false;
device_selected[Deadzones.Master] = false;
device_selected[Deadzones.Vertical] = false;
disconnected_device = -2;
showtext = false;
textflash = 0;
textalpha = 1;
textflashacc = 0.002;
vibration1 = 0;
vibrationDecay1 = 0;
disconnect_text_x = 0;
disconnected_bg = [new subSprite(bg_controllerdisconnect).setFunction(function()
{
	x--;
	y -= 0.5;
}), new subSprite(bg_controllerdisconnect_dark), new subSprite(bg_controllerdisconnect_smells),
	new subSprite(bg_controllerdisconnect_icon1), new subSprite(bg_controllerdisconnect_icon2),
	new subSprite(bg_controllerdisconnect_text1), new subSprite(bg_controllerdisconnect_text2),
	new subSprite(lang_get_sprite(bg_controllerdisconnect_text3)),
	new subSprite(lang_get_sprite(bg_controllerdisconnect_text4)),
	new subSprite(lang_get_sprite(bg_controllerdisconnect_text5))
];

global.PlayerInputDevice = -2;
for (var i = 0; i < gamepad_get_device_count(); i++)
{
	if (gamepad_is_connected(i))
		global.PlayerInputDevice = i;
}
