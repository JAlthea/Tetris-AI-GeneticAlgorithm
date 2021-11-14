/* 선택된 레벨마다 최적화된 정도로 가중치를 부여한다. */

var nowWeights = ds_list_create();    //현재 사용할 가중치들

if (selectedLevel == 1) {
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
else if (selectedLevel == 2) {
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
else if (selectedLevel == 3) {
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
else if (selectedLevel == 4) {
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
