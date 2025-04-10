with obj_soundTest
{
    pauseStatus = !pauseStatus;
    other.sprite_index = !pauseStatus ? spr_soundTest_button : spr_soundTest_buttonPressed;
}
