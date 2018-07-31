#!bin/bash

rm Statistic_out_*.log

perl ~/Master_thesis/chloroExtractor/bin/find_cyclic_graph.pl -i raw-data-GO-*/GO_*_out/filtered_spades/assembly_graph.fastg -o fcg_out.fa


perl ~/Master_thesis/chloroExtractor/bin/find_cyclic_graph.pl -i raw-data-GO-*/GO_*_out/filtered_spades/assembly_graph.fastg.*.fastg -o fcg_out2.fa

SeqFilter fcg_out2.fa >> Statistic_out.log

SeqFilter fcg_out.fa >> Statistic_out.log

SeqFilter GO_*_out.fa >> Statistic_out.log
