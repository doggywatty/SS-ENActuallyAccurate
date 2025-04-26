scr_getinput_menu();
var old_selection = optionSelection;
optionSelection += (key_right2 + key_left2);
optionSelection = clamp(optionSelection, 0, 1);
if (optionSelection != old_selection)
{
	event_play_oneshot("event:/SFX/ui/step");
	deleteFileBuffer = 0;
}
if (deleteFileBuffer >= deleteFileBufferMax)
{
	camera_shake_add(4, 5);
	global.ClassicCameraShake = 4;
	global.ClassicCameraShakeAcc = 5;
	event_play_oneshot("event:/SFX/general/explosion", 480, 270);
	with obj_mainfileselect
	{
		file_delete(savePath[other.selectedFile]);
		fileOpened[other.selectedFile] = false;
		filePalette[other.selectedFile] = 2;
		filePresent[other.selectedFile] = false;
		filePercentage[other.selectedFile] = 0;
		fileJudgment[other.selectedFile] = scr_judgment_get("none");
		flashshake[other.selectedFile] = 5;
		flashbuffer = 10;
	}
	instance_destroy();
}

if key_jump2
{
	if (optionSelection == 1)
	{
		deleteFileBuffer = 0;
		instance_destroy();
	}
	else
		deleteFileBuffer++;
}
else if (key_slap2 || key_start2)
	instance_destroy();
else
	deleteFileBuffer = 0;

image_speed = max((deleteFileBuffer / (deleteFileBufferMax - 50)) * 0.65, 0.25);
if (image_speed <= 0)
	image_index = 0;
