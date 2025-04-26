if (video_get_status() != 0)
    video_close();

scr_initinput();
canSkip = false;
alarm[1] = 350;
showText = false;
displayVideo = false;

if (!file_exists("gamedata/intro.mp4"))
{
    trace("Intro video not found.");
    event_user(0);
    exit;
}

updateVolume = function()
{
	var attenuation_factor = fmod_studio_system_get_parameter_by_name("musicAttenuation").value;
	var real_volume = global.musicVolume * global.masterVolume * (1 - attenuation_factor);
	video_set_volume((!global.unfocusedMute || window_has_focus()) ? real_volume : 0);
};

video_open("gamedata/intro.mp4");
updateVolume();