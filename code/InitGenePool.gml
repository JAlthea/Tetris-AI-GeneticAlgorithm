/* Init GenePool */
//inputGeneration : AI level for learning(0~98), Best Level(99), AI level for Battle(else)

//Start Generation
if (inputGeneration == 0)
{
	for (var i=0; i<genePoolSize; i++)
	{
		var randomWeights = ds_list_create();
		for (var j=0; j<weightCount; j++)
			ds_list_add(randomWeights, random_range(-maxWeightValue, maxWeightValue));
		
		/* [Weights, Generation, Score] */
	   	ds_list_add(Genes, getGene(0, generation, randomWeights));
	}
}

//Load for AI Learning
else if (inputGeneration < 99)
{
	var inputGenerationString = string(inputGeneration);
	var nowStrings = array_create(weightCount + 1);
	var checkGeneration = false;
	
	/* Read Weights From File  */
	var fileName = "ResultWeights.txt";
	var file = file_text_open_read(working_directory + fileName);
	if (file == -1)
	{
		show_message("해당 파일이 존재하지 않습니다. \nThe file does not exist. \n초기 세대부터 학습합니다. \nLearn from the early generations.");
		for (var i=0; i<genePoolSize; i++)
		{
			var randomWeights = ds_list_create();
			for (var j=0; j<weightCount; j++)
				ds_list_add(randomWeights, random_range(-maxWeightValue, maxWeightValue));
	
			/* [Weights, Generation, Score] */
		    	ds_list_add(Genes, getGene(0, generation, randomWeights));
		}
		
		return;
	}
	
	while (!file_text_eof(file))
	{
		var tmpFirst = file_text_read_string(file);
		file_text_readln(file);
		var tmpG = string_copy(tmpFirst, 0, 1);
		var tmpSize = string_length(inputGenerationString);
		var tmpValue = string_copy(tmpFirst, string_length(tmpFirst) + 1 - tmpSize, tmpSize);
		if (tmpG == "G" && tmpValue == inputGenerationString)
		{
			checkGeneration = true;
			for (var i=0; i<genePoolSize; i++)
			{
				var tmpSecond = file_text_read_string(file);
				file_text_readln(file);
				
				var a = 0;
				var q = 0;
				var k = 0;
				for (; k<string_length(tmpSecond); k++)
				{
					if (string_char_at(tmpSecond, k) == " ")
					{	
						nowStrings[a] = string_copy(tmpSecond, q, k - q);
						q = k + 1;
						a++;
					}
				}
				nowStrings[a] = string_copy(tmpSecond, q, k - q);
				
				var nowWeights = ds_list_create();
				for (var j=0; j<weightCount; j++)
					ds_list_add(nowWeights, real(nowStrings[j+1]));
				
				/* [Weights, Generation, Score] */
			    ds_list_add(Genes, getGene(0, inputGeneration, nowWeights));
			}
			
			break;
		}
	}
	if (!checkGeneration)
	{
		show_message("해당 데이터가 없습니다. \nThere is no data. \n초기 세대부터 학습합니다. \nLearn from the early generations.");
		for (var i=0; i<genePoolSize; i++)
		{
			var randomWeights = ds_list_create();
			for (var j=0; j<weightCount; j++)
				ds_list_add(randomWeights, random_range(-maxWeightValue, maxWeightValue));
	
			/* [Weights, Generation, Score] */
		    	ds_list_add(Genes, getGene(0, generation, randomWeights));
		}
	}
	
	file_text_close(file);
}

//Set AI Info for Battle
else
{
	if (inputGeneration == 99)
	{
		var nowWeights = ds_list_create();
		for (var j=0; j<weightCount; j++)
			ds_list_add(nowWeights, setWeights[j]);
		ds_list_add(Genes, getGene(0, generation, nowWeights));
	}
	else
	{
		addWeightsForBattle();
	}
}
