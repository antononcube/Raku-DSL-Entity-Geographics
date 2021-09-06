use lib './lib';
use lib '.';
use DSL::Entity::Geographics;
use Test;

##===========================================================
## Country names
##===========================================================

my $pCOMMAND = DSL::Entity::Geographics::Grammar;

my DSL::Entity::Geographics::ResourceAccess $resourceObj.instance;

plan 5;

ok $pCOMMAND.parse('African', rule => 'geographic-entity-command'), 'African';

ok $pCOMMAND.parse('American', rule => 'geographic-entity-command'), 'American';

ok $pCOMMAND.parse('Asian', rule => 'geographic-entity-command'), 'Asian';

like $resourceObj.name-to-entity-id('Region-Adjective', 'Asian'), / 'Asia' / ;

like $resourceObj.name-to-entity-id('Region-Adjective', 'African'), / 'Africa' /;

done-testing;
