var _channels = 256;
var _coreflags = FMOD_INIT.NORMAL;
var _studioflags = FMOD_STUDIO_INIT.NORMAL;
global.FMODSTUDIOSYSTEM = fmod_studio_system_create();
show_debug_message("fmod_studio_system_create: " + string(fmod_last_result()));
var settings_struct = new FmodSystemAdvancedSettings();
settings_struct.random_seed = global.RandomSeed;
fmod_system_set_advanced_settings(settings_struct);
fmod_studio_system_init(_channels, _studioflags, _coreflags);
show_debug_message("fmod_studio_system_init: " + string(fmod_last_result()));
system = fmod_studio_system_get_core_system();
var path = "sound/";
var plat = "Desktop";
var banks = [];
array_push(banks, "Master.strings.bank");
array_push(banks, "Master.bank");
array_push(banks, "music.bank");
array_push(banks, "sfx.bank");
for (var i = 0; i < array_length(banks); i++)
{
	var b = working_directory + path + plat + "/" + banks[i];
	var bank = fmod_studio_system_load_bank_file(b, FMOD_STUDIO_LOAD_BANK.NORMAL);
    show_debug_message("Bank Loaded: " + string(fmod_last_result()));
    fmod_studio_bank_load_sample_data(bank);
    show_debug_message("Bank Sample Data Load: " + string(fmod_last_result()));
}

global.FMOD_DSP_FFT = fmod_system_create_dsp_by_type(FMOD_DSP_TYPE.FFT);
musicBus = fmod_studio_system_get_bus("bus:/Stereo/Music");
initializedDSP = false;
fmod_studio_bus_lock_channel_group(musicBus);
global.FMOD_DSP_FFTBuffer = buffer_create(128, buffer_fixed, 1);
global.FMOD_DSP_Value = ds_list_create();

updateFFT = function()
{
	if !initializedDSP
	{
        var channel_group = fmod_studio_bus_get_channel_group(musicBus);
        if (fmod_last_result() != FMOD_RESULT.ERR_STUDIO_NOT_LOADED)
        {
            fmod_channel_control_add_dsp(channel_group, FMOD_CHANNELCONTROL_DSP_INDEX.HEAD, global.FMOD_DSP_FFT);
            fmod_dsp_set_parameter_int(global.FMOD_DSP_FFT, FMOD_DSP_FFT.WINDOW_TYPE, FMOD_DSP_FFT_WINDOW_TYPE.RECT);
            var size = 16;
            fmod_dsp_set_parameter_int(global.FMOD_DSP_FFT, FMOD_DSP_FFT.WINDOWSIZE, size);
			initializedDSP = true;
		}
		exit;
	}
	
	ds_list_clear(global.FMOD_DSP_Value);
	buffer_seek(global.FMOD_DSP_FFTBuffer, buffer_seek_start, 0);
	
	var required_size = fmod_dsp_get_parameter_data(global.FMOD_DSP_FFT, FMOD_DSP_FFT.SPECTRUMDATA, global.FMOD_DSP_FFTBuffer);
	if (buffer_get_size(global.FMOD_DSP_FFTBuffer) < required_size)
		buffer_resize(global.FMOD_DSP_FFTBuffer, required_size);
	
	var data_size = buffer_read(global.FMOD_DSP_FFTBuffer, buffer_s32) / 2;
	var data_channels = buffer_read(global.FMOD_DSP_FFTBuffer, buffer_s32);
	for (var i = 0; i < data_channels; i++)
	{
		for (var z = 0; z < data_size; z++)
			ds_list_add(global.FMOD_DSP_Value, buffer_read(global.FMOD_DSP_FFTBuffer, buffer_f32));
	}
	
	buffer_seek(global.FMOD_DSP_FFTBuffer, buffer_seek_relative, data_size * buffer_sizeof(buffer_f32));
};

global.FMOD_default3DAttributes = 
{
	position: 
	{
		x: 0,
		y: 0,
		z: 0
	},
	velocity: 
	{
		x: 0,
		y: 0,
		z: 0
	},
	forward: 
	{
		x: 0,
		y: 0,
		z: 1
	},
	up: 
	{
		x: 0,
		y: 1,
		z: 0
	}
};
attributes3D = global.FMOD_default3DAttributes;
attributes3D.position = 
{
	x: camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2),
	y: camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2),
	z: 0
};
fmod_studio_system_set_num_listeners(1);
fmod_studio_system_set_listener_attributes(0, attributes3D);
fmod_studio_system_set_listener_weight(0, 1);
showDebug = false;
global.FMOD_EventInstances = [];
global.FMOD_OneShotList = ds_map_create();
size = 0;
set_volume_options();
fmod_studio_system_set_parameter_by_name("speakerOption", global.speakerOption, true);
global.MediaIsPlaying = false;
StartMediaMonitor();