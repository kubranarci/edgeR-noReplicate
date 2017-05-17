use strict;
use warnings;

my $num_args = $#ARGV + 1;
if ($num_args != 3) {
    print "\nUsage: prepare_countMatrix.pl control_counts.txt sample_counts.txt count_matrix.txt\n";
    exit;
}


my $input_file=$ARGV[0];
my $input_file2=$ARGV[1];
my $output_file=$ARGV[2];

open(OUTPUT,">",$output_file);

my @array1;

open (my $inFile, '<', $input_file) or die $!;

while (<$inFile>) {
	push (@array1, split /\n/);

}

close ($inFile);

my @array2;

open (my $inFile2, '<', $input_file2) or die $!;

while (<$inFile2>) {
	push (@array2, split /\n/);

}
close ($inFile2);

print OUTPUT "ENSEMBL_GENE_ID	CONTROL	SAMPLE\n";

for (my $i=0; $i<$#array1-4; $i++){

	my @line = (split /\t/, $array2[$i]);
	print OUTPUT "$array1[$i]	$line[1]\n";

}

close OUTPUT;