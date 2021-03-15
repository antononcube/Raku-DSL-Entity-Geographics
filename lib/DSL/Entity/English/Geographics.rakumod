
=begin pod

=head1 DSL::Entity::English::Geographics

C<DSL::Entity::English::Geographics> package has grammar and action classes for the parsing and
interpretation of natural language commands that specify geographic locations.

=head1 Synopsis

    use DSL::Entity::English::Geographics;
    my $rcode = ToGeographicEntityCode('Argentina');

=end pod

unit module DSL::Entity::English::Geographics;

use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;

use DSL::Entity::English::Geographics::Grammar;
use DSL::Entity::English::Geographics::Actions::WL::System;

use DSL::Entity::English::Geographics::Actions::Bulgarian::Standard;

#-----------------------------------------------------------
my %targetToAction =
    "Mathematica"      => DSL::Entity::English::Geographics::Actions::WL::System,
    "WL"               => DSL::Entity::English::Geographics::Actions::WL::System,
    "WL-System"        => DSL::Entity::English::Geographics::Actions::WL::System,
    "Bulgarian"        => DSL::Entity::English::Geographics::Actions::Bulgarian::Standard;

my %targetToSeparator{Str} =
    "Julia"            => "\n",
    "Julia-DataFrames" => "\n",
    "R"                => " ;\n",
    "Mathematica"      => "\n",
    "WL"               => ";\n",
    "WL-System"        => ";\n",
    "Bulgarian"        => "\n";

#-----------------------------------------------------------
sub has-semicolon (Str $word) {
    return defined index $word, ';';
}

#-----------------------------------------------------------
proto ToGeographicEntityCode(Str $command, Str $target = 'tidyverse' ) is export {*}

multi ToGeographicEntityCode ( Str $command where not has-semicolon($command), Str $target = 'WL' ) {

    die 'Unknown target.' unless %targetToAction{$target}:exists;

    my $match = DSL::Entity::English::Geographics::Grammar.parse($command.trim, actions => %targetToAction{$target} );
    die 'Cannot parse the given command.' unless $match;
    return $match.made;
}

multi ToGeographicEntityCode ( Str $command where has-semicolon($command), Str $target = 'WL' ) {

    my $specTarget = get-dsl-spec( $command, 'target');

    $specTarget = $specTarget ?? $specTarget<DSLTARGET> !! $target;

    die 'Unknown target.' unless %targetToAction{$specTarget}:exists;

    my @commandLines = $command.trim.split(/ ';' \s* /);

    @commandLines = grep { $_.Str.chars > 0 }, @commandLines;

    my @cmdLines = map { ToGeographicEntityCode($_, $specTarget) }, @commandLines;

    @cmdLines = grep { $_.^name eq 'Str' }, @cmdLines;

    return @cmdLines.join( %targetToSeparator{$specTarget} ).trim;
}
