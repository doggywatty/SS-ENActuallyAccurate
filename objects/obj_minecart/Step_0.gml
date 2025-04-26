var _player = instance_nearest(x, y, obj_parent_player);
var player_minecart = scr_transformationCheck(_player.state) == "Minecart";
if (place_meeting(x, y - 4, _player) && !player_minecart)
{
	grabbedMinecart = true;
	_player.state = States.minecart;
	if (_player.xscale == image_xscale)
		_player.movespeed = clamp(_player.movespeed, 3, 12);
	else
		_player.movespeed = clamp(_player.movespeed / 4, 3, 12);
	
	_player.vsp = -6;
	_player.sprite_index = spr_player_PZ_minecart;
	_player.x = x;
	_player.y = y;
	_player.xscale = image_xscale;
	_player.hurted = false;

	if !instance_exists(obj_poofeffect)
		instance_create(x, y, obj_poofeffect);
	
	for (var i = 0; i < (sprite_get_number(spr_coalDebris) - 1); i++)
	{
		with (create_debris(x + random_range(-10, 10), y + random_range(-10, 10), spr_coalDebris))
			image_index = i;
	}
}

if player_minecart
	image_alpha = 0.5;
else
	image_alpha = 1;
