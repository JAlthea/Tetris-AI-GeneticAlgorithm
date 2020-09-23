/* 블록에 대한 정보를 처음 상태로 되돌리는 리셋 함수 */

timer = 0;
gametimer = 0;
X = 0;
Y = 0;
countBlockFigure = 0;
bPutIn = false;
nowColor = irandom(8);	//Now Color Choice
nowFigure = irandom(6);	//Now Figure Choice
nextColor = irandom(8);	//Next Color Choice
nextFigure = irandom(6);//Next Figure Choice

/* Init Flame */
for (var i=0; i<M; i++)
	for (var j=0; j<N; j++)
		field[i,j] = -1;
		
/* Init Block */
for (var i=0; i<4; i++)
	for (var j=0; j<2; j++)
	{
		pa[i,j] = 0;
		pb[i,j] = 0;
		pc[i,j] = 0;
		next[i,j] = 0;
	}

/* Init Virtual Flame */
for (var i=0; i<M; i++)
	for (var j=0; j<N; j++)
		virtualField[i,j] = -1;	

/* Init Virtual Block */
for (var i=0; i<4; i++)
	for (var j=0; j<2; j++)
	{
		virtualPa[i,j] = 0;
		virtualPb[i,j] = 0;
	}

/* Init First Start Block */
for (var i=0; i<4; i++)
{
	pa[i,0] = figures[nowFigure, i] % 2 + blockStartX;
	pa[i,1] = floor(figures[nowFigure, i] / 2) + blockStartY;
	
	virtualPa[i,0] = pa[i,0];	//GA는 처음 블록이 나오는 좌표를 0으로 한다.
	virtualPa[i,1] = pa[i,1];
}

/* Init Next Start Block */
for (var i=0; i<4; i++)
{
	next[i,0] = figures[nextFigure, i] % 2 + blockNextX;	//Pos X
	next[i,1] = floor(figures[nextFigure, i] / 2) + blockNextY; //Pos Y
}

/* Rotation Next Start Block */
//Because next block frame is not fit
p = [next[1,0], next[1,1]];
for (var i=0; i<4; i++)
{
	var cx = next[i,1] - p[1];
	var cy = next[i,0] - p[0];
	next[i,0] = p[0] - cx;
	next[i,1] = p[1] + cy;
}

/* X, Y Next Start Block */
for (var i=0; i<4; i++)
{
	if (nextFigure == 0)
	{	
		next[i,0] += 2;
		next[i,1] += 2;
	}
	else if (nextFigure == 1)
	{
		next[i,0] += 1;
	}
	else if (nextFigure == 2)
	{
		next[i,1] += 1;
	}
	else if (nextFigure == 3)
	{
		next[i,1] += 1;
	}
	else if (nextFigure == 4)
	{
		next[i,0] += 1;
		next[i,1] += 2;
	}
	else if (nextFigure == 5)
	{
		next[i,1] += 1;
	}
	else if (nextFigure == 6)
	{
		next[i,1] += 2;
	}
}
