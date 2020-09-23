var y = virtualPa[i,0];
var x = virtualPa[i,1];
for (var i=0; i<4; i++)
	if (y < 0 || y >= M || x >= N || virtualField[virtualPa[i,1],virtualPa[i,0]] != -1)
		return 0;
return 1;
