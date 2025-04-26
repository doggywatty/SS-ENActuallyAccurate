if (sprite_index != lang_get_sprite(spr_paletteUnlock))
{
	draw_sprite(lang_get_sprite(spr_achievementText), 0, x, y);
	var _yy = y - 90;
	if (sprite_index == spr_bakertasks_en_ranks)
		_yy -= 20;
	
	draw_sprite(sprite_index, image_index, x, _yy);
}
else
	draw_player_sprite(sprite_index, 0, x, (y - 80) + bump, clothingCharacter, index_from_paletteName(clothingCharacter, taskKey));
