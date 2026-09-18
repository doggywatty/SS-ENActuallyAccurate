if ((dialogCurrent + 1) < array_length(dialogEvents))
{
	chatty = true;
	dialogCurrent++;
	typist.reset();
}
else
{
	chatty = false;
	progression = 2;
}
