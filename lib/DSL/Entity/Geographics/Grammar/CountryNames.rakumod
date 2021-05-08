use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Entity::Geographics::ResourceAccess;

my DSL::Entity::Geographics::ResourceAccess $resources.instance;

role DSL::Entity::Geographics::Grammar::CountryNames
        does DSL::Shared::Roles::English::PipelineCommand {

    rule country-name-faster-match {
        <country-name-known>
    }

    regex country-name-known {
        ( <word-value>+ % \h+ ) <?{ $resources.known-country-name($0.Str.lc) }>
    }
}