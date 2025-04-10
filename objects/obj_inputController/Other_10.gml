global.PlayerInputDevice = -2;
scr_setTransfoTip(global.TransfoState);

if is_preGame()
{
    queueDisconnectScreen = false;
    exit;
}

if (!instance_exists(obj_fadeoutTransition) && !instance_exists(obj_endlevelfade)
&& !instance_exists(obj_techdiff) && !instance_exists(obj_titlecard) && !global.shellactivate
&& room != rank_room && room != rm_introVideo && room != rm_mainmenu && room != timesuproom
&& room != rm_credits && room != rm_disclaimer && room != rm_startupLogo && room != rm_titlecard)
{
    disconnectScreen = true;
    showtext = false;
    with obj_pause
    {
        canmove = false;
        if !global.gamePauseState
            event_user(5);
    }
    exit;
}
