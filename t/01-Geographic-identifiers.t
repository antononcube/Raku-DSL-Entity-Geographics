
use DSL::Entity::Geographics;
use Test;

##===========================================================
## Country names
##===========================================================

plan 6;

# 1
is make-geographics-id( country => 'UnitedStates', state => 'Georgia', city => 'Atlanta'), 'UnitedStates-Georgia-Atlanta';

# 2
is make-geographics-id('UnitedStates', 'Georgia', 'Atlanta'), 'UnitedStates-Georgia-Atlanta';

# 3
is make-geographics-id(Whatever, Whatever, 'Fort Lauderdale'), 'CITYNAME-Fort_Lauderdale';

# 4
is make-geographics-id(Whatever, 'Georgia', Whatever), 'STATENAME-Georgia';

# 5
is make-geographics-id(Whatever, 'Florida', 'Fort Lauderdale'), 'UnitedStates-Florida-Fort_Lauderdale';

# 6
is make-geographics-id('Russia', Whatever, Whatever), 'COUNTRYNAME-Russia';

done-testing;
