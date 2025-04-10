var nameArr = creditEntries[currentCategory][1];
var allDone = true;
var cCount = -1;
var catLast = false;
var len = array_length(nameArr);
for (var i = 0; i < len; i++)
{
	var _ob = nameArr[i];
	if (_ob.active || !_ob.activated)
		allDone = false;
	if (_ob.activated && _ob.index > cCount)
		cCount = _ob.index;
	if (_ob.activated && i == (len - 1))
		catLast = true;
}

if !allDone && cCount == currentCredit && !catLast
	currentCredit++;
else if allDone
{
	currentCategory++;
	currentCredit++;
}
else
	alarm[0] = 2;
