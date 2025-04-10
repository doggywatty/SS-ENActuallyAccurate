vsp = random_range(-10, -18);
hsp = sign(x - obj_parent_player.x) * random_range(10, 18);

if (x != obj_parent_player.x)
	image_xscale = sign(obj_parent_player.x - x);

var p = obj_parent_player;
if (place_meeting(x, y, p))
{
	if (p.vsp < -5 || p.vsp > 5)
		vsp = p.vsp / 1.3;
	hsp += (p.hsp / 1.7);
}

grav = 0.3;
alarm[0] = 5;
drawx = x;
drawy = y;
canrotate = false;
rotatedirection = choose(-1, 0, 1);
rotatevalue = choose(0, irandom_range(-20, 20));
pal_sprite = -4;
paletteSprite = -4;
paletteSelect = -4;
col = 0;
depth = -250;
