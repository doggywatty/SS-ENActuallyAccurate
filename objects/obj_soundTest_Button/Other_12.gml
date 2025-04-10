sprite_index = spr_soundTest_button;
with obj_soundTest
{
    currentSelection++;
    currentSelection = wrap(currentSelection, 0, array_length(musicArray) - 1);
}
