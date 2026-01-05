
use DSL::Entity::Geographics;
use Test;

##===========================================================
## Country names
##===========================================================

my $pCOMMAND = DSL::Entity::Geographics::Grammar;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

my $resourceObj = DSL::Entity::Geographics::resource-access-object();

plan 7;

ok $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command'), 'Argentina';

ok $pCOMMAND.parse('Bulgaria', rule => 'geographic-entity-command'), 'Bulgaria';

ok $pCOMMAND.parse('Sierra Leone', rule => 'geographic-entity-command'), 'Siera Leone';

ok $pCOMMAND.parse('United Kingdom', rule => 'geographic-entity-command'), 'United Kingdom';

ok $pCOMMAND.parse('United States', rule => 'geographic-entity-command'), 'United States';

like $resourceObj.name-to-entity-id('Country', 'China'), / 'China' / ;

like $resourceObj.name-to-entity-id('Country', 'United States'), / 'United_States' /;

done-testing;
