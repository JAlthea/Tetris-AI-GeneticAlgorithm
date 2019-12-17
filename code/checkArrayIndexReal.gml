for (var i=0; i<4; i++)
{
	if (pa[i,0] < 0 || pa[i,0] >= N || pa[i,1] >= M || pa[i,1] <= 2 //hardcode : pa[i,1] <= 2 (fit frame top)
	|| field[pa[i,1], pa[i,0]] != -1) return 0;
}

return 1;