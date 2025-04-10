image_speed = 0.35;
playerID = -4;
state = States.frozen;
hookStopID = instance_nearest(x, y, obj_hookstop);
if !instance_exists(hookStopID)
{
    show_debug_message($"Hook ({id}) at ({x}, {y}) didn't find stop");
    alarm[0] = 1;
}
