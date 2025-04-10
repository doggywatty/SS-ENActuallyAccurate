image_index = 0;
image_speed = 0.35;
depth = 8;
scr_collision_init();
grav = 0.4;
terminalVelocity = 50;
vsp = 25;

var target_door = obj_parent_player.targetDoor;
with obj_parent_doortrigger
{
	if (target_door == id_door)
		target_door = id;
}

x = target_door.x + (target_door.sprite_width / 2);
y = (target_door.y + (target_door.sprite_height / 2)) - camera_get_view_height(view_camera[0]) - 100;
door_inst = target_door;
falling_sound = fmod_createEventInstance("event:/SFX/elevator/falling");
fmod_studio_event_instance_start(falling_sound);

if !instance_exists(obj_cutsceneManager)
	instance_destroy();
