/*  하나의 블록에 대해서 모든 가능한 경우의 수를 좌표에 시뮬레이션  */

var countBlockFigure = 4;	//Min : 1 (ex: 'O' figure), Max : 4 (ex: 'L' figure)

//실제 블록들의 정보를 가상의 블록에 복사한다.
virtualPc[4,2] = 0;	//virtual block for calc
fitBlocks[4,2] = 0;	//가장 높은 적합도를 갖는 위치를 기억하기 위한 변수
for (var i=0; i<4; i++)
{
	virtualPc[i,0] = pa[i,0];
	virtualPc[i,1] = pa[i,1];
}
for (var i=0; i<M; i++)
	for (var j=0; j<N; j++)
		virtualField[i,j] = field[i,j];

//Simulation
var maxFitnessValue = -9999;
for (var nowFigure=0; j<countBlockFigure; j++)
{
	var dx = 0;
	var dy = 0;
	for (var index=0; index<N; index++)
	{
		//X를 +index만큼 움직인다. (dx 갱신)
		for (var i=0; i<4; i++)
		{
			virtualPb[i,0] = virtualPc[i,0];
			virtualPb[i,1] = virtualPc[i,1];
			virtualPa[i,0] = virtualPc[i,0];
			virtualPa[i,1] = virtualPc[i,1];
			
			virtualPa[i,0] += index;
			dx = index;
		}
		
		//X를 움직였을 때, 배열의 범위를 벗어나면 원래대로 복구한다.
		if (!checkArrayIndex())
		{
			dx--;
			for (var i=0; i<4; i++)
			{
				virtualPa[i,0] = virtualPb[i,0];
				virtualPa[i,1] = virtualPb[i,1];
			}
			continue;
		}
	
        	//Y를 +1씩 바닥이나 다른 블록에 닿을 때까지 움직인다. (dy 갱신)
		var tmpY = 0;
		while (checkArrayIndex())
		{
			for (var i=0; i<4; i++)
			{
				virtualPb[i,0] = virtualPa[i,0];
				virtualPb[i,1] = virtualPa[i,1];
				
				virtualPa[i,1] += 1;
			}
			tmpY++;
		}
		dy = tmpY - 1;
		
		//적합도 계산을 위해서 움직인 블록의 위치를 가상 필드에 저장한다.
		for (var i=0; i<4; i++)
			virtualField[virtualPb[i,1],virtualPb[i,0]] = nowColor;
		
		var nowFitnessValue = calcWeights();
		if (maxFitnessValue < nowFitnessValue)	//적합도 결과값이 최고치를 갱신하는 경우
		{
			maxFitnessValue = nowFitnessValue;
			
			//움직이고 회전한 정보(x, y, figure)를 저장한다.
			saveBlockPosition[0] = dx;
			saveBlockPosition[1] = dy;
			saveBlockPosition[2] = nowFigure;
			
			//가장 높은 값을 이에 해당하는 블록을 저장한다.
			for (var i=0; i<4; i++)
			{
				fitBlocks[i,0] = virtualPb[i,0];
				fitBlocks[i,1] = virtualPb[i,1];
			}
		}
		
		/* X축에 대한 하나의 시뮬레이션이 끝났으므로 다음 시뮬레이션을 위해 이전 상태로 가상 필드와 가상 블록을 되돌린다. */
		for (var i=0; i<4; i++)
			virtualField[virtualPb[i,1],virtualPb[i,0]] = -1;
		for (var i=0; i<4; i++)
		{
			virtualPb[i,0] = virtualPc[i,0];
			virtualPb[i,1] = virtualPc[i,1];
			virtualPa[i,0] = virtualPc[i,0];
			virtualPa[i,1] = virtualPc[i,1];
		}
	}
	
	/* Y축에 대한 하나의 시뮬레이션이 끝났으므로 다음 시뮬레이션을 위해 이전 상태로 가상 필드와 가상 블록을 되돌린다. */
	//Rotate
	//블록이 회전하기 충분한 위치로 이동시킨다.
	for (var i=0; i<4; i++)
	{		
		virtualPc[i,0] += 3;
		virtualPc[i,1] += 3;
		
		virtualPa[i,0] = virtualPc[i,0];
		virtualPa[i,1] = virtualPc[i,1];
		virtualPb[i,0] = virtualPc[i,0];
		virtualPb[i,1] = virtualPc[i,1];
	}
	
	//이전 상태로 회전시킨다.
	virtualP = [virtualPa[1,0], virtualPa[1,1]];
	for (var i=0; i<4; i++)
	{
		var cx = virtualPa[i,1] - virtualP[1];
		var cy = virtualPa[i,0] - virtualP[0];
		virtualPa[i,0] = virtualP[0] - cx;
		virtualPa[i,1] = virtualP[1] + cy;
	}
	if (!checkArrayIndex())
	{
		for (var i=0; i<4; i++)
		{
			virtualPa[i,0] = virtualPc[i,0];
			virtualPa[i,1] = virtualPc[i,1];
		}
	}
	
	//Move -X : 인덱스를 다시 0이 될 때까지(왼쪽 벽) 왼쪽으로 옮겨준다.
	while (checkArrayIndex())
	{
		for (var i=0; i<4; i++)
		{
			virtualPb[i,0] = virtualPa[i,0];
			virtualPb[i,1] = virtualPa[i,1];
			virtualPc[i,0] = virtualPa[i,0];
			virtualPc[i,1] = virtualPa[i,1];
			
			virtualPa[i,0] -= 1;
		}
	}
	if (!checkArrayIndex())
	{
		for (var i=0; i<4; i++)
		{	
			virtualPa[i,0] = virtualPb[i,0];
		}
	}
	
	//Move -Y : 인덱스를 다시 처음 위치가 될 때까지(위) 위쪽으로 옮겨준다.
	var t = true
	while (t)
	{
		for (var i=0; i<4; i++)
		{
			virtualPb[i,1] = virtualPa[i,1];
			virtualPc[i,1] = virtualPa[i,1];
			
			virtualPa[i,1] -= 1;
			if (virtualPa[i,1] < 0)
				t = false;
		}		
	}
}
