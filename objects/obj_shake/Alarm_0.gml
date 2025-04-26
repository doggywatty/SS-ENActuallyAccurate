if (sprite_index != spr_juicedead && sprite_index != spr_coneboy)
{
	with instance_create(x, y, obj_baddieDead)
	{
		paletteSprite = other.paletteSprite;
		paletteSelect = other.paletteSelect;
		sprite_index = other.sprite_index;
		image_xscale = other.image_xscale;
		canrotate = true;
		vsp = irandom_range(-5, -15);
		hsp = choose(1, -1) * irandom_range(5, 15);
	}
}
else if (sprite_index == spr_coneboy)
{
	var i = 0;
	repeat 3
	{
		with (instance_create(x, y, obj_juiceDebris))
		{
			paletteSprite = other.paletteSprite;
			paletteSelect = other.paletteSelect;
			vsp = random_range(-10, 10);
			hsp = random_range(-10, 10);
			image_angle = 0;
			image_speed = 0;
			sprite_index = spr_coneboydebris;
			image_index = i;
		}
		i++;
	}
}
else
{
	var i = 0;
	repeat 10
	{
		with instance_create(x, y, obj_juiceDebris)
		{
			paletteSprite = other.paletteSprite;
			paletteSelect = other.paletteSelect;
			image_speed = 0;
			sprite_index = spr_juicedebris;
			image_index = i;
		}
		i++;
	}
	event_play_oneshot("event:/SFX/general/breakglass", x, y);
}
event_play_oneshot("event:/SFX/enemies/kill");
instance_destroy();
