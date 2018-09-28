# in conda-shell source ncbi-acc-download env
# https://github.com/kblin/ncbi-acc-download
# conda-shell-4.3.31
# source activate ncbi-acc-download
for acc in $(cut -f10 256479-1.csv | tail -n+4 | head -n-2)
do
	ncbi-acc-download --format fasta $acc
	ncbi-acc-download --format gff3 $acc
done
# source deactivate
# exit
