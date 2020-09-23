var x = pa[i,0];
var y = pa[i,1];
for (var i=0; i<4; i++)
	if (x < 0 || x >= N || y >= M || y < topEmptySpace || field[y, x] != -1) 
		return false;
return true;
