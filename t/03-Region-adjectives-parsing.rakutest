
use DSL::Entity::Geographics;
use Test;

##===========================================================
## Country names
##===========================================================

my $pCOMMAND = DSL::Entity::Geographics::Grammar;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

my $resourceObj = DSL::Entity::Geographics::resource-access-object();

plan 5;

ok $pCOMMAND.parse('African', rule => 'geographic-entity-command'), 'African';

ok $pCOMMAND.parse('American', rule => 'geographic-entity-command'), 'American';

ok $pCOMMAND.parse('Asian', rule => 'geographic-entity-command'), 'Asian';

like $resourceObj.name-to-entity-id('Region-Adjective', 'Asian'), / 'Asia' / ;

like $resourceObj.name-to-entity-id('Region-Adjective', 'African'), / 'Africa' /;

done-testing;
