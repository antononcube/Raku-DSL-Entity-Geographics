
use lib '.';

use DSL::Entity::Geographics;
use DSL::Entity::Geographics::ResourceAccess;

#my DSL::Entity::Geographics::ResourceAccess $resource.instance;
#
#my DSL::Entity::Geographics::ResourceAccess $resource2.instance;
#
#say 'Map with resources:', $resource.country-adjective-to-name("Chinese");
#
#say 'Map with resources:', $resource2.country-adjective-to-name("Bulgarian");
#
#say 'Map with resources:', $resource2.country-adjective-to-name("Armenian");
#
#say 'Number of resource objects:', $resource.getNumberOfInstances();

say DSL::Entity::Geographics::resource-access-object().getNameToEntityID()<City>.elems;

my $pCOMMAND = DSL::Entity::Geographics::Grammar;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());
$pCOMMAND.get-resources().maxDist = 1;

say DSL::Entity::Geographics::resource-access-object().getNameToEntityID()<Country>.values.pick(12).raku;
say DSL::Entity::Geographics::resource-access-object().getNameToEntityID()<Country-Adjective>.values.pick(12).raku;

#use Grammar::Tracer;

#say $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command');
#say $pCOMMAND.parse('Аржентина', rule => 'geographic-entity-command');
#say $pCOMMAND.parse('Bulgarian', rule => 'geographic-entity-command');
#say $pCOMMAND.parse('United States', rule => 'geographic-entity-command');
#say $pCOMMAND.parse('how many people in United States');

say "=" x 60;

my @testCommands = (
'Argentine',
'Mediterranean',
'Средиземноморски',
'Аржентина',
'Гръцки',
'Alabama',
'New Hampshire',
'Atlanta',
'Atlanta, GA',
'atlanta and',
'Пенсилвания',
'Fort Lauderdale, FL',
'Fort Lauderdale Florida',
);


my @targets = <Raku-System WL-System>;

for @testCommands -> $c {
    say "=" x 30;
    say $c;
    for @targets -> $t {
        say '-' x 30;
        say $t;
        say '-' x 30;
        my $start = now;
        my $res = ToGeographicEntityCode($c, $t);
        say "Result: {$res.raku}";
        say "time:", now - $start;
        say $res;
    }
}
