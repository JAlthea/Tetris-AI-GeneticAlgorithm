/* 
virtualPb의 현재 위치를 기준으로 인접한 virtualField가 있는지를 확인한다.
Pb의 인접한 4방향(i,j) => (i-1, j), (i+1, j), (i, j-1), (i, j+1) 필드를 검사한다.
*/

var countBlock = 0;		//All AdjoinBlocks
for (var i=0; i<4; i++)
{
	var t = virtualPb[i,1] - 1;
	if (t >= 0)
	{
		if (virtualField[t, virtualPb[i,0]] != -1)
			countBlock++;
	}
	
	var t = virtualPb[i,1] + 1;
	if (t < N)
	{
		if (virtualField[t, virtualPb[i,0]] != -1)
			countBlock++;
	}

	var t = virtualPb[i,0] - 1;
	if (t >= 0)
	{
		if (virtualField[virtualPb[i,1], t] != -1)
			countBlock++;
	}

	var t = virtualPb[i,0] + 1;
	if (t < N)
	{
		if (virtualField[virtualPb[i,1], t] != -1)
			countBlock++;
	}
}

return countBlock;