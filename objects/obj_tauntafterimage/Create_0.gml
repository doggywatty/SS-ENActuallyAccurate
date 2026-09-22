event_inherited();
playerID = obj_parent_player;
image_speed = 0.5;
image_alpha = 1;
storedimage = obj_parent_player.image_index;
sprite_index = obj_parent_player.sprite_index;
color = choose(1, 2);
realcol = 
{
	r: 0,
	g: 0,
	b: 0,
	r2: 0,
	g2: 0,
	b2: 0
};
blink_time = 3;
alarm[1] = blink_time;
gonealpha = 0.85;
vanish = 0;
draw_angle = obj_parent_player.draw_angle;
hsp = 0;
vsp = 0;
