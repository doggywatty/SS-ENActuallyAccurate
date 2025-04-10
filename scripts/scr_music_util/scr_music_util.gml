function set_volume_options(_master = global.masterVolume, _music = global.musicVolume, _sfx = global.soundVolume)
{
    fmod_studio_system_set_parameter_by_name("masterVolume", _master, true);
    fmod_studio_system_set_parameter_by_name("musicVolume", _music, true);
    fmod_studio_system_set_parameter_by_name("sfxVolume", _sfx, true);
}

function stop_music(_music = true)
{
    if !is_undefined(global.RoomMusic)
    {
        fmod_studio_event_instance_stop(global.RoomMusic.musicInst, _music);
        fmod_studio_event_instance_stop(global.RoomMusic.secretMusicInst, _music);
    }
    fmod_studio_event_instance_stop(global.HarryMusicInst, _music);
    fmod_studio_event_instance_stop(global.EscapeMusicInst, _music);
}
