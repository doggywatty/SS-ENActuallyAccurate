depth = -500;
x = 480;
y = 270;
inputBuffer = 2;
optionSelectionH = array_get_index(global.langFiles, $"{global.langName}.txt");
oldOptionSelectionH = optionSelectionH;

if (optionSelectionH == -1)
{
	trace("lang menu :: missing lang file? reset to 0");
	optionSelectionH = 0;
}

menuArrow = [new subSprite(spr_langArrow, 0, 0, false), new subSprite(spr_langArrow, 1, 0, false)];
for (var i = 0; i < array_length(menuArrow); i++)
{
	with (menuArrow[i])
	{
		x = other.x + ((i == 0) ? -215 : 215);
		offSet = 0;
	}
}
