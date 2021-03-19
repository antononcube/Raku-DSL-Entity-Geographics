use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Entity::English::Geographics::ResourceAccess;

my DSL::Entity::English::Geographics::ResourceAccess $resources.instance;

role DSL::Entity::English::Geographics::Grammar::CountryAdjectives
        does DSL::Shared::Roles::English::PipelineCommand {

    rule country-adjective-faster-match {
        <country-adjective-known>
    }

    regex country-adjective-known {
        (<word-value>+ % \h+ ) <?{ $resources.known-country-adjective($0.Str.lc) }>
    }
}