vsp = random_range(-5, -10);
hsp = sign(x - obj_parent_player.x) * random_range(5, 10);
grav = 0.4;
alarm[0] = 5;

if (x != obj_parent_player.x)
	image_xscale = sign(obj_parent_player.x - x);
