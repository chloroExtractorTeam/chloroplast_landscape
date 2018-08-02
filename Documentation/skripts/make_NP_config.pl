#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);

my $input=$ARGV[0];

#print $input;
print "Project:\n";
print "-----------------------\n";
print "Project name          = NOVOPlasty_".$input."_out\n";
print "Type                  = chloro\n";
print "Genome Range          = 120000-200000\n";
print "K-mer                 = 30\n";
print "Max memory            = 16\n";
print "Extended log          = 1\n";
print "Save assembled reads  = yes\n";
print "Seed Input            = ".$Bin."/cds-nr98-core.fa\n";
print "Reference sequence    = \n";
print "Variance detection    = no\n";
print "Heteroplasmy          = \n";
print "Chloroplast sequence  = \n";
print "\n";
print "Dataset 1:\n";
print "-----------------------\n";
print "Read Length           = 75\n";
print "Insert size           = 100\n";
print "Platform              = illumina\n";
print "Single/Paired         = PE\n";
print "Combined reads        = \n";
print "Forward reads         = ".$Bin."/".$input."_1.fastq\n";
print "Reverse reads         = ".$Bin."/".$input."_2.fastq\n";
print "\n";
print "Optional:\n";
print "-----------------------\n";
print "Insert size aut       = yes\n";
print "Insert Range          = 1.8\n";
print "Insert Range strict   = 1.3\n";


