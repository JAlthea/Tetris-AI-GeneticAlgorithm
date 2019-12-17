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

/* Fit X, Y Position About Next Start Block */
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