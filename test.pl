use strict;
use Text::Levenshtein qw(distance);

my $first_distance=distance("foo","four");
print "First distance: ".$first_distance." should be 2\n";

my $second_distance=distance("foo","foo");
print "Second distance: ".$second_distance." should be 0\n";

my @words=("four","foo","bar");

my @distances=distance("foo",@words);
print "Distances in array: [@distances] should be [2 0 3]\n";

