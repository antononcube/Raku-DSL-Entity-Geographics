use v6;

use DSL::Entity::Geographics::ResourceAccess;
use DSL::Shared::Entity::Grammar::EntityNames;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

my DSL::Entity::Geographics::ResourceAccess $resources.instance;

role DSL::Entity::Geographics::Grammar::EntityAdjectives
        does DSL::Shared::Entity::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand {

    regex entity-country-adjective {
        (<word-value>+ % \h+ ) <?{ $resources.known-name( 'Country-Adjective', $0.Str.lc) }>
    }

    regex entity-region-adjective {
        (<word-value>+ % \h+ ) <?{ $resources.known-name( 'Region-Adjective', $0.Str.lc) }>
    }
}