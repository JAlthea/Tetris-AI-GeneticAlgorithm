for (var j=0; j<N; j++)
{
	/* Gameover Condition */
	if (field[3 + Extra, j] != -1 || nowBlockCount >= maxBlockCount)	//hardcode : 3 + Extra
	{
		/* Only One Gene Mode (Ex: SetWeights, PlayWithGA) */
		if (inputGeneration == 99)
		{
			show_message("설정한 가중치로 게임이 끝났습니다. \n");
			game_restart();
			break;
		}
		else if (inputGeneration == 100)
		{
			show_message("와 승리하셨어요! 다음 레벨에 도전해봐요~ \n");
			game_restart();
			break;
		}
		
		
		
		
		
		/* Game Repeat Statement */
		nowBlockCount = 0;
		nowTotalScore += gameScore;
		gameScore = 0;
		gametimer = 0;
		if (nowRepeatGame == maxRepeatGame || nowTotalScore == 0)	//For Worst Gene Cleared Line 0
		{	
			/* Update Total Scores */
			var g = ds_list_find_value(Genes, geneIndex);
			g[0] = nowTotalScore;	//Apply GameScore

			if (ds_list_find_index(Scores, g[0]) == -1)
			{
				ds_list_add(Scores, g[0]);	//Add Scores
			}
			else
			{
				var gap = 0.01;
				while (ds_list_find_index(Scores, g[0] - gap))
				{	
					gap += 0.01;
				}
				ds_list_add(Scores, g[0] - gap);	//Update Scores (Deduplication)
				g[0] -= gap;
			}
			ds_list_replace(Genes, geneIndex, getGene(g[0], g[1], g[2]));
			
			nowRepeatGame = 0;
			nowTotalScore = 0;
			geneIndex++;
		}
		else
		{
			nowRepeatGame++;
		}
		
		/* Terminate Now Generation */
		if (geneIndex == genePoolSize)
		{
			generation++;
			
			/* 
			Part 1. <Rank Based Sorting>
			적합도가 높은 개체 순으로 정렬한다.
			*/
			
			/* Sorting Based On Score (Score, Weights) */
			var sortedList = ds_map_create();
			for (var i=0; i<genePoolSize; i++)
			{
				var tmpGene = ds_list_find_value(Genes, i);
				ds_map_add(sortedList, tmpGene[0], tmpGene[2]);		
			}
			ds_list_clear(Genes);
			ds_list_sort(Scores, false);	//Descending Sort
			bestScore = ds_list_find_value(Scores, 0);
			for (var i=0; i<genePoolSize; i++)
			{
				var nowScore = ds_list_find_value(Scores, i);
				var nowWeights = ds_map_find_value(sortedList, nowScore);
				ds_list_add(Genes, getGene(nowScore, generation, nowWeights));
			}
			
			/* Save Weights of All Genes */
			saveWeightsToFile(Genes);
			
			/* 
			Part 2. <Selection & Crossover & Mutation Calculate>
			선택연산, 교차연산, 변이연산을 통해서 후대의 유전자들을 대체한다.
			*/
			
			
			/*
			// 최우수 유전자(1개) : 그대로 다음 세대로 넘긴다. (엘리트 개체의 보존을 위함)
			var eliteInfo = 0;
			var bestGene = ds_list_find_value(Genes, 0);
			var bestWeights = bestGene[2];
			for (var j=0; j<weightCount; j++)
				eliteInfo += ds_list_find_value(bestWeights, j);
			eliteInfo /= weightCount * maxWeightValue;
			*/
			
			/*
			for (var i=1; i<genePoolSize; i++)
			{
				var nowGene = ds_list_find_value(Genes, irandom(genePoolSize - 1));
				var nowWeights = nowGene[2];
				for (var j=0; j<weightCount; j++)
				{
					var r = random_range(-eliteInfo, eliteInfo);
					var nowWeight = ds_list_find_value(nowWeights, j);
					if (nowWeight + r >= maxWeightValue)
						nowWeight -= r;
					else if (nowWeight + r <= -maxWeightValue)
						nowWeight -= r;
					else
						nowWeight += r;
					
					ds_list_replace(nowWeights, j, nowWeight);
				}
				
				ds_list_replace(Genes, i, getGene(0, generation, nowWeights));
			}
			*/
			
			
			/* 
			개선된 유전자(30%) : 교차연산을 전체 인구의 30%가 될 때까지 반복한다.
			임의의 유전자(10%)중에서 가장 적합한 두 부모를 교차연산하여 나머지 유전자들을 만든다.
			*/
			var computedGenes = ds_list_create();
			var nowGenePoolSize = 0;
			while (nowGenePoolSize < genePoolSize * 0.3)
			{
				/* Selection Part */
				var bestOne = -9 * maxWeightValue;
				var bestTwo = -9 * maxWeightValue;
				var bestOneW = ds_list_create();
				var bestTwoW = ds_list_create();
				for (var i=0; i<genePoolSize * 0.1; i++)
				{
					var nowGene = ds_list_find_value(Genes, irandom(genePoolSize - 1));
					var nowWeights = nowGene[2];
					if (bestOne < nowGene[0])
					{
						bestOne = nowGene[0];
						ds_list_clear(bestOneW);
						for (var j=0; j<weightCount; j++)
							ds_list_add(bestOneW, ds_list_find_value(nowWeights, j));
					}
					if (bestTwo < nowGene[0] && bestOne > nowGene[0])
					{
						bestTwo = nowGene[0];
						ds_list_clear(bestTwoW);
						for (var j=0; j<weightCount; j++)
							ds_list_add(bestTwoW, ds_list_find_value(nowWeights, j));
					}
				}
				
				/* Crossover Part */
				var bestOfBest = ds_list_create();
				//var v1 = bestOne / (bestOne + bestTwo);
				//var v2 = bestTwo / (bestOne + bestTwo);
				
				var normalizer = 0;
				for (var i=0; i<weightCount; i++)
				{	
					var nowW1 = ds_list_find_value(bestOneW, i) * bestOne;
					var nowW2 = ds_list_find_value(bestTwoW, i) * bestTwo;
					ds_list_add(bestOfBest, nowW1 + nowW2);		
					normalizer += sqr(nowW1 + nowW2);	//pow(x)
				}
				normalizer = sqrt(normalizer);	//root(x)
				
				for (var i=0; i<weightCount; i++)
				{	
					var bestW = ds_list_find_value(bestOfBest, i);
					bestW /= normalizer;
					ds_list_replace(bestOfBest, i, bestW);
				}				
				
				ds_list_add(computedGenes, bestOfBest);
				
				nowGenePoolSize++;
			}
			
			/* Replace Low Rated Gene With Computed Gene */
			for (var i=genePoolSize * 0.7; i<genePoolSize; i++)
			{
				var goodGene = ds_list_find_value(computedGenes, genePoolSize - i - 1);
				ds_list_replace(Genes, i, getGene(0, generation, goodGene));
			}
			
			/* Compulsory Random Gene (10%) */
			for (var i=genePoolSize * 0.6; i<genePoolSize * 0.7; i++)
			{
				var randomWeights = ds_list_create();
				for (var j=0; j<weightCount; j++)
					ds_list_add(randomWeights, random_range(-maxWeightValue, maxWeightValue));
		
				ds_list_replace(Genes, i, getGene(0, generation, randomWeights));
			}
			
			/*
			Mutation Part
			돌연변이(각 유전자마다 5%의 확률로 발생) : 각 가중치에 랜덤값을 더해준다. (최우수 개체 제외)
			*/
			for (var i=1; i<genePoolSize; i++)
			{
				if (random_range(0, maxWeightValue) < 0.05)
				{
					var nowGene = ds_list_find_value(Genes, i);
					var nowWeights = nowGene[2];
					var j = irandom(weightCount - 1);
					var nowWeight = ds_list_find_value(nowWeights, j);
					var r = random_range(-0.2, 0.2);
					if (nowWeight + r >= maxWeightValue)
						nowWeight -= r;
					else if (nowWeight + r <= -maxWeightValue)
						nowWeight -= r;
					else
						nowWeight += r;
					ds_list_replace(nowWeights, j, nowWeight);
					
					ds_list_replace(Genes, i, getGene(0, generation, nowWeights));
				}
			}
			
			geneIndex = 0;
			ds_list_clear(Scores);
		}
		
		resetBlock();
		resetRandomBag();
		break;
	}
}