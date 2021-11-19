/// @description Init

//1x1 BlockSize
cellSize = 32;

//For border check
DY = { 1, -1, 0, 0 };
DX = { 0, 0, 1, -1 };

//Blocks and Frame
topEmptySpace = 3;    //start block position
M = 20 + 2 * topEmptySpace;    //Y axis : tetris frame size
N = 10;    //X axis : tetris frame size
field[M, N] = 0;    //Tetris frame
virtualField[M, N] = 0;    //Virtual tetris frame for genetic algorithm simulation
pa[4, 2] = 0;    //real now block
pb[4, 2] = 0;    //real before block
pc[4, 2] = 0;    //real extra block for calculation
next[4, 2] = 0;    //real next block
virtualPa[4, 2] = 0;    //virtual now block
virtualPb[4, 2] = 0;    //virtual before Block
saveBlockPosition[3] = 0;    //decided position of block & rotation

//Set Tetrominos : Tetris Figures
figures[7, 4] = 0;
figures[0, 0] = 0; figures[0, 1] = 2; figures[0, 2] = 4; figures[0, 3] = 6;    //I
figures[1, 0] = 2; figures[1, 1] = 4; figures[1, 2] = 5; figures[1, 3] = 7;    //Z
figures[2, 0] = 3; figures[2, 1] = 5; figures[2, 2] = 4; figures[2, 3] = 6;    //S
figures[3, 0] = 3; figures[3, 1] = 5; figures[3, 2] = 4; figures[3, 3] = 7;    //T
figures[4, 0] = 2; figures[4, 1] = 3; figures[4, 2] = 5; figures[4, 3] = 7;    //L
figures[5, 0] = 3; figures[5, 1] = 5; figures[5, 2] = 7; figures[5, 3] = 6;    //J
figures[6, 0] = 2; figures[6, 1] = 3; figures[6, 2] = 4; figures[6, 3] = 5;    //O

//Set Random Bag
randomize();    //Init Random Seed
randomBagIndex = 0;
randomBag = ds_list_create();
for (var i = 0; i < 7; i++)
	ds_list_add(randomBag, i);
shuffleRandomBag();

//Offset
frameX = 1 * cellSize;
frameY = -2 * cellSize;
blockStartX = 0;
blockStartY = 2;
blockNextX = 12;
blockNextY = 2;

//For User
dx = 0;
rotate = false;
delayKey = 0;
mil = false;
onSpace = false;

//For AI
bPutIn = false;
X = 0;
Y = 0;
countBlockFigure = 0;

//For All
gameScore = 0;
delay = 10;
timer = 0;
gametimer = 0;
resetAllBlocks();

/* User Interface */
globalvar oExit;	//Game Exit
oExit = false;
globalvar oMaxDelay;
oMaxDelay = 11;
globalvar oDelay;	//Game Speed For GeneticAlgorithm
oDelay = oMaxDelay;
globalvar oPause;	//Temporary Stop
oPause = false;
globalvar oSkip;	//Accelerator For GeneticAlgorithm
oSkip = false;

/* For Genetic Algorithm  */
globalvar genePoolSize;
genePoolSize = 100;
globalvar Genes;	//All Genes
Genes = ds_list_create();	//DS = Data Structure
globalvar geneIndex;	//Now Playing Gene No.
geneIndex = 0;
globalvar Scores;		//All Scores
Scores = ds_list_create();

globalvar weightCount;
weightCount = 4;	//Count Weights
globalvar selectedGeneCount;
selectedGeneCount = genePoolSize / 10;	//Selected Gene Count For Next Generation 
globalvar generation;
generation = 0;		//Gene Generation
globalvar bestScore;
bestScore = 0;		//Best Score With Now Generation
globalvar maxWeightValue;
maxWeightValue = 1;	//Range Of Weights Value

/* For Repeat Testing */
globalvar nowRepeatGame;
nowRepeatGame = 0;
globalvar maxRepeatGame;
maxRepeatGame = 0;		//Low Generation : 10, High Generation : 0
globalvar nowTotalScore;
nowTotalScore = 0;
globalvar maxBlockCount;
maxBlockCount = 1000000000;	//Low Generation : 1000, High Generation : INF
globalvar nowBlockCount;
nowBlockCount = 0;

/* Before Start Init GenePool */
InitGenePool();
generation = inputGeneration;
