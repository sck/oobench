#! /usr/bin/perl -w

use strict;

my %dict;

foreach my $item (@ARGV) {
    my ($key, $value) = split('=', $item);
    open(F, $value) || do {
        warn "$value: $!\n";
        next;
    };
    {
        undef $/;
        $dict{$key} = <F>;
    }
    close(F);
}

my $all;
{
    undef $/;
    $all = <STDIN>;
}

my $k;

$all =~ s<!--!(\w+)!--!><
    $k = $1;
    if (!defined $dict{$k}) {
        die "Undefined key '$k'";
    }
    "$dict{$k}";
>ge;

print $all;
