perl -ne 's/^(\d+)\D*(\d+)$/\1\t\2/;print if(/^\d/);' AB684440.pal
