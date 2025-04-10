image_speed = 0;
depth = 50;
sprite_index = spr_secretTile_cutoff;
trueYscale = image_yscale;
image_yscale = sign(image_yscale);
random_set_seed(global.RandomSeed + x + y + image_angle);
imageIndexArray = [irandom_range(0, image_number - 1)];
repeat (abs(trueYscale) - 1)
    array_push(imageIndexArray, irandom_range(0, image_number - 1));
showCutoff = [];
random_set_seed(global.RandomSeed);
image_angle = round(image_angle / 90) * 90;
