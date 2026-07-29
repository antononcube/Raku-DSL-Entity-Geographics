use DSL::Entity::Geographics::Grammar;

use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Shared::Actions::CommonStructures;

class DSL::Entity::Geographics::Actions::Bulgarian::Standard
        is DSL::Shared::Actions::CommonStructures {

    # method TOP($/) { make $/.values[0].made; }

    method TOP($/) {
        make 'Not implemented.';
    }

}
