if player == -4
	exit;
xscale = sign(image_xscale);
var maxspd = movespeed * xscale * hurry;
if !returning
{
	hsp = approach(hsp, 0, accel * hurry);
	if (place_meeting_collision(x + hsp, y) && (!place_meeting(x + hsp, y, obj_destructibles) || place_meeting(x + hsp, y, obj_metalblock)))
	{
		returning = true;
		hsp = abs(hsp);
	}
	else
	{
		with instance_place(x + hsp, y, obj_destructibles)
		{
			if (object_index != obj_metalblock && instance_exists(self))
			{
				DestroyedBy = other.player.id;
				event_user(0);
			}
		}
	}
	if (hsp == 0)
		returning = true;
	x += hsp;
}
else
{
	hsp = approach(hsp, abs(maxspd), accel);
	var _vecx = player.x - x;
	var _vecy = (player.y + 16) - y;
	if (_vecx != 0)
		image_xscale = 2 * sign(_vecx);
	var len = sqrt(sqr(_vecx) + sqr(_vecy));
	x += ((_vecx / len) * hsp);
	y += ((_vecy / len) * hsp);
}
with instance_place(x, y, obj_destructibles)
{
	if (object_index != obj_metalblock && instance_exists(self))
	{
		DestroyedBy = other.player.id;
		event_user(0);
	}
}
with instance_place(x, y, obj_parent_enemy)
	instance_destroy();
if (place_meeting(x, y, obj_parent_player) && instance_place(x, y, obj_parent_player).id == player && throwbuffer <= 0)
	instance_destroy();
if (throwbuffer > 0)
	throwbuffer--;
image_speed = hsp / 6;
