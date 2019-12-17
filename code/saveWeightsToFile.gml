genes = argument0;

/* Save Weights of Genes */
var nowString = "Generation : " + string(generation - 1) + "\n";
for (var i=0; i<genePoolSize; i++)
{
	var tmp = ds_list_find_value(genes, i);
	nowString += string(tmp[0]) + " ";
	var weights = tmp[2];
	for (var j=0; j<weightCount; j++)
		nowString += string_format(ds_list_find_value(weights, j), 1, 6) + " ";
	nowString += "\n";
}

/* Output Weights To File  */
var fileName = "ResultWeights.txt";
var file = file_text_open_append(working_directory + fileName);
file_text_write_string(file, "\n" + nowString);
file_text_close(file);