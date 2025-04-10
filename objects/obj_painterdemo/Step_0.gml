if (room == hub_soundTest)
{
	var current_song = true;
	with obj_soundTest
		current_song = musicArray[currentSelection].eventPath == "event:/music/Soundtest/painterMixtape";
	if (obj_soundTest.pauseStatus == false)
		sprite_index = spr_painteridle;
	else if (current_song && obj_soundTest.pauseStatus == true)
		sprite_index = spr_painteridle5;
	else if (obj_soundTest.pauseStatus == true)
		sprite_index = spr_painterdance;
}
else
	sprite_index = spr_painteridle1;