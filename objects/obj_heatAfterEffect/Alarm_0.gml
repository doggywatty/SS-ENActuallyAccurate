x = playerID.x;
y = playerID.y;
visible = false;
if (global.Combo >= 10 && room != rank_room)
    visible = playerID.visible;
alpha = 0.25;
if (global.Combo >= 50)
    alpha = 0.5;
vSpeed = random_range(-1, 1);
hSpeed = random_range(-1, 1);
alarm[0] = 10;
