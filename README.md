# Tetris AI 
Using Genetic Algorithm, AI was implemented. <br>
This project was written in GameMaker Studio 2. <br>
[TetrisWithAI.zip](TetrisWithAI.zip) <br>
[GameMaker Studio 2](https://accounts.yoyogames.com/downloads)

# Learning example
<div><img src="images/example50000.PNG" width="500" height="600"></div>

# Play video
[TetrisPlay1](TetrisPlay1.mp4) [TetrisPlay2](TetrisPlay2.mp4)

# Weights
Weight consists of positive and negative factors that affect the game. <br>
For example, if you place a block and it has a lot of space between the blocks, it's not a good idea. We call this <b>Holes</b>. <br>
This means that you can count the number of spaces that occur when a block is placed in a position and use it as a weight. <br>
The weights selected in this way are : <b>MaxHeight, Bumpiness, Holes, CompleteLine</b> <br>

# Fitness
The coefficient of weight x the sum of the corresponding numbers determines the suitability. <br>
weight(n) = c x k (k : the number of the corresponding block) <br>
fitness = weight(1) + weight(2) + ... + weight(n) <br>
When the block is placed in that position, the final decision is to have the highest fitness value. <br>
<b>Real Fitness = MaxHeight + Bumpiness + Holes + CompleteLine</b> <br>

# ResultWeights.txt
File contains weights arranged in descending order for each generation. <br>
AI set random weights in the beginning, and AI play based on that. <br>
It store the weights in a file at the end of each generation. Of course you can call it up. <br>

Generation : 0 ~ 14 (AI is repeated 11 games for counting an average and the number of blocks is limited to 1000) <br>
Generation : 15 ~ (AI play only 1 game and there is no limit on the number of blocks) <br>
[ResultWeights.txt](ResultWeights.txt)

# Execution screen
<div><img src="images/tetris_main.PNG" width="250" height="300"><img src="images/start_learning.PNG" width="250" height="300"></div>
<div><img src="images/set_weights.PNG" width="250" height="300"><img src="images/select_level.PNG" width="250" height="300"></div>
<div><img src="images/play_with_GA.PNG" width="500" height="300"></div>


