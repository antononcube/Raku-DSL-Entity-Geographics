use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

role DSL::Entity::Geographics::Grammar::CountryNames
        does DSL::Shared::Roles::English::PipelineCommand {

    rule country-name-faster-match {
        <country-name-known>
    }

    regex country-name-known {
        ( <word-value>+ % \h+ ) <?{ self.get-resources.known-country-name($0.Str.lc) }>
    }
}