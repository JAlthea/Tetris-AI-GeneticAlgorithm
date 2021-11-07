var x = virtualPa[i, 0];
var y = virtualPa[i, 1];
for (var i = 0; i < 4; i++) {
	if (x < 0 || x >= N || y < topEmptySpace || y >= M || virtualField[y,x] != -1) {
		return false;
	}
}
	
return true;
