depth = 4;
alpha = 0;
savedIndex = global.PlayerPaletteIndex;
lockedPalettes = [];
ini_open("optionData.ini");
ini_write_real("Palettes", "palette_PZ_exhibition", true);
var locked_palettes = array_filter(scr_get_palettes(false), function(_taskKey, _pal)
{
	return !ini_read_real("Palettes", _taskKey.taskKey, false);
});
ini_close();
script_UpArrow = -4;

for (var i = 0; i < array_length(locked_palettes); i++)
{
	var palette_array = global.CharacterPalette[global.playerCharacter].palettes;
	for (var z = 0; z < array_length(palette_array); z++)
	{
		var locked_key = locked_palettes[i].taskKey;
		if (palette_array[z].palName == locked_key)
			array_push(lockedPalettes, z);
	}
}
