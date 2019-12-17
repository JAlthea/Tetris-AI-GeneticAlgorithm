for (var i=0; i<4; i++)
{
	if (virtualPa[i,0] < 0 || virtualPa[i,0] >= N || virtualPa[i,1] >= M 
	|| virtualField[virtualPa[i,1],virtualPa[i,0]] != -1) return 0;
}

return 1;