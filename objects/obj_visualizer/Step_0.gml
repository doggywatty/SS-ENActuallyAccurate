var raw_visualizer_y = ds_list_find_value(global.FMOD_DSP_Value, visualizerIndex) ?? 0;
var intensity = 5;
var visualizer_y = min(raw_visualizer_y * intensity, 1);
var target_y = lerp(bottomY, topY, visualizer_y);
y = lerp(y, target_y, 0.3);
