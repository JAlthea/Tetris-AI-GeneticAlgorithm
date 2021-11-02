/* Update Total Scores */

var g = ds_list_find_value(Genes, geneIndex);
g[0] = nowTotalScore;	//Apply GameScore

if (ds_list_find_index(Scores, g[0]) == -1) {    //Add Scores
	ds_list_add(Scores, g[0]);	
}
else {    //Update Scores (Deduplication)
	var gap = 0.01;
	while (ds_list_find_index(Scores, g[0] - gap))
		gap += 0.01;
	ds_list_add(Scores, g[0] - gap);	
	g[0] -= gap;
}

ds_list_replace(Genes, geneIndex, getGene(g[0], g[1], g[2]));
