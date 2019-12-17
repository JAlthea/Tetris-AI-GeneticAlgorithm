/*  하나의 블록에 대해서 모든 가능한 경우의 수를 좌표에 시뮬레이션  */

var countBlockFigure = 4;	//Min : 1 (ex: 'O' figure), Max : 4 (ex: 'L' figure)
var indexMax = 10;	//Frame Width

//실제 블록들의 정보를 가상의 블록에 복사한다.
virtualPc[4,2] = 0;
tmp[4,2] = 0;
for (var i=0; i<4; i++)
{
	virtualPc[i,0] = pa[i,0];
	virtualPc[i,1] = pa[i,1];
}
for (var i=0; i<M; i++)
	for (var j=0; j<N; j++)
		virtualField[i,j] = field[i,j];

var maxSum = -9999;
for (var j=0; j<countBlockFigure; j++)
{
	var countX = 0;
	var countY = 0;
	for (var index=0; index<indexMax; index++)
	{
		//Move X Index
		for (var i=0; i<4; i++)
		{
			virtualPb[i,0] = virtualPc[i,0];
			virtualPb[i,1] = virtualPc[i,1];
			virtualPa[i,0] = virtualPc[i,0];
			virtualPa[i,1] = virtualPc[i,1];
			
			virtualPa[i,0] += index;
			countX = index;
		}
		if (!checkArrayIndex())	//Return X
		{
			countX--;
			for (var i=0; i<4; i++)
			{
				virtualPa[i,0] = virtualPb[i,0];
				virtualPa[i,1] = virtualPb[i,1];
			}
			
			continue;
		}
	
        //Drop Y
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
		
		countY = tmpY - 1;
		
		for (var i=0; i<4; i++)
			virtualField[virtualPb[i,1],virtualPb[i,0]] = nowColor;
		
		var tmpValue = calcWeights();
		if (maxSum < tmpValue)
		{
			maxSum = tmpValue;
			saveBlockPosition[0] = countX;
			saveBlockPosition[1] = countY;
			saveBlockPosition[2] = j;
			
			//sum 값 중에서 가장 높은 값을 이에 해당하는 실제 블록 위치에 놓는다.
			for (var i=0; i<4; i++)
			{
				tmp[i,0] = virtualPb[i,0];
				tmp[i,1] = virtualPb[i,1];
			}
		}
		
		//하나의 시뮬레이션이 끝났으므로 원래대로 되돌린다.
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
	
	/* 회전 후, 인덱스를 다시 0이 될 때까지(왼쪽 벽) 왼쪽으로 옮겨준다. */
	//Move +X +Y Index
	for (var i=0; i<4; i++)
	{		
		virtualPc[i,0] += 3;
		virtualPc[i,1] += 3;
		
		virtualPa[i,0] = virtualPc[i,0];
		virtualPa[i,1] = virtualPc[i,1];
		virtualPb[i,0] = virtualPc[i,0];
		virtualPb[i,1] = virtualPc[i,1];
	}
	
	//Rotate
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
	
	//Move -X Index
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
	
	//Move -Y Index
	var t = 1;
	while (t)
	{
		for (var i=0; i<4; i++)
		{
			virtualPb[i,1] = virtualPa[i,1];
			virtualPc[i,1] = virtualPa[i,1];
			
			virtualPa[i,1] -= 1;
			if (virtualPa[i,1] < 0)
				t = 0;
		}		
	}
}