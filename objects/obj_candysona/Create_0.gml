collectvanish = false;
collectboxid = -4;
in_the_void = false;
platIndex = 0;
platAlpha = 1;
depth = 2;
state = States.normal;
candyID = -4;
scr_collision_init();
grav = 0.5;
global.collected = 0;
flash = false;
image_speed = 0.35;
gotowardsPlayer = false;

var _ind;
for (_ind = 1; sprite_exists(asset_get_index($"spr_candysona_idle{_ind + 1}")); _ind++)
{
}

var my_sona = irandom_range(1, _ind);
var sona_sprite = asset_get_index("spr_candysona_idle" + string(my_sona));
var sona_sprite_dead = asset_get_index("spr_candysona_dead" + string(my_sona));
if (sona_sprite <= -1 || sona_sprite_dead <= -1)
{
	instance_destroy(id, true);
	exit;
}

sprite_index = sona_sprite;
baddieSpriteDead = sona_sprite_dead;
