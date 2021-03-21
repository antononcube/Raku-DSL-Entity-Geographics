use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Entity::English::Geographics::ResourceAccess;

my DSL::Entity::English::Geographics::ResourceAccess $resources.instance;

role DSL::Entity::English::Geographics::Grammar::EntityAdjectives
        does DSL::Shared::Roles::English::PipelineCommand {

    regex entity-country-adjective {
        (<word-value>+ % \h+ ) <?{ $resources.known-adjective( 'Country', $0.Str.lc) }>
    }

    regex entity-region-adjective {
        (<word-value>+ % \h+ ) <?{ $resources.known-adjective( 'Region', $0.Str.lc) }>
    }
}