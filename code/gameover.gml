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
		if (nowRepeatGame == maxRepeatGame || nowTotalScore == 0)	//최악의 경우 0줄도 제거하지 못한 경우도 고려
		{	
			updateScore();
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
			AI_operation();
			geneIndex = 0;
			ds_list_clear(Scores);
		}
		resetAllBlocks();
		shuffleRandomBag();
		return;
	}
}
