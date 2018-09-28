for i in HF937082 HG514459 KF042344 KT335971 KT378453 KU212370 KU212372
do
	makeblastdb -in $i.fa -dbtype nucl
	blastn -query $i.fa -db $i.fa -outfmt 6 >$i.blastn.tbl
done
