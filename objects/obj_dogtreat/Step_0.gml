if (!(obj_parent_player.state == States.doughmount || obj_parent_player.state == States.doughmountspin || obj_parent_player.state == States.doughmountballoon))
{
	image_alpha = 0.35;
	exit;
}
image_alpha = 1;
if (collectvanish && collectboxid.activated)
{
	x = xstart;
	y = ystart;
	instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_puffEffect);
	repeat 3
		instance_create(x + (sprite_width / 2) + random_range(-5, 5), y + (sprite_height / 2) + random_range(-5, 5), obj_puffEffect);
	collectvanish = false;
	in_the_void = false;
}

depth = (place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_metalblock)) ? 102 : 2;

var can_reach_player = !place_meeting(x, y, obj_destructibles) && !place_meeting(x, y, obj_metalblock) && !place_meeting(x, y, obj_gnomeTNTBlock);
if (!collectvanish || can_reach_player)
{
	if (distance_to_object(obj_parent_player) < 26 && !gotowardsPlayer)
		gotowardsPlayer = true;
}

if gotowardsPlayer
{
	move_towards_point(obj_parent_player.x, obj_parent_player.y, movespeed);
	movespeed++;
}
