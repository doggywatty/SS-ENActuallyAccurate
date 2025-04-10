image_speed = 0.25;
depth = 200;
shakeX = 0;
cutsceneTimer = 0;
if global.panic
	sprite_index = spr_geyserCutscene_Active;
sound = fmod_createEventInstance("event:/SFX/general/geyser");
