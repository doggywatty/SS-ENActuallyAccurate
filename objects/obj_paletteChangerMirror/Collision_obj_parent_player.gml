with other
{
	var inp = input_check_pressed("up") - input_check_pressed("down");
	var inpup = input_get("up").pressed || input_get("upC").pressed;
	var inpdown = input_get("down").pressed || input_get("downC").pressed;
	inp = inpup - inpdown;
	if (inp != 0 && grounded && state == States.normal)
	{
		create_particle(x, y, spr_genericPoofEffect);
		with instance_create(x, y, obj_palettemirrorclothes)
			paletteSelect = global.PlayerPaletteIndex;
		
		event_play_oneshot("event:/SFX/general/switchstart", x, y);
		global.PlayerPaletteIndex += inp;
		global.PlayerPaletteIndex = wrap(global.PlayerPaletteIndex, 1, array_length(global.CharacterPalette[global.playerCharacter].palettes) - 1);
		while (array_contains(other.lockedPalettes, global.PlayerPaletteIndex))
		{
			global.PlayerPaletteIndex += inp;
			global.PlayerPaletteIndex = wrap(global.PlayerPaletteIndex, 1, array_length(global.CharacterPalette[global.playerCharacter].palettes) - 1);
		}
		ini_open(global.SaveFileName);
		ini_write_real("Misc", $"playerPaletteIndex_{scr_getCharacterPrefix(global.playerCharacter)}", global.PlayerPaletteIndex);
		ini_close();
	}
}
