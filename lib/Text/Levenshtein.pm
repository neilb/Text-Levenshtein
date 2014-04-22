package Text::Levenshtein;

use 5.006;
use strict;
use warnings;
use Exporter;
use Carp;

our @ISA         = qw(Exporter);
our @EXPORT      = ();
our @EXPORT_OK   = qw(distance fastdistance);
our %EXPORT_TAGS = ();


sub distance
{
    croak "distance() takes 2 or more arguments" if @_ < 2;
	my ($s,@t)=@_;
    my @results;

	foreach my $t (@t) {
		push(@results, fastdistance($s, $t));
	}

	return wantarray ? @results : $results[0];
}

# This is the "Iterative with two matrix rows" version
# from the wikipedia page
# http://en.wikipedia.org/wiki/Levenshtein_distance#Computing_Levenshtein_distance
sub fastdistance
{
    croak "fastdistance() takes exactly 2 arguments" unless @_ == 2;
    my ($s, $t) = @_;
    my (@v0, @v1);
    my ($i, $j);

    return 0 if $s eq $t;
    return length($s) if !$t || length($t) == 0;
    return length($t) if !$s || length($s) == 0;

    my $s_length = length($s);
    my $t_length = length($t);

    for ($i = 0; $i < $t_length + 1; $i++) {
        $v0[$i] = $i;
    }

    for ($i = 0; $i < $s_length; $i++) {
        $v1[0] = $i + 1;

        for ($j = 0; $j < $t_length; $j++) {
            my $cost = substr($s, $i, 1) eq substr($t, $j, 1) ? 0 : 1;
            $v1[$j + 1] = _min(
                              $v1[$j] + 1,
                              $v0[$j + 1] + 1,
                              $v0[$j] + $cost,
                             );
        }

        for ($j = 0; $j < $t_length + 1; $j++) {
            $v0[$j] = $v1[$j];
        }
    }

    return $v1[ $t_length];
}

sub _min
{
    my $min    = shift;
    my @others = @_;
    foreach my $value (@others) {
        $min = $value if $value < $min;
    }
    return $min;
}

1;

__END__

=head1 NAME

Text::Levenshtein - calculate the Levenshtein edit distance between two strings

=head1 SYNOPSIS

 use Text::Levenshtein qw(distance);

 print distance("foo","four");
 # prints "2"

 my @words     = qw/ four foo bar /;
 my @distances = distance("foo",@words);

 print "@distances";
 # prints "2 0 3"

=head1 DESCRIPTION

This module implements the Levenshtein edit distance,
which measures the difference between two strings,
in terms of the I<edit distance>.
This distance is the number of substitutions, deletions or insertions ("edits") 
needed to transform one string into the other one (and vice versa).
When two strings have distance 0, they are the same.

To learn more about the Levenshtein metric,
have a look at the
L<wikipedia page|http://en.wikipedia.org/wiki/Levenshtein_distance>.

=head2 distance()

The simplest usage will take two strings and return the edit distance:

 $distance = distance('brown', 'green');
 # returns 3, as 'r' and 'n' don't change

Instead of a single second string, you can pass a list of strings.
Each string will be compared to the first string passed, and a list
of the edit distances returned:

 @words     = qw/ green trainee brains /;
 @distances = distances('brown', @words);
 # returns (3, 5, 3)

=head2 fastdistance()

Previous versions of this module provided an alternative
implementation, in the function C<fastdistance()>.
This function is still provided, for backwards compatibility,
but they now run the same function to calculate the edit distance.

Unlike C<distance()>, C<fastdistance()> only takes two strings,
and returns the edit distance between them.

=head1 SEE ALSO

See also Text::LevenshteinXS on CPAN if you do not require a perl-only
implementation.
It is extremely faster in nearly all cases.

See also Text::WagnerFischer on CPAN for a configurable edit distance, i.e. for
configurable costs (weights) for the edits.


=head1 AUTHOR

Dree Mistrut originally wrote this module and released it to CPAN in 2002.

Josh Goldberg then took over maintenance and released versions between
2004 and 2008.

Neil Bowers (NEILB on CPAN) is now maintaining this module.
Version 0.07 was a complete rewrite, based on one of the algorithms
on the wikipedia page.

=head1 COPYRIGHT AND LICENSE

This software is copyright (C) 2002-2004 Dree Mistrut.
Copyright (C) 2004-2014 Josh Goldberg.
Copyright (C) 2014- Neil Bowers.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
