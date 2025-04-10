flags.do_once = false;
ini_open(global.SaveFileName);
flags.saved_info = ini_read_string("Game", "Judgment", "none");
ini_close();

condition = function()
{
	return place_meeting(x, y, obj_parent_player) && flags.saved_info != "cutscene";
};

output = function()
{
	var p = instance_place(x, y, obj_parent_player);
	if !instance_exists(p)
		exit;
	if (p.grounded && p.hsp == 0 && p.state == States.actor)
	{
		cutscene_judgment_init();
		flags.saved_info = "cutscene";
	}
	else
	{
		p.image_speed = 0.35;
		p.sprite_index = p.grounded ? p.spr_idle : p.spr_fall;
		p.hsp = floor_ext(p.hsp / 1.2, 10);
		p.movespeed = floor_ext(p.movespeed / 1.2, 10);
		p.state = States.actor;
	}
};
