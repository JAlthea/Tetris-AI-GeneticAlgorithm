for (var i=0; i<4; i++)
{
	if (userPa[i,0] < 0 || userPa[i,0] >= userN || userPa[i,1] >= userM || userPa[i,1] <= 2 //hardcode : pa[i,1] <= 2 (fit frame top)
	|| userField[userPa[i,1], userPa[i,0]] != -1) return 0;
}

return 1;