if (currentCategory < 0)
{
	currentCredit = 0;
	currentCategory = 0;
}
else if (currentCategory >= categoryCount)
	fadein = true;
else
{
	for (var n = 0; n < array_length(creditEntries); n++)
	{
		var _nameArr = creditEntries[n][1];
		for (var i = 0; i < array_length(_nameArr); i++)
		{
			var _ob = _nameArr[i];
			if !_ob.active && currentCredit != _ob.index
				continue;
			else if !_ob.active && !_ob.activated && n == currentCategory
				_ob.activate();
			_ob.hsp = creditsSpeed;
			_ob.step();
		}
	}
}
