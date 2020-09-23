/* 
virtualPb(가상 블록 : 시뮬레이션을 위한 블록)의 현재 위치를 기준으로 인접한 adjoinBlocks(근처의 테트리스 블록들)이 있는지를 체크하고 개수를 센다.
동서남북으로 인접한 4방향 (i,j) => (i-1, j), (i+1, j), (i, j-1), (i, j+1) 필드를 검사한다.
*/

var countBlock = 0;		//All AdjoinBlocks
var y = virtualPb[i, 0];
var x = virtualPb[i, 1];
for (var i=0; i<4; i++)
{
	var ny = y + DY[i];
	var nx = x + DX[i];
	if (ny < 0 || nx < 0 || ny >= M || nx >= N)	//N, M?
		continue;
	
	if (virtualField[ny, nx] != -1)
		countBlock++;
}

return countBlock;
