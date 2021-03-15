use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

#-----------------------------------------------------------
my $fileName = %?RESOURCES<CountryAdjectiveToName.csv>;

my Str @adjNamPairs = $fileName.lines;

my Str %countryAdjectiveToName{Str} = @adjNamPairs.map({ $_.lc.split(',') }).flat;

my Set $knownCountryAdjectives = Set(%countryAdjectiveToName);
my Set $knownCountryAdjectiveWords = Set(%countryAdjectiveToName.keys.map({ $_.split(/h+/) }).flat);

#-----------------------------------------------------------
sub known-country-adjective(Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
    known-phrase( $knownCountryAdjectives, $knownCountryAdjectiveWords, $phrase, :$bool, :$warn )
}

#-----------------------------------------------------------
role DSL::Entity::English::Geographics::Grammar::CountryAdjectives
        does DSL::Shared::Roles::English::PipelineCommand {

    rule country-adjective-faster-match {
        <country-adjective-known>
    }
    rule country-adjective-known {
        ( <word-value>+ % \h+ ) <?{ known-country-adjective($0.Str.lc) }>
    }
}