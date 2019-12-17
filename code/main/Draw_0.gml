/// @description Running

timer += 1;
gametimer += 1/room_speed;	//room_speed : 60 fixed

//Exit Button
while (oExit){}

//Temporary Pause Button
if (oPause)
{
	timer -= 1;
	gametimer -= 1/room_speed;
}
/* Running By Genetic Algorithm */
else if (!bPutIn)
{
	decideBlock();	//최적의 위치를 갖는 블록(tmp)의 정보를 반환하여 현재 블록(pa, pb)의 위치를 결정한다.
	bPutIn = true;
	X = 0;
	Y = 0;
	countBlockFigure = 0;
	for (var i=0; i<4; i++)
	{
		pc[i,0] = pa[i,0];
		pc[i,1] = pa[i,1];
		pb[i,0] = pa[i,0];
		pb[i,1] = pa[i,1];
	}
}
else if (timer > oDelay && bPutIn)
{	
	var count = putBlockInSlowly();	//블록을 이동하고 놓는 과정을 보여준다.
	if (oSkip)	//최대속도로 가속시
	{
		for (var i=0; i<4; i++)
		{
			pb[i,1] = tmp[i,1];
			pb[i,0] = tmp[i,0];
		}
		count = 0;
	}
	
	if (count == 0)	//블록을 두는 과정이 끝났을 때
	{
		//Apply Color To Now Block
		for (var i=0; i<4; i++)
			field[pb[i,1], pb[i,0]] = nowColor;

		//Decide Next Block To Now Block
		nowColor = nextColor;
		for (var i=0; i<4; i++)
		{
			pa[i,0] = next[i,0] - blockNextX + blockStartX;
			pa[i,1] = next[i,1] - blockNextY + blockStartY;
		}
		
		//Next Block In RandomBag or RandomBag Shuffling
		if (randomBagIndex == 6)
		{
			ds_list_shuffle(randomBag);
			randomBagIndex = 0;
		}
		else
			randomBagIndex++;
		
		/* Init Next Start Block */
		nextColor = irandom(8);		//Color Choice
		nextFigure = ds_list_find_value(randomBag, randomBagIndex);	//Figure Choice
		for (var i=0; i<4; i++)
		{
			next[i,0] = figures[nextFigure, i] % 2 + blockNextX;	//Pos X
			next[i,1] = floor(figures[nextFigure, i] / 2) + blockNextY; //Pos Y
		}
		fitNextBlockToFrame();
	
		bPutIn = false;
		saveBlockPosition[0] = 0;
		saveBlockPosition[1] = 0;
		saveBlockPosition[2] = 0;
		
		//gameScore += 10;	//Add Score
		nowBlockCount++;
	}
	
	timer = 0;
}

/* Erase lines */
while (true)
{
	var countRemovedLine = 0;
	var k = M - 1;
	for (var i=k; i>3+Extra; i--)	//hardcode : 3 + Extra
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
	
	gameScore += countRemovedLine;
	if (countRemovedLine == 0)
		break;
}
/* Combo Score Expression */
//gameScore += (101 + (countRemovedLine*10)) * countRemovedLine;

//Gameover
gameover();

//Clear Extra Space
clearExtraSpace();





//////////////////
// For Drawing ///
//////////////////

draw_clear(c_black);
//Stacked blocks
for (var i=0; i<M; i++)
{
	for (var j=0; j<N; j++)
	{
		if (field[i,j] == -1)
			continue;
		var cx = i * cellSize;
		var cy = j * cellSize;
		var imgIndex = cellSize * field[i,j];
		draw_sprite_part(nowUsedBlock, 0, imgIndex, 0, cellSize, cellSize, cy + frameX, cx + frameY);
	}
}
//Now blocks
for (var i=0; i<4; i++)
{
	var cx = pa[i,0] * cellSize;
	var cy = pa[i,1] * cellSize;
	var imgIndex = cellSize * nowColor;
	draw_sprite_part(nowUsedBlock, 0, imgIndex, 0, cellSize, cellSize, cx + frameX, cy + frameY);
}
//Next blocks
for (var i=0; i<4; i++)
{
	var cx = next[i,0] * cellSize;
	var cy = next[i,1] * cellSize;
	var imgIndex = cellSize * nextColor;
	draw_sprite_part(nowUsedBlock, 0, imgIndex, 0, cellSize, cellSize, cx + frameX, cy + frameY);
}

draw_sprite(mainFrameBlue, 0, 0, 0);
draw_sprite(nextBlockFrame, 0, 0, 0);
draw_sprite(weightBoard, 0, 8, 0);


var g = ds_list_find_value(Genes, geneIndex);
var w = g[2];
var geneGeneration;
var geneNumber;

if (inputGeneration == 99)
{
	geneGeneration = "Generation : -";
	geneNumber = "Gene No. -";
}
else
{
	geneGeneration = "Generation : " + string(g[1]);
	geneNumber = "Gene No." + string(geneIndex);
}

var geneW0 = "MaxHeight : \n" + string_format(ds_list_find_value(w, 0), 1, 6);
var geneW1 = "Bumpiness : \n" + string_format(ds_list_find_value(w, 1), 1, 6);
var geneW2 = "Holes : \n" + string_format(ds_list_find_value(w, 2), 1, 6);
var geneW3 = "CompleteLine : \n" + string_format(ds_list_find_value(w, 3), 1, 6);
var beforeScore = "Before Best Score : \n" + string(bestScore);
var repeatGame = " Now Gene\n Repeat Game : \n " + string(nowRepeatGame);
var totalScore = " Total Score : \n " + string(nowTotalScore);
var blockCount = " Block Count : \n " + string(nowBlockCount);

draw_text(405, 192, string(geneGeneration));
draw_text(405, 212, string(geneNumber));
draw_text(405, 232, string(geneW0));
draw_text(405, 272, string(geneW1));
draw_text(405, 312, string(geneW2));
draw_text(405, 352, string(geneW3));
draw_text(385, 584, string(beforeScore));
draw_text(405, 422, string(repeatGame));
draw_text(405, 482, string(totalScore));
draw_text(405, 522, string(blockCount));

/* Info Game State */
draw_text(385, 620, "Line Count : " + string(gameScore)); 
draw_text(385, 640, "Game Time : " + string(gametimer));

