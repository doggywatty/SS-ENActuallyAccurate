for (var i = 0; i < array_length(fileSelectHeightRatio); i++)
{
	draw_set_alpha(1);
	var thingamajig = (selectedFile == i) ? 1 : 0;
	var jd = fileJudgment[i];
	var startedandstuff = fileOpened[i];
	var fartr = "spr_judgment_files" + string(i + 1);
	var fart = asset_get_index(fartr);
	
	if (jd != scr_judgment_get("none") && is_struct(jd) && struct_exists(jd, "properties"))
		draw_sprite(fart, jd.properties.fileindex, 135 + (210 * i), 125 - (60 * fileSelectHeightRatio[i]));
	else
		draw_sprite(spr_file_exhib, i + (3 * startedandstuff), 135 + (210 * i), 125 - (60 * fileSelectHeightRatio[i]));
	
	var fuuck = "spr_file_exhibchoose" + string(selectedFile + 1);
	var thingmabob = asset_get_index(fuuck);
	
	if (activated)
		draw_sprite_ext(thingmabob, painterIndex, 135 + (210 * i), 125 - (60 * fileSelectHeightRatio[i]), 1, 1, 0, c_white, thingamajig);
	
	shader_set(shd_titlescreenDoodle);
	
	if (surface_exists(fileDoodleSurf[i]))
		draw_surface(fileDoodleSurf[i], fileDoodlePos[i][0], fileDoodlePos[i][1]);
	
	shader_reset();
	draw_sprite_ext(spr_file_exhibframe, i, 135 + (210 * i), 125 - (60 * fileSelectHeightRatio[i]), 1, 1, 0, c_white, 1);
	
	if (abletomove && !blockedInputs && !activated)
	{
		draw_set_alpha(previewalpha);
		draw_circle_color(mouseX, mouseY, lineWidth, #30164F, #30164F, true);
		draw_set_alpha(1);
	}
	
	if (selectedFile == i)
	{
		draw_set_alpha(fileSelectHeightRatio[i]);
		draw_text_scribble(235 + (210 * i), 380 - (75 * fileSelectHeightRatio[i]), "[spr_fontPercentage][fa_center][fa_top]" + string(filePercentage[selectedFile]) + "%");
	}
}

draw_set_alpha(1);
draw_player_sprite_ext(saves_sprite, saves_index, pizzyX, pizzyY, 1, 1, 0, c_white, 1, Characters.Pizzelle, filePalette[selectedFile]);
draw_set_alpha(hudAlpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite(spr_exit_exhib, 0, 16, 32);
draw_control_sprite("menuback", 126, 60);
draw_control_sprite("menudelete", 136, 444);
draw_control_sprite("start", 600, 470);
draw_set_alpha(image_alpha);
draw_self();
