/* Rotation Next Start Block */
//Because next block frame is not fit
userP = [userNext[1,0], userNext[1,1]];
for (var i=0; i<4; i++)
{
	var cx = userNext[i,1] - userP[1];
	var cy = userNext[i,0] - userP[0];
	userNext[i,0] = userP[0] - cx;
	userNext[i,1] = userP[1] + cy;
}

/* Fit X, Y Position About Next Start Block */
for (var i=0; i<4; i++)
{
	if (userNextFigure == 0)
	{	
		userNext[i,0] += 2;
		userNext[i,1] += 2;
	}
	else if (userNextFigure == 1)
	{
		userNext[i,0] += 1;
	}
	else if (userNextFigure == 2)
	{
		userNext[i,1] += 1;
	}
	else if (userNextFigure == 3)
	{
		userNext[i,1] += 1;
	}
	else if (userNextFigure == 4)
	{
		userNext[i,0] += 1;
		userNext[i,1] += 2;
	}
	else if (userNextFigure == 5)
	{
		userNext[i,1] += 1;
	}
	else if (userNextFigure == 6)
	{
		userNext[i,1] += 2;
	}
}