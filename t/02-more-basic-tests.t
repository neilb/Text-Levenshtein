#!perl

use strict;
use warnings;
use utf8;

use Test::More 0.88;
use Text::Levenshtein qw/ distance fastdistance /;

my @TESTS = parse_tests();
my $distance;

plan tests => 4 * @TESTS;

foreach my $test (@TESTS) {

    $distance = distance($test->{word1}, $test->{word2});
    ok($distance == $test->{distance}, "$test->{title} (distance)");

    $distance = distance($test->{word2}, $test->{word1});
    ok($distance == $test->{distance}, "$test->{title} (reverse distance)");

    $distance = fastdistance($test->{word1}, $test->{word2});
    ok($distance == $test->{distance}, "$test->{title} (fastdistance)");

    $distance = fastdistance($test->{word2}, $test->{word1});
    ok($distance == $test->{distance}, "$test->{title} (reverse fastdistance)");

}

sub parse_tests
{
    my @tests;
    my @fields;
    local $_;

    while (<DATA>) {
        next if /^--/;
        chomp;
        push(@fields, $_);
        if (@fields == 4) {
            push(@tests, { title    => shift(@fields),
                           word1    => shift(@fields),
                           word2    => shift(@fields),
                           distance => shift(@fields),
                         });
            @fields = ();
        }
    }
    return @tests;
}

__DATA__
Identical words
chocolate
chocolate
0
--
Both empty strings


0
--
One empty string
chocolate

9
--
Identical words, one space character
 
 
0
--
Completely different words
pink
blue
4
--
Second word is the first, with a prefix
fly
butterfly
6
--
Second word is the first, with a suffix
blue
bluebottle
6
--
The only difference is an accent on one letter
cafe
café
1
--
