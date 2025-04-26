image_speed = 0.35;
depth = 0;
dartVelocity = 10;
coolDownMax = 90;
coolDown = 0;
sightRange = 600;
firedDart = false;
sawPlayer = false;

enemyDeath_SpawnBody = function()
{
	with instance_create(x, y, obj_baddieDead)
	{
		image_xscale = other.image_xscale;
		image_blend = other.image_blend;
		sprite_index = spr_dartFrog_dead;
	}
};
enemyDeath_SpawnDeathFX = function()
{
	repeat 3
		create_baddiedebris();
	create_particle(x, y, spr_bangEffect);
	event_play_oneshot("event:/SFX/enemies/kill", x, y);
	camera_shake_add(3, 3);
	enemyDeath_SpawnBody();
};
enemyDeath_awardPoints = function()
{
	global.ComboTime = 60;
	obj_parent_player.superTauntBuffer++;
	global.Combo++;
	var _score = 10 + floor(global.Combo / 2);
	global.Collect += _score;
	global.ComboScore += _score;
};

tauntBuffer = false;
angerEffect = new subSprite(spr_angryCloud);
croakingNoise = fmod_createEventInstance("event:/SFX/enemies/dartFrogProximity");
fmod_event_set3DPosition(croakingNoise, x, y);
fmod_studio_event_instance_start(croakingNoise);
