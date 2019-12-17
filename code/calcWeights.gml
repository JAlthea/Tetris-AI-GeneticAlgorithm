/* 가중치에 따라 구멍의 수와 높이 등을 계산하여 결과값 반환 */
var gene = ds_list_find_value(Genes, geneIndex);
var weights = gene[2];

/* 가중치들 */
var maxHeight = 0;				//블록의 최대 높이
var bumpiness = 0;				//높이의 울퉁불퉁한 정도
var countHole = 0;				//구멍의 개수
var completeLine = 0;			//완성된 줄 수

//블록의 최대 높이, 편차, 구멍을 막는 블록의 개수, 구멍의 개수를 구한다.
var heights = array_create(N, 0);	//편차를 구하기 위한 높이의 합 
for (var j=0; j<N; j++)
{
	var heightCheck = true;
	
	for (var i=4+Extra; i<M; i++)	//hardcode : 4 + Extra
	{
		if (virtualField[i,j] != -1)	//블록을 만나면
		{
			if (heightCheck)
			{
				heights[j] = M - i;
				if (maxHeight < heights[j])
					maxHeight = heights[j];
				heightCheck = false;
			}
		}
		else if (!heightCheck)
		{
			countHole++;
		}
	}
}

//울퉁불퉁한 정도 구하기
for (var i=0; i<N-1; i++)
	bumpiness += abs(heights[i+1] - heights[i]);

//완전한 라인 개수 구하기
for (var i=4+Extra; i<M; i++)	//hardcode : 4 + Extra
{
	var count = 0;
	for (var j=0; j<N; j++)
	{
		if (virtualField[i,j] != -1)
			count++;
	}
	
	if (count == N) completeLine++;
}

var f1 = ds_list_find_value(weights, 0);
var f2 = ds_list_find_value(weights, 1);
var f3 = ds_list_find_value(weights, 2);
var f4 = ds_list_find_value(weights, 3);

return (f1 * maxHeight) + (f2 * bumpiness) + (f3 * countHole) + (f4 * completeLine);