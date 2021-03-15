#!/usr/bin/env perl6
use Geographics;

sub MAIN(Str $commands, Str $target = 'WL-ClCon' ) {
    put ToGeographicEntityCode($commands, $target);
}