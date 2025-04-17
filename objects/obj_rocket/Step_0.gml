x += (image_xscale * (16 + accel));
y = wave(ystart - 5, ystart + 5, 1, 2);
accel += 0.2;
if place_meeting(x, y, obj_parent_enemy)
    instance_destroy();
