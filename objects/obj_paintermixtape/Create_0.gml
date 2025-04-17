depth = -7;
image_speed = 0.35;
playerID = -4;
treasureEffect = new subSprite(spr_treasureeffect, 0, 0.35, true);
bobsin = 0;
time = 0;
ini_open(global.SaveFileName);
if (ini_read_string("Treasure", "mindpalace", "0") != "0")
    instance_destroy();
