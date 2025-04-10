obj_parent_player.targetRoom = rm_introVideo;
obj_parent_player.targetDoor = "A";
if !instance_exists(obj_fadeoutTransition)
    instance_create(x, y, obj_fadeoutTransition);
