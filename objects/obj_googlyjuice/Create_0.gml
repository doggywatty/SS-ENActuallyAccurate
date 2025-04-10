event_inherited();
baddieSpriteIdle = undefined;
baddieSpriteWalk = spr_juicewalk;
baddieSpriteStun = spr_juicestun;
baddieSpriteScared = spr_juicescared;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_juicedead;
enemyDeath_SpawnBody = function()
{
	event_play_oneshot("event:/SFX/general/breakglass", x, y);
	var i = 0;
	repeat 10
	{
		with (instance_create(x, y, obj_juiceDebris))
		{
			paletteSprite = other.paletteSprite;
			paletteSelect = other.paletteSelect;
			image_speed = 0;
			sprite_index = spr_juicedebris;
			image_index = i;
		}
		i++;
	}
};
paletteSprite = spr_juicePalette;
paletteSelect = 1;
