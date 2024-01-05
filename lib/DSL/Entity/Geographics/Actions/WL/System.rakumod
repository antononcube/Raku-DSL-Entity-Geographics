=begin comment
#==============================================================================
#
#   Geographic Entities WL-System actions in Raku (Perl 6)
#   Copyright (C) 2021  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   antononcube @ posteo . net,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku (Perl6) see https://raku.org/ .
#
#==============================================================================
=end comment

use v6;

use DSL::Entity::Geographics::Grammar;
use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Entity::Geographics::ResourceAccess;
use DSL::Shared::Entity::Actions::WL::System;


class DSL::Entity::Geographics::Actions::WL::System
        is DSL::Shared::Entity::Actions::WL::System
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

    #------------------------------------------------------
    method entity-country-name:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Country', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    method entity-country-name:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Country-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    #------------------------------------------------------
    method entity-country-adjective:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Country-Adjective', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    method entity-country-adjective:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Country-Adjective-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    #------------------------------------------------------
    method entity-region-name:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Region', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    method entity-region-name:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Region-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    #------------------------------------------------------
    method entity-region-adjective:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Region-Adjective', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    method entity-region-adjective:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Region-Adjective-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj.wordcase ~ '"';
    }

    #------------------------------------------------------
    method entity-state-name:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('State', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj ~ '"';
    }

    method entity-state-name:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('State-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj ~ '"';
    }

    #------------------------------------------------------
    method entity-city-name:sym<English>($/) {
        # There should be name clashes.
        # Selection has to be done based on city population.
        # (That data is not included in this package yet.)
        my $adj = $!resources.name-to-entity-id('City', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj ~ '"';
    }

    method entity-city-name:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('City-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make '"' ~ $adj ~ '"';
    }

    #------------------------------------------------------
    method entity-city-and-state-name($/) {
        # We have to make sure that the state-name-and-city-name key exists.
        # TBF...
        if $<entity-city-name>.made.contains($<entity-state-name>.made.subst('"'):g) {
            make $<entity-city-name>.made;
        } else {
            # Here we assume that the IDs are in the form <country>-<state>-<city>
            my $key = $<entity-state-name>.made ~ $<entity-city-name>.split('-').tail;

            my $state = $<entity-state-name>.made.split('-').tail.trans(['"', '_'] => ['', ' ']);
            my $city = $<entity-city-name>.made.split('-').tail.trans(['"', '_'] => ['', ' ']);

            if $!resources.countryStateCity{'UnitedStates'; $state ; $city } {
                make "UnitedStates-{$state.subst(' ', '_'):g}-{$city.subst(' ', '_'):g}";
            } else {
                make 'NONE';
            }
        }
    }
}
