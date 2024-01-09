use DSL::Entity::Geographics::Grammar;
use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Entity::Geographics::ResourceAccess;
use DSL::Shared::Entity::Actions::WL::System;
use DSL::Entity::Geographics::Actions::Raku::System;


class DSL::Entity::Geographics::Actions::WL::System
        is DSL::Entity::Geographics::Actions::Raku::System
        is DSL::Shared::Entity::Actions::WL::System
        is DSL::Shared::Actions::English::WL::PipelineCommand {
    

    #------------------------------------------------------
    method geographic-entity-command($/) {
        my $res = self.DSL::Entity::Geographics::Actions::Raku::System::geographic-entity-command($/);
        make '"' ~ $res ~ '"';
    }
}
