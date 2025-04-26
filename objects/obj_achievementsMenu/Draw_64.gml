draw_sprite_tiled(bg_pausescreenTile, 0, bgx--, bgy--);
draw_set_font(global.fontDefault);
var rowTotal = array_length(levelArr);
var ylen = (taskPadY * (rowTotal - 1) * (outfitRows - 1)) + 32;
draw_sprite_stretched_ext(spr_achmenu_body, 0, 0, scrollFactor, 960, ylen, c_ltgray, 1);
draw_set_color((selectH == 0 && selectV == -1) ? c_white : c_dkgray);
draw_text(128, 128 + scrollFactor, lang_get("opt_back"));
var textArr = [];
var by = (rowTotal * taskPadY) + (camera_get_view_height(view_camera[0]) / 2) + scrollFactor;
var _final_scroll = 0;

for (var i = 0; i < rowTotal; i++)
{
	var taskArr = variable_struct_get(taskIcons, array_get(levelArr, i));
	var rowSelected = i == selectV;
	var rowY = (i * taskPadY) + (camera_get_view_height(view_camera[0]) / 2) + scrollFactor;
	var a = clamp((-rowY / 240) + 2.5, 0, 1);
	draw_set_alpha(a);
	
	var nm = "";
	if (array_contains(floorArr, levelArr[i]))
		nm = string_upper(lang_get($"floor_{levelArr[i]}"));
	else
		nm = string_upper(lang_get($"level_{levelArr[i]}"));
	
	draw_set_font(global.fontDefault);
	draw_set_color(rowSelected ? c_white : c_dkgray);
	draw_text_scribble(camera_get_view_width(view_camera[0]) / 2, rowY - string_height("A") - 32, $"[fa_bottom][fa_center]{nm}");
	var len = array_length(taskArr);
	
	for (var j = 0; j < len; j++)
	{
		var task = taskArr[j];
		var isSelected = rowSelected && j == selectH;
		
		var c = c_dkgray;
		if rowSelected
			c = c_ltgray;
		if isSelected
		{
			c = c_white;
			task.y = round(lerp(task.y, -16, 0.3));
		}
		else
			task.y = round(lerp(task.y, 0, 0.3));
		
		var spr = task.get("taskSprite") ?? spr_null;
		var ind = task.get("taskIndex");
		if !task.isCompleted
			ind += floor(sprite_get_number(spr) / 2);
		
		var xlen = (len - 1) * taskPadX;
		var XS = (camera_get_view_width(view_camera[0]) - xlen) / 2;
		var taskX = XS + (j * taskPadX) + task.x;
		var taskY = rowY + task.y + 20;
		draw_sprite_ext(spr, ind, taskX, taskY, 1, 1, 0, c, a);
		
		if isSelected
		{
			array_push(textArr, lang_get(task.get("taskKey")));
			array_push(textArr, lang_get($"{task.get("taskKey")}_desc"));
		}
	}
}

draw_set_color((selectV > (rowTotal - 1)) ? c_white : c_dkgray);

for (var i = 1; i <= array_length(outfitArr); i++)
{
	var currentRow = ceil(i / 3) - 1;
	var rowY = by + (currentRow * taskPadY);
	draw_set_font(global.fontDefault);
	
	if (i == 1)
		draw_text_scribble(camera_get_view_width(view_camera[0]) / 2, rowY - string_height("A") - 24, $"[fa_bottom][fa_center]{lang_get("menutask_clothes")}");
	
	var rowSelected = (currentRow + rowTotal) == selectV;
	draw_set_color(rowSelected ? c_white : c_dkgray);
	var a = clamp((-rowY / 240) + 2.5, 0, 1);
	draw_set_alpha(a);
	var xind = (i - 1) % 3;
	var xlen = 2 * taskPadX;
	
	if (currentRow == (outfitRows - 1))
		xlen = ((array_length(outfitArr) - 1) % 3) * taskPadX;
	
	var task = outfitArr[i - 1];
	var isSelected = rowSelected && xind == selectH;
	var XS = (camera_get_view_width(view_camera[0]) - xlen) / 2;
	var taskX = XS + (xind * taskPadX) + task.x + (irandom_range(-1, 1) * isSelected);
	var taskY = rowY + task.y + (irandom_range(-1, 1) * isSelected) + 20;
	
	var c = c_dkgray;
	if rowSelected
		c = c_ltgray;
	if isSelected
	{
		c = c_white;
		task.y = round(lerp(task.y, -16, 0.3));
	}
	else
		task.y = round(lerp(task.y, 0, 0.3));
	
	var palind = 0;
	var palpattern = -4;
	var ind = 0;
	
	if !task.isCompleted
		c = 0;
	
	switch task.get("taskKey")
	{
		case "palette_PZ_exhibitionred":
			ind = 5;
			palind = 1;
			break;
		case "palette_PZ_exhibitionblack":
			ind = 6;
			palind = 2;
			break;
		case "palette_PZ_exhibitionpurple":
			ind = 5;
			palind = 3;
			break;
		case "palette_PZ_noise":
			ind = 6;
			palind = 4;
			break;
		case "palette_PZ_exhibitionbrain":
			ind = 4;
			palind = 9;
			break;
		case "palette_PZ_exhibitionbraingold":
			ind = 4;
			palind = 10;
			break;
		case "palette_PZ_exhibitionpaper":
			ind = 7;
			palind = 12;
			break;
		case "palette_PZ_exhibitionentryway":
			ind = 0;
			palind = 5;
			break;
		case "palette_PZ_exhibitionsteamy":
			ind = 1;
			palind = 6;
			break;
		case "palette_PZ_exhibitionmineshaft":
			ind = 2;
			palind = 7;
			break;
		case "palette_PZ_exhibitionmolasses":
			ind = 3;
			palind = 8;
			break;
	}
	
	pal_swap_set(spr_patchpalettes, palind, false);
	draw_sprite_ext(spr_outfitpatches, ind, taskX, taskY, 1, 1, 0, c, a);
	shader_reset();
	
	if isSelected
	{
		if task.isCompleted
		{
			array_push(textArr, lang_get(task.get("taskKey")));
			array_push(textArr, lang_get($"{task.get("taskKey")}_desc"));
		}
		else
		{
			array_push(textArr, lang_get("menutask_unknown"));
			array_push(textArr, lang_get($"{task.get("taskKey")}_hint"));
		}
	}
}

draw_set_alpha(1);
draw_set_color(c_white);

if (array_length(textArr) > 0)
{
	draw_sprite_general(spr_darttrap_lightgradient, 0, 0, 0, 300, 300, 0, camera_get_view_height(view_camera[0]), 0.65, 4, 90, c_black, c_black, c_black, c_black, 1);
	var txt = "[fa_middle][promptfont][fa_center]";
	
	for (var i = 0; i < array_length(textArr); i++)
		txt += $"{textArr[i]}\n";
	
	var scrib = scribble(txt);
	scrib.wrap(camera_get_view_width(view_camera[0]) - 200);
	scrib.draw(camera_get_view_width(view_camera[0]) / 2, camera_get_view_height(view_camera[0]) * 0.85);
}
