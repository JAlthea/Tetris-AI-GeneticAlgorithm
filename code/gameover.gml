for (var j=0; j<N; j++)
{
	/* Gameover Condition */
	if (field[tetrisborderLine - 1 + topEmptySpace, j] != -1 || nowBlockCount >= maxBlockCount)
	{
		/* Only One Gene Mode (Ex: SetWeights, PlayWithGA) */
		if (inputGeneration >= 99)
		{
			if (inputGeneration == 99)
				show_message("설정한 가중치로 게임이 끝났습니다. \n");
			else
				show_message("와 승리하셨어요! 다음 레벨에 도전해봐요~ \n");
			game_restart();
			return;
		}
		
		/* Game Repeat Statement (Ex: AI Learning) */
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
			AI_operation();
		}
		resetAllBlocks();
		shuffleRandomBag();
		return;
	}
}
