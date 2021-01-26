set -e 

rm -f res.tsv res_novel.tsv

for i in output/*/*/*
do
	asm=$(basename $(dirname $i))
	dat=$(basename $(dirname $(dirname $i)))
	echo -ne "$dat\t" >>res.tsv
	bash evaluate_completeness.sh ../Arabidopsis_chloro_ref_CCTB.fasta $i $asm >> res.tsv
	echo -ne "$dat\t" >> res_novel.tsv
	bash eval_novel.sh $i $asm >> res_novel.tsv
done

