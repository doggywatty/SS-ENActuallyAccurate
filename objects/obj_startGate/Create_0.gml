//PA
image_index = 0;
image_speed = 0;
depth = 10;
hasInteracted = false;
rank = "none";
highscore = "0";
secrets = [false, false, false];
levelName = "";
secretcanspit = false;
gotoLevel = function(arg0)
{
	scr_gotoLevel(arg0);
	obj_camera.chargeCameraX = 0;
	with (obj_parent_player)
	{
		image_index = 0;
		if (true && global.InternalLevelName != "tutorial")
		{
			sprite_index = spr_enterpainting;
			event_play_oneshot("event:/SFX/general/enterpainting");
		}
		else
		{
			sprite_index = spr_entergate;
		}
		state = states.shotgunjump;
		targetDoor = "A";
		targetRoom = global.LevelFirstRoom;
		global.ComboLost = false;
		hubRoom = room;
		hubX = x;
		hubY = y;
	}
};
surf = -4;
easelSurf = -4;
fadewhite = 1;
details = [gate_createlayer(spr_default_startgate, 0), gate_createlayer(spr_default_startgate, 1)];
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGP
defineConfecti = function(arg0, arg1, arg2) constructor
{
	spr_idle = arg0;
	spr_run = arg1;
	spr_taunt = arg2;
};
confectiSprites = [new defineConfecti(spr_marshmellow_idle, spr_marshemellow_run, spr_marshmellow_taunt), new defineConfecti(spr_chocolate_idle, spr_chocolate_walk, spr_chocolate_taunt), new defineConfecti(spr_crack_idle, spr_crack_run, spr_crack_taunt), new defineConfecti(spr_gummyworm_idle, spr_gummyworm_walk, spr_gummyworm_taunt), new defineConfecti(spr_candy_idle, spr_candy_walk, spr_candy_taunt)];
isEasel = false;
savedPaintSprite = undefined;
//PADDINGPADDINGPADDINGPADDINGPA
saveSurfaceSprite = function()
{
	if (!surface_exists(surf))
		exit;
	var sp = sprite_create_from_surface(surf, 0, 0, sprite_width, sprite_height, false, false, 0, 0);
	if (!is_undefined(savedPaintSprite) && sprite_exists(savedPaintSprite))
	{
		sprite_assign(savedPaintSprite, sp);
		sprite_delete(sp);
	}
	else
	{
		savedPaintSprite = sp;
	}
};
//
defineObject = function(arg0, arg1) constructor
{
	xstart = arg0;
	ystart = arg1;
	x = arg0;
	y = arg1;
	sprite_index = spr_null;
	image_index = 0;
	image_speed = 0.35;
	visible = false;
	vsp = 0;
	hsp = 0;
};
secretCanvas = [new defineObject(x, y - 128), new defineObject(x, y - 128), new defineObject(x, y - 128)];
gatePointDisplay = new defineObject(x, y - 265);
with (gatePointDisplay)
{
	targetY = other.y - 265;
	landed = false;
}
gateRankBubble = new defineObject(x, y - 210);
