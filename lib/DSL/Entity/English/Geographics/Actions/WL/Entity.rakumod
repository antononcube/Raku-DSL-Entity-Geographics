=begin comment
#==============================================================================
#
#   Geographic Entities WL-Entity actions in Raku (Perl 6)
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

use DSL::Entity::English::Geographics::Grammar;
use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Entity::English::Geographics::ResourceAccess;

my DSL::Entity::English::Geographics::ResourceAccess $resources.instance;

class DSL::Entity::English::Geographics::Actions::WL::Entity
        is DSL::Shared::Actions::English::WL::PipelineCommand {

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
        my $nm = $resources.known-name('Country', $/.Str.lc, :!bool, :!warn);
        make 'Entity["Country", "' ~ $nm.wordcase ~ '"]';
    }

    method entity-country-adjective($/) {
        my $adj = $resources.known-adjective('Country', $/.Str.lc, :!bool, :!warn);
        make 'Entity["Country", "' ~ $adj.wordcase ~ '"]';
    }

    method entity-region-name($/) {
        my $nm = $resources.known-name('Region', $/.Str.lc, :!bool, :!warn);
        make 'EntityClass["Country", "' ~ $nm.wordcase ~ '"]';
    }

    method entity-region-adjective($/) {
        my $adj = $resources.known-adjective('Region', $/.Str.lc, :!bool, :!warn);
        make 'EntityClass["Country", "' ~ $adj.wordcase ~ '"]';
    }
}
