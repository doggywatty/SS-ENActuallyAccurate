event_inherited();
secretActivated = true;
ini_open(global.SaveFileName);
var level_array = ["entryway", "steamy", "mineshaft", "molasses"];
for (var i = 0; i < array_length(level_array); i++)
{
	for (var j = 0; j < 3; j++)
	{
		var check = ini_read_real("Secret", level_array[i] + string(j + 1), 0) ? true : false;
		if !check
		{
			secretActivated = false;
			break;
		}
	}
}
if (ini_read_string("Game", "Judgment", "none") == "none")
	secretActivated = false;
if (secretActivated && ini_read_string("Treasure", "mindpalace", "0") == "1" && !ini_read_real("Game", "mixtape_prompt", false))
{
	scr_queueToolTipPrompt(lang_get("prompt_mixtape_soundtest"));
	ini_write_real("Game", "mixtape_prompt", true);
}
ini_close();
