use strict;
use Test::More qw (no_plan);
use lib 'blib/lib';
use Text::Levenshtein qw(distance fastdistance);

is_deeply(distance("foo","four"),2,"Correct distance");
is_deeply(distance("foo","foo"),0,"Correct distance");
my @foo = distance("foo","four","foo","bar");
my @bar = (2,0,3);
is_deeply(\@foo,\@bar,"Array test: Correct distances");
is_deeply(fastdistance("foo","boo"),1,"Fast test: Correct distance");
