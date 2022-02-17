use DSL::Shared::Entity::Grammar::EntityNames;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

role DSL::Entity::Geographics::Grammar::EntityNames
        does DSL::Shared::Entity::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand {

    regex entity-country-adjective {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Country-Adjective', $0.Str.lc) }>
    }

    regex entity-region-adjective {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Region-Adjective', $0.Str.lc) }>
    }

    regex entity-country-name {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Country', $0.Str.lc) }>
    }

    regex entity-region-name {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Region', $0.Str.lc) }>
    }
}