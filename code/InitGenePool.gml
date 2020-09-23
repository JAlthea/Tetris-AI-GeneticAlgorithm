/* Init GenePool */
//inputGeneration : AI level for learning(0~98), Best Level(99), AI level for Battle(else)

if (inputGeneration == 0)	//StartGeneration
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
		var nowWeights = ds_list_create();
		if (selectedLevel == 1)
		{
			ds_list_add(nowWeights, -0.286);
			ds_list_add(nowWeights, -0.923);
			//ds_list_add(nowWeights, -0.271);
			ds_list_add(nowWeights, -0.873);
			ds_list_add(nowWeights, -0.388);
			//ds_list_add(nowWeights, 0.717);
			//ds_list_add(nowWeights, 0.469);
			//ds_list_add(nowWeights, -0.404);
			gameSpeed = 1;
		}
		else if (selectedLevel == 2)
		{
			ds_list_add(nowWeights, -0.994);
			ds_list_add(nowWeights, -0.922);
			//ds_list_add(nowWeights, 0.498);
			ds_list_add(nowWeights, -0.879);
			ds_list_add(nowWeights, 0.239);
			//ds_list_add(nowWeights, 0.503);
			//ds_list_add(nowWeights, 0.481);
			//ds_list_add(nowWeights, 0.682);
			gameSpeed = 2;
		}
		else if (selectedLevel == 3)
		{
			ds_list_add(nowWeights, -0.780);
			ds_list_add(nowWeights, -0.920);
			//ds_list_add(nowWeights, -0.281);
			ds_list_add(nowWeights, -0.479);
			ds_list_add(nowWeights, -0.394);
			//ds_list_add(nowWeights, 0.712);
			//ds_list_add(nowWeights, 0.481);
			//ds_list_add(nowWeights, 0.684);
			gameSpeed = 3;
		}
		else if (selectedLevel == 4)
		{
			ds_list_add(nowWeights, -0.282);
			ds_list_add(nowWeights, -0.934);
			//ds_list_add(nowWeights, -0.299);
			ds_list_add(nowWeights, -0.881);
			ds_list_add(nowWeights, 0.242);
			//ds_list_add(nowWeights, 0.708);
			//ds_list_add(nowWeights, 0.457);
			//ds_list_add(nowWeights, 0.798);
			gameSpeed = 5;
		}
		
		ds_list_add(Genes, getGene(0, generation, nowWeights));
	}
}
