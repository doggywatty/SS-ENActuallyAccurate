if (place_meeting(x, y, obj_cottonsolid))
    gpu_set_fog(true, #CC297A, 0, 1);

draw_self();
if (place_meeting(x, y, obj_cottonsolid))
    gpu_set_fog(false, c_black, 0, 0);
