# Tetris AI 
Using Genetic Algorithm, AI was implemented. <br>
This project was written in GameMaker Studio 2. <br>

# Learning Example
<div><img src="images/example50000.PNG" width="500" height="600"></div>


# Weights
Weight consists of positive and negative factors that affect the game. <br>
For example, if you place a block and it has a lot of space between the blocks, it's not a good idea. We call this <b>Holes</b>. <br>
This means that you can count the number of spaces that occur when a block is placed in a position and use it as a weight. <br>
The weights selected in this way are : <b>MaxHeight, Bumpiness, Holes, CompleteLine</b>
