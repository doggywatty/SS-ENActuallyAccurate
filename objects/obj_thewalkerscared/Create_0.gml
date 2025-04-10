depth = -1;
image_speed = 0.35;
moving = false;
ini_open(global.SaveFileName);
if (ini_read_string("Misc", "YouScaredTheWalker", "0") != "0")
    instance_destroy();
