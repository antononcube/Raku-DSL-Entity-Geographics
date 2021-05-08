#!/usr/bin/env perl6
use Geographics;

sub MAIN(Str $commands, Str $target = 'WL-Entity' ) {
    put ToGeographicEntityCode($commands, $target);
}