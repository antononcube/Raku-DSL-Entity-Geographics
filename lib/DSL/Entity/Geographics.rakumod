
=begin pod

=head1 DSL::Entity::Geographics

C<DSL::Entity::Geographics> package has grammar and action classes for the parsing and
interpretation of natural language commands that specify geographic locations.

=head1 Synopsis

    use DSL::Entity::Geographics;
    my $rcode = ToGeographicEntityCode('Argentina');

=end pod

unit module DSL::Entity::Geographics;

use DSL::Shared::Utilities::CommandProcessing;

use DSL::Entity::Geographics::Grammar;
use DSL::Entity::Geographics::Actions::WL::Entity;
use DSL::Entity::Geographics::Actions::WL::System;

use DSL::Entity::Geographics::Actions::Bulgarian::Standard;

#-----------------------------------------------------------
my %targetToAction =
    "Mathematica"      => DSL::Entity::Geographics::Actions::WL::System,
    "WL"               => DSL::Entity::Geographics::Actions::WL::System,
    "WL-System"        => DSL::Entity::Geographics::Actions::WL::System,
    "WL-Entity"        => DSL::Entity::Geographics::Actions::WL::Entity,
    "Bulgarian"        => DSL::Entity::Geographics::Actions::Bulgarian::Standard;


my %targetToAction2{Str} = %targetToAction.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::').Str => $_.value }).Hash;
%targetToAction = |%targetToAction , |%targetToAction2;

#| Target to separators rules
my Str %targetToSeparator{Str} = DSL::Shared::Utilities::CommandProcessing::target-separator-rules();

#-----------------------------------------------------------
my DSL::Entity::Geographics::ResourceAccess $resourceObj;

#| Get the resources access object.
our sub resource-access-object(--> DSL::Entity::Geographics::ResourceAccess)  { return $resourceObj; }

#-----------------------------------------------------------
#| Named entity recognition for metadata. (proto)
proto ToGeographicEntityCode(Str $command, Str $target = 'WL-System', | ) is export {*}

#| Named entity recognition for metadata
multi ToGeographicEntityCode( Str $command, Str $target = 'WL-System', *%args ) {

    my $pCOMMAND = DSL::Entity::Geographics::Grammar;
    $pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

    my $ACTOBJ = %targetToAction{$target}.new(resources => DSL::Entity::Geographics::resource-access-object());

    DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode( $command,
                                                               grammar => $pCOMMAND,
                                                               actions => $ACTOBJ,
                                                               separator => %targetToSeparator{$target},
                                                               |%args )
}

#-----------------------------------------------------------
#| Makes Geographical identifier from given country, state, and city names.
proto sub make-geographics-id(|) is export {*}

multi sub make-geographics-id($country, $state, $city) {
    return make-geographics-id(:$country, :$state, :$city);
}

multi sub make-geographics-id(:$country, :$state, :$city) {
    return do given ($country, $state, $city) {
        when (Whatever, Whatever, Whatever) {
            die 'At least one of the arguments have to be string.';
        }
        when (Whatever, Whatever, Str:D) {
            'CITY_NAME-' ~ $city.subst(/\h+/, '_', :g);
        }
        when (Whatever, Str:D, Whatever) {
            'STATE_NAME-' ~ $state.subst(/\h+/, '_', :g);
        }
        when (Str:D, Whatever, Whatever) {
            'COUNTRY_NAME-' ~ $country.subst(/\h+/, '_', :g);
        }
        when (Whatever, Str:D, Str:D) {
            # Of course, we have to verify that that ID can be found in the data.
            # But that is not done in this "lightweight" function.
            make-geographics-id('UnitedStates', $state, $city);
        }
        default {
            ($country, $state, $city).join('-').subst(/\h+/, '_', :g);
        }
    }
}

#-----------------------------------------------------------
$resourceObj := BEGIN {
    my DSL::Entity::Geographics::ResourceAccess $obj .= new;
    $obj.ingest-resource-files();
    $obj
}