scr_getinput_menu();

if (event > 0 && (sprite_index == spr_rankP || sprite_index == spr_rankPend))
{
	x = round(lerp(x, camera_get_view_width(view_camera[0]) / 4, 0.1));
	if (sprite_index == spr_rankP)
	{
		sprite_index = spr_rankPend;
		image_index = 0;
	}
}

if (sprite_index == spr_player_PZ_enter)
{
	if (distance_to_point(480, 270) > 2)
	{
		x = lerp(x, 480, 0.05);
		y = lerp(y, 270, 0.05);
	}
	else
	{
		x = 480;
		y = 270;
	}
}

if (sprite_animation_end())
{
	image_speed = 0;
	image_index = image_number - 1;
}
else if (sprite_index == spr_rankPend)
	image_speed = 0.35;
else
	image_speed = 0.45;

for (var i = 0; i < array_length(confecti_index); i++)
{
	if (floor(confecti_index[i]) < (sprite_get_number(confecti_sprites[i]) - 1))
		confecti_index[i] += 0.35;
}

var _collect_sfx = false;
switch event
{
	case 1:
		clipboardY = lerp(clipboardY, 0, 0.06);
		clipboardY = approach(clipboardY, 0, 1);
		if key_jump
			clipboardY = 0;
		if clipboardY == 0
		{
			event++;
			event_buffer = 60;
		}
		break;
	case 2:
		if key_jump
			event_buffer = 0;
		if !event_buffer--
		{
			combo_shown = true;
			event_buffer = 60;
			event++;
			event_play_oneshot("event:/SFX/enemies/killingblow");
		}
	case 3:
		if key_jump
			event_buffer = 0;
		if !event_buffer--
		{
			damage_shown = true;
			event_buffer = 90;
			event++;
			event_play_oneshot("event:/SFX/enemies/killingblow");
		}
	case 4:
		if key_jump
		{
			while event == 4
				revealConfecti();
			key_jump = false;
		}
		if !event_buffer--
			revealConfecti();
		break;
	case 5:
		if key_jump
		{
			while event == 5
				revealSecret();
			key_jump = false;
		}
		if !event_buffer--
			revealSecret();
		break;
	case 6:
		if key_jump
		{
			score_total_visual = score_total;
			event_buffer = 0;
			score_shake = 10;
		}
		
		if !event_buffer--
		{
			score_total_visual = lerp(score_total_visual, score_total, 0.15);
			score_total_visual = approach(score_total_visual, score_total, 5);
			score_shake = 3;
			_collect_sfx = true;
		}
		
		if (score_total_visual == score_total)
		{
			if global.NewHighScore
				event_play_oneshot("event:/SFX/ui/rankHighScore");
			event++;
			event_buffer = 0;
			alarm[4] = 200;
		}
		
		break;
	case 7:
		if (key_jump && alarm[4] > 1)
			alarm[4] = 1;
		break;
}

if _collect_sfx
{
	if !event_instance_isplaying(collect_sound)
		fmod_studio_event_instance_start(collect_sound);
	fmod_studio_event_instance_set_parameter_by_name(collect_sound, "state", (score_total_visual / score_total) * 10, true);
}
else if (event_instance_isplaying(collect_sound) && fmod_studio_event_instance_get_playback_state(collect_sound) != FMOD_STUDIO_PLAYBACK_STATE.STOPPING)
	fmod_studio_event_instance_stop(collect_sound, false);

bgx -= 1;
bgy += 1;
score_highscore_index += 0.35;
bgAlpha = approach(bgAlpha, 1, 0.1);
flash = approach(flash, 0, 0.1);
score_shake = approach(score_shake, 0, 0.1);
