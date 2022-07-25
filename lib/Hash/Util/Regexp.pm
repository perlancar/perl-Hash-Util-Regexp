package Hash::Util::Regexp;

use strict;
use warnings;

use Exporter 'import';

# AUTHORITY
# DATE
# DIST
# VERSION

our @EXPORT_OK = qw(
                       has_key_matching
                       keys_matching
                       first_key_matching

                       has_key_not_matching
                       keys_not_matching
                       first_key_not_matching
               );

sub _keys {
    my ($hash, $sort) = @_;

    my @keys = keys %$hash;
    if ($sort) {
        if (ref $sort eq 'CODE') {
            @keys = sort $sort @keys;
        } else {
            @keys = sort @keys;
        }
    }
    \@keys;
}

sub has_key_matching {
    my ($hash, $re) = @_;
    for my $key (keys %$hash) {
        return 1 if $key =~ $re;
    }
    0;
}

sub keys_matching {
    my ($hash, $re, $sort) = @_;

    my @res;
    for my $key (@{ _keys($hash, $sort) }) {
        next unless $key =~ $re;
        push @res, $key;
    }
    @res;
}

sub first_key_matching {
    my ($hash, $re, $sort) = @_;

    my @res;
    for my $key (@{ _keys($hash, $sort) }) {
        return $key if $key =~ $re;
    }
    return;
}

sub has_key_not_matching {
    my ($hash, $re) = @_;
    for my $key (keys %$hash) {
        return 1 unless $key =~ $re;
    }
    0;
}

sub keys_not_matching {
    my ($hash, $re, $sort) = @_;

    my @res;
    for my $key (@{ _keys($hash, $sort) }) {
        next if $key =~ $re;
        push @res, $key;
    }
    @res;
}

sub first_key_not_matching {
    my ($hash, $re, $sort) = @_;

    my @res;
    for my $key (@{ _keys($hash, $sort) }) {
        return $key unless $key =~ $re;
    }
    return;
}

1;
# ABSTRACT: Hash utility routines related to regular expression

=head1 DESCRIPTION


=head1 FUNCTIONS

All the functions are exportable but not exported by default.

=head2 has_key_matching

Usage:

 my $bool = has_key_matching(\%hash, qr/some_regex/);

This is a shortcut/alias for something like:

 my $bool = any { /some_regex/ } keys %hash;

=head2 first_key_matching

Usage:

 my $key = first_key_matching(\%hash, qr/some_regex/ [ , $sort ]);

This is a shortcut/alias for something like:

 my $key = first { /some_regex/ } keys %hash;

The optional C<$sort> argument can be set to true (e.g. 1) or a coderef to sort
the keys first.

=head2 key_matching

Usage:

 my @keys = keys_matching(\%hash, qr/some_regex/ [ , $sort ]);

This is a shortcut/alias for something like:

 my @keys = grep { /some_regex/ } keys %hash;

The optional C<$sort> argument can be set to true (e.g. 1) or a coderef to sort
the keys first.

=head2 has_key_not_matching

The counterpart for L</has_key_matching>.

=head2 first_key_not_matching

The counterpart for L</first_key_matching>.

=head2 keys_not_matching

The counterpart for L</keys_matching>.


=head1 SEE ALSO

=cut
