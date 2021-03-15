use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

#-----------------------------------------------------------
my $fileName = %?RESOURCES<CountryNames.txt>;

my Str @countryNames = $fileName.lines;

my Set $knownCountryNames = Set(@countryNames.map(*.lc));

my Set $knownCountryNameWords = Set(@countryNames.map({ $_.split(/\h+/) }).flat.trim.lc);

#-----------------------------------------------------------
our sub known-country-name-word (Str:D $word, Bool :$bool = True, Bool :$warn = True) {
    known-string($knownCountryNameWords, $word, :$bool, :$warn)
}

our sub known-country-name(Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
    known-phrase( $knownCountryNames, $knownCountryNameWords, $phrase, :$bool, :$warn )
}

#-----------------------------------------------------------
role DSL::Entity::English::Geographics::Grammar::CountryNames
        does DSL::Shared::Roles::English::PipelineCommand {

    rule country-name-faster-match {
        <country-name-known>
    }

    rule country-name-known {
        ( <word-value>+ % \h+ ) <?{ known-country-name($0.Str.lc) }>
    }
}