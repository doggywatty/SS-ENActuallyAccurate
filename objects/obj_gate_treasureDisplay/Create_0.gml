depth = 7;
bobsin = 0;
time = 0;
collectedTreasure = false;
ini_open(global.SaveFileName);
collectedTreasure = ini_read_string("Treasure", level, 0) != "0";
ini_close();
treasureSprite = spr_treasure_entryway;
var sprite_name = $"spr_treasure_{level}";
var asset_index = asset_get_index(sprite_name);
if (asset_index != -1)
	treasureSprite = asset_index;
