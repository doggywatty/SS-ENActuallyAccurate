function scr_shell_openconsole()
{
	global.shellactivate = true;
}

function scr_shell_closeconsole()
{
	if (instance_exists(obj_pause))
	{
		obj_pause.canmove = false;
		obj_pause.alarm[0] = 3;
		obj_pause.key_jump = false;
	}
	
	if (instance_exists(obj_mainfileselect))
	{
		obj_mainfileselect.abletomove = false;
		obj_mainfileselect.alarm[0] = 3;
	}
	
	global.shellactivate = false;
}

function scr_shell_roomstart()
{
	toggle_collision_function();
	show_tiles_function();
}
