var x = virtualPa[i,0];
var y = virtualPa[i,1];
for (var i=0; i<4; i++)
	if (y < top || x < 0 || y >= M || x >= N || virtualField[y,x] != -1)
		return false;
return true;
