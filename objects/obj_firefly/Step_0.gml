if (lightIndex < 4)
	lightIndex += 0.35;

if (obj_parent_player.state == States.taunt)
{
	sprite_index = taunt_spr;
	exit;
}
else
	sprite_index = idle_spr;

if !movebuffer--
{
	tgt_x = xstart + irandom_range(-range, range);
	tgt_y = ystart + irandom_range(-range, range);
	movebuffer = irandom_range(30, 200);
}

if (x != tgt_x)
	image_xscale = -sign(tgt_x - x);

var _dir = point_direction(x, y, tgt_x, tgt_y);
x = approach(x, tgt_x, lengthdir_x(3, _dir));
y = approach(y, tgt_y, lengthdir_y(3, _dir));
yoffset = wave(-3, 3, 3, 60);
