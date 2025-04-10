count++;
t = (t + 1) % 65535;
if ((t % 6) == 0)
    camera_shake_add(irandom(2), 1);

gnome_index += 0.35;
gnome_index %= sprite_get_number(gnome_sprite[dark]);
pizzelle_index += 0.35;
pizzelle_index %= sprite_get_number(pizzelle_sprite[dark]);
eyes_index += 0.35;
eyes_index %= sprite_get_number(eyes_sprite[dark]);
