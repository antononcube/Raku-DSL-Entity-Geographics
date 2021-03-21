use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Entity::English::Geographics::ResourceAccess;

my DSL::Entity::English::Geographics::ResourceAccess $resources.instance;

role DSL::Entity::English::Geographics::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand {

    regex entity-country-name {
        ( <word-value>+ % \h+ ) <?{ $resources.known-name('Country', $0.Str.lc) }>
    }

    regex entity-region-name {
        ( <word-value>+ % \h+ ) <?{ $resources.known-name('Region', $0.Str.lc) }>
    }
}