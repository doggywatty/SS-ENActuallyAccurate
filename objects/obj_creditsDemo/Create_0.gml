creditPhase = -2;
phaseBuffer = 0;
creditEntries = [];
creditLength = 0;
currentCategory = -1;
categoryCount = 0;
currentCredit = -1;
prevY = 0;
fadeAlpha = 0;
showLogo = false;
logoAlpha = 1;
fadein = false;
curtainSpr = new subSprite(spr_curtain_exhibclose, 0, 0.35, false).setPosition(-20, 0);
endScreenSpr = new subSprite(bg_endcard, 0, 0, false);
bgCredits = new subSprite(bg_credits, 0, 0, false);
bgCredits.image_blend = c_black;
bgCreditsFade = 0;
pizzelleFlick = new subSprite(spr_player_PZ_flicked, 0, 0.35, true).setPosition(room_width + 150, room_height / 2);
endScreenSpr.visible = false;
creditsSpeed = -3;
defaultSpeed = -3;
skipSpeed = -30;
killCounterArr = [];

creditEntry = function() constructor
{
	static create = function()
	{
		hsp = -2;
		if spr_idle != spr_null
		{
			with instance_create(x, y, obj_creditSona)
			{
				sprite_index = other.spr_idle;
				spr_dead = other.spr_dead;
				other.object_id = id;
				x = other.x;
				y = other.y - 50;
				index = other.index;
			}
		}
	};
	
	static activate = function()
	{
		trace($"Activated Credit ({obj_creditsDemo.currentCategory}, {index}): {name}");
		active = true;
		activated = true;
		visible = true;
		y = 300;
		x = xstart;
	};
	
	static step = function()
	{
		x += hsp;
		y += vsp;
		if (x <= freezePoint && !hasFroze)
		{
			hasFroze = true;
			trace("Frozen");
			obj_creditsDemo.alarm[0] = 5;
		}
		if x < -200
		{
			visible = false;
			active = false;
		}
		if object_id != -4
		{
			if !object_id.dead
			{
				object_id.x = x;
				object_id.y = y - 50;
				object_id.visible = visible;
			}
			else
				image_blend = c_yellow;
		}
	};
	
	static draw = function()
	{
		if !visible
			exit;
		draw_set_color(c_white);
		var imgspacing = 80;
		var ilen = array_length(creditedImages);
		if ilen > 4
			imgspacing = 50;
		var xs = x - (((ilen - 1) * imgspacing) / 2);
		for (var i = 0; i < ilen; i++)
		{
			if (x > freezePoint)
				break;
			var sp = creditedImages[i];
			sp.visible = true;
			sp.image_xscale = approach(sp.image_xscale, 1, 0.25);
			sp.image_yscale = approach(sp.image_yscale, 1, 0.25);
			sp.draw(sp.x + xs + (i * imgspacing), sp.y + y + 96);
			if (sp.image_xscale > 1)
				break;
			if image_blend == c_yellow
			{
				sp.y += 6 * (obj_creditsDemo.creditsSpeed / obj_creditsDemo.defaultSpeed);
				sp.image_alpha = approach(sp.image_alpha, 0, 0.02);
			}
		}
		with object_id
		{
			visible = true;
			if flash
				draw_self_flash(c_white);
			else if (other.playerPalette)
				draw_player_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha, Characters.Pizzelle, 2);
			else
				draw_self();
		}
		
		draw_set_color(image_blend);
		draw_text_scribble(x, y, $"[fa_center][fa_top][smallfont]{string_upper(name)}");
	};
	
	static addPaintTopper = function(paint_Topper)
	{
		if !is_array(paint_Topper) && is_real(paint_Topper)
			paint_Topper = [paint_Topper];
		for (var i = 0; i < array_length(paint_Topper); i++)
		{
			var sp = new subSprite(spr_paintertopper, paint_Topper[i], 0, false);
			sp.image_xscale = 3;
			sp.image_yscale = 3;
			sp.visible = false;
			array_push(creditedImages, sp);
		}
	};
	
	static setImages = function(imgs)
	{
		for (var i = 0; i < argument_count; i++)
		{
			var arr = argument[i];
			var sp = new subSprite(arr[0], arr[1], 0, false);
			sp.image_xscale = 3;
			sp.image_yscale = 3;
			sp.visible = false;
			array_push(creditedImages, sp);
		}
	};
	
	active = false;
	activated = false;
	spr_idle = spr_null;
	spr_dead = spr_null;
	object_id = -4;
	index = -1;
	name = "";
	playerPalette = false;
	freezePoint = room_width - 128;
	freezeBuffer = 0;
	hasFroze = false;
	x = 1200;
	y = -500;
	xstart = 1200;
	visible = false;
	image_blend = c_white;
	hsp = 0;
	vsp = 0;
	accelh = 0;
	accelv = 0;
	creditedImages = [];
	return self;
};

addCredit = function(category, _name, _candysona = [spr_null, spr_null])
{
	var c = new creditEntry();
	c.name = _name;
	c.spr_idle = _candysona[0];
	c.spr_dead = _candysona[1];
	c.index = -1;
	c.create();
	array_push(category, c);
	creditLength++;
	return c;
};

addCategory = function(category)
{
	var arr = [];
	array_push(creditEntries, [lang_get(category), arr]);
	killCounterArr[categoryCount] = 0;
	categoryCount++;
	return arr;
};

with obj_parent_player
{
	targetDoor = "A";
	state = States.titlescreen;
}
event_user(0);
