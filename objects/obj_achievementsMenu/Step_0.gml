scr_getinput_menu();
var v_move = key_down2 - key_up2;
var h_move = key_left2 + key_right2;
var h_move2 = key_left + key_right;
var oldV = selectV;
var oldH = selectH;
selectV += v_move;
selectH += h_move;
var maxH = (selectV > -1) ? 2 : 0;
var maxV = (array_length(levelArr) + outfitRows) - 1;
if (selectV == ((array_length(levelArr) + outfitRows) - 1))
	maxH = (array_length(outfitArr) % 3) - 1;
else if (selectV < array_length(levelArr) && selectV >= 0)
	maxH = array_length(variable_struct_get(taskIcons, array_get(levelArr, selectV))) - 1;

if (oldV != selectV)
{
	if (selectV == -1)
		selectH = 0;
}

if (oldH != selectH || oldV != selectV)
	event_play_oneshot("event:/SFX/ui/step");

selectV = clamp(selectV, -1, maxV);
selectH = clamp(selectH, 0, maxH);
var vf = (selectV > -1) ? selectV : 0;
var vInterval = -taskPadY;
scrollFactor = round(lerp(scrollFactor, vf * vInterval, 0.3));

if (key_jump && selectV == -1)
	instance_destroy();
if (key_slap2 || key_start2)
	instance_destroy();
