for i in *.fa
do
	echo ir detection for $i
	palindrome -sequence $i -minpallen 1000 -maxpallen 50000 -gaplimit 100000 -nummismatches 0 -outfile $(basename $i .fa).pal -nooverlap
done
