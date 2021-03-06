# Tetris AI 
Using <b>Genetic Algorithm</b>, AI of immortal level was implemented. <br>
This project was written in GameMaker Studio 2. <br>
[TetrisWithAI.zip](TetrisWithAI.zip) <br>
[GameMaker Studio 2](https://accounts.yoyogames.com/downloads)

# Learning example
<b>* Early Generation Play</b> (0 generation) <br>
<div><img src="images/start_generation_play.gif" width="500" height="600"></div> <br>
<br><br>
<b>* Optimized Generation Play</b> (15 generation) <br><br>
<div><img src="images/optimized_generation_play.gif" width="500" height="600"></div>

# Play video
[TetrisPlay_AI_Learning.mp4](TetrisPlay_AI_Learning.mp4) <br>
[TetrisPlay_Battle.mp4](TetrisPlay_Battle.mp4)

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
<div><img src="images/main_screen.gif" width="250" height="300"><img src="images/learning_option_screen.gif" width="250" height="300"></div>
<div><img src="images/weight_setting_screen.gif" width="250" height="300"><img src="images/level_selecting_screen.gif" width="250" height="300"></div>

# Battle screen
<b>* User vs AI Play</b> <br>
<div><img src="images/verse_play.gif"></div>
