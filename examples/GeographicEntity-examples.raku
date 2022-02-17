use lib './lib';
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

my $pCOMMAND = DSL::Entity::Geographics::Grammar;

$pCOMMAND.set-resources(get-entity-resources-access-object());

#use Grammar::Tracer;

say $pCOMMAND.parse('Argentina country', rule => 'geographic-entity-command');
#
#say $pCOMMAND.parse('Bulgarian', rule => 'geographic-entity-command');
#
#say $pCOMMAND.parse('United States', rule => 'geographic-entity-command');
#
#say $pCOMMAND.parse('how many people in United States');


say "=" x 60;


my @testCommands = (
'Argentina',
'Mediterranian'
);


my @targets = ('WL-Entity', 'Bulgarian');

for @testCommands -> $c {
    say "=" x 30;
    say $c;
    for @targets -> $t {
        say '-' x 30;
        say $t;
        say '-' x 30;
        my $start = now;
        my $res = ToGeographicEntityCode($c, $t);
        say "time:", now - $start;
        say $res;
    }
}
