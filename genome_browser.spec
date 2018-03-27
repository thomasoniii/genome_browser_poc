/*
A KBase module: genome_browser
*/

module genome_browser {

    funcdef get_gff(string genome_ref) returns (string) authentication required;
    funcdef get_fasta(string genome_ref) returns (string) authentication required;
};
