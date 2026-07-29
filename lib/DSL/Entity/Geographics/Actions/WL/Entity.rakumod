use DSL::Entity::Geographics::Grammar;
use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Entity::Geographics::ResourceAccess;

class DSL::Entity::Geographics::Actions::WL::Entity
        is DSL::Shared::Actions::English::WL::PipelineCommand {

    has DSL::Entity::Geographics::ResourceAccess $.resources;

    ##========================================================
    ## Grammar methods
    ##========================================================

    method TOP($/) {
        make $/.values[0].made;
    }

    method geographic-entity-command($/) {
        make $/.values[0].made;
    }

    method entity-country-name($/) {
        my $nm = $!resources.known-name('Country', $/.Str.lc, :!bool, :!warn);
        make 'Entity["Country", "' ~ $nm.wordcase ~ '"]';
    }

    method entity-country-adjective($/) {
        my $adj = $!resources.known-name('Country-Adjective', $/.Str.lc, :!bool, :!warn);
        make 'Entity["Country", "' ~ $adj.wordcase ~ '"]';
    }

    method entity-region-name($/) {
        my $nm = $!resources.known-name('Region', $/.Str.lc, :!bool, :!warn);
        make 'EntityClass["Country", "' ~ $nm.wordcase ~ '"]';
    }

    method entity-region-adjective($/) {
        my $adj = $!resources.known-name('Region-Adjective', $/.Str.lc, :!bool, :!warn);
        make 'EntityClass["Country", "' ~ $adj.wordcase ~ '"]';
    }
}
