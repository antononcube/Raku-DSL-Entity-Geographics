use DSL::Shared::Entity::Grammar::EntityNames;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

role DSL::Entity::Geographics::Grammar::EntityNames
        does DSL::Shared::Entity::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand {

    #------------------------------------------------------
    proto regex entity-country-adjective {*}

    regex entity-country-adjective:sym<English> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Country-Adjective', $0.Str.lc) }>
    }

    regex entity-country-adjective:sym<Bulgarian> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Country-Adjective-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-region-adjective {*}

    regex entity-region-adjective:sym<English> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Region-Adjective', $0.Str.lc) }>
    }

    regex entity-region-adjective:sym<Bulgarian> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Region-Adjective-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-country-name {*}

    regex entity-country-name:sym<English> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Country', $0.Str.lc) }>
    }

    regex entity-country-name:sym<Bulgarian> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Country-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-region-name {*}

    regex entity-region-name:sym<English> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Region', $0.Str.lc) }>
    }

    regex entity-region-name:sym<Bulgarian> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Region-Bulgarian', $0.Str.lc) }>
    }

}