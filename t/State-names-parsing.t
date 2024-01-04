
use DSL::Entity::Geographics;
use Test;

##===========================================================
## Country names
##===========================================================

my $pCOMMAND = DSL::Entity::Geographics::Grammar;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

my $resourceObj = DSL::Entity::Geographics::resource-access-object();

plan *;

ok $pCOMMAND.parse('Pennsylvania', rule => 'geographic-entity-command'), 'Pennsylvania';

ok $pCOMMAND.parse('New Hampshire', rule => 'geographic-entity-command'), 'New Hampshire';

ok $pCOMMAND.parse('Ню Хампшир', rule => 'geographic-entity-command'), 'Siera Leone';


done-testing;
