#!/usr/bin/env perl6
use Geographics;

sub MAIN(Str $commands, Str $target = 'Raku-System' ) {
    say ToGeographicEntityCode($commands, $target);
}