/* 게임 시간에 맞춰서 한 번에 하나의 동작을 보인다. */

if (countBlockFigure != saveBlockPosition[2])
{
	while (countBlockFigure < saveBlockPosition[2])
	{
		//Move +X Index
		//Because rotation needs enough space
		for (var i=0; i<4; i++)
		{
			pc[i,0] += 3;
		
			pa[i,0] = pc[i,0];
			pa[i,1] = pc[i,1];
			pb[i,0] = pc[i,0];
			pb[i,1] = pc[i,1];
		}
	
		//Rotate
		p = [pa[1,0], pa[1,1]];
		for (var i=0; i<4; i++)
		{
			var cx = pa[i,1] - p[1];
			var cy = pa[i,0] - p[0];
			pa[i,0] = p[0] - cx;
			pa[i,1] = p[1] + cy;
		}
		if (!checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{
				pa[i,0] = pc[i,0];
				pa[i,1] = pc[i,1];
			}
		}
	
		//Move -X Index
		while (checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{
				pb[i,0] = pa[i,0];
				pb[i,1] = pa[i,1];
				pc[i,0] = pa[i,0];
				pc[i,1] = pa[i,1];
			
				pa[i,0] -= 1;
			}
		}
		if (!checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{	
				pa[i,0] = pb[i,0];
			}
		}
		
		countBlockFigure++;
	}
	
	//Move +-Y Index
	if (!checkArrayIndexReal())
	{
		while (!checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{	
				pb[i,1]++;
				pc[i,1]++;
				pa[i,1]++;
			}
		}
		if (checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{	
				pb[i,1]--;
				pc[i,1]--;
				pa[i,1]--;
			}
		}
		
		return true;
	}
	else
	{
		while (checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{	
				pb[i,1]--;
				pc[i,1]--;
				pa[i,1]--;
			}	
		}
		if (!checkArrayIndexReal())
		{
			for (var i=0; i<4; i++)
			{	
				pb[i,1]++;
				pc[i,1]++;
				pa[i,1]++;
			}
		}
		
		return true;
	}
}

/* Drop X */
if (checkArrayIndexReal() && X < saveBlockPosition[0])
{
	for (var i=0; i<4; i++)
	{
		pc[i,0] += 1;
		
		pa[i,0] = pc[i,0];
		pb[i,0] = pc[i,0];
	}

	if (!checkArrayIndexReal())
	{
		for (var i=0; i<4; i++)
		{
			pc[i,0] -= 1;
		
			pa[i,0] = pc[i,0];
			pb[i,0] = pc[i,0];
		}
	}
	
	X++;
	return true;
}

/* Drop Y */
if (checkArrayIndexReal())
{	
	for (var i=0; i<4; i++)
	{
		pc[i,1] += 1;
		
		pa[i,1] = pc[i,1];
		pb[i,1] = pc[i,1];
	}
	
	if (!checkArrayIndexReal())
	{
		for (var i=0; i<4; i++)
		{
			pc[i,1] -= 1;
		
			pa[i,1] = pc[i,1];
			pb[i,1] = pc[i,1];
		}
		
		return false;
	}
	
	return true;
}

return false;
