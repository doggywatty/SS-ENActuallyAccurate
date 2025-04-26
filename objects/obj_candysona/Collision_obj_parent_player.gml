if !instance_exists(candyID)
{
    candyID = instance_create(x, y, obj_collect_giver);
    global.PizzaMeter += 5;
    scr_queueTVAnimation(global.TvSprPlayer_Happy, 150);
    create_small_number(x, y, "150");
    scr_ghostcollectible(true);
    global.ComboTime = 60;
    alarm[0] = 3;
    state = States.jump;
    flash = true;
    alarm[1] = 0.15 * room_speed;
    sprite_index = baddieSpriteDead;
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_bangEffect);
	repeat 3
	{
		with create_debris(x, y, spr_slapstar)
		{
			hsp = random_range(-5, 5);
			vsp = random_range(-10, 10);
		}
		create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
	}
    event_play_oneshot("event:/SFX/enemies/kill");
    vsp = random_range(-5, -10);
    ds_list_add(global.SaveRoom, id);
    hsp = sign(x - obj_parent_player.x) * random_range(10, 15);
    if (x != obj_parent_player.x)
        image_xscale = sign(obj_parent_player.x - x);
}

