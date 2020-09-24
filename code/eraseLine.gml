/* Erase lines */

var countRemovedLine = 0;
var k = M - 1;
for (var i=k; i>=tetrisborderLine+topEmptySpace; i--)
{
	var count = 0;
	for (var j=0; j<N; j++)
		if (field[i,j] != -1)
			count++;

    if (count < N)
		k--;
	else
		countRemovedLine++;

	for (var j=0; j<N; j++)
		field[k,j] = field[i-1,j];
}

return countRemovedLine;
