/* 적합도 함수 : 가중치의 계수와 실제 개수를 계산하여 적합도(결과값)을 반환하는 함수. 결과값이 크면 클수록 적합하다. */

var tetrisborderLine = 4;

/* 가중치들 */
var maxHeight = 0;				//블록의 최대 높이
var countHole = 0;				//빈 공간의 개수
var bumpiness = 0;				//높이의 울퉁불퉁한 정도
var completeLine = 0;				//완전한 라인 수 (지워질 라인 수)

var heights = array_create(N, 0);	//편차를 구하기 위한 높이의 합 
//For maxHeight, countHole
for (var j=0; j<N; j++)
{
	var heightCheck = true;
	
	for (var i=tetrisborderLine+Extra; i<M; i++)
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

//For bumpiness
for (var i=0; i<N-1; i++)
	bumpiness += abs(heights[i+1] - heights[i]);

//For completeLine
for (var i=tetrisborderLine+Extra; i<M; i++)
{
	var count = 0;
	for (var j=0; j<N; j++)
		if (virtualField[i,j] != -1)
			count++;
	
	if (count == N) completeLine++;
}

//Real values in tetris
var gene = ds_list_find_value(Genes, geneIndex);	//gene = { generation, ?, weights }
var weights = gene[2];	//모든 가중치를 담고 있는 리스트
var realValueMaxHeight = ds_list_find_value(weights, 0);
var realValueCountHole = ds_list_find_value(weights, 1);
var realValueBumpiness = ds_list_find_value(weights, 2);
var realValueCompleteLine = ds_list_find_value(weights, 3);

//fitness = weight * realValue
return (realValueMaxHeight * maxHeight) + (realValueCountHole * countHole) + (realValueBumpiness * bumpiness) + (realValueCompleteLine * completeLine);
