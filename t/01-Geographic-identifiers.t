
use DSL::Entity::Geographics;
use Test;

##===========================================================
## Country names
##===========================================================

my $sep = '-';
my $spc = '_';

plan 6;

# 1
is make-geographics-id( country => 'UnitedStates', state => 'Georgia', city => 'Atlanta', :$sep, :$spc), 'UnitedStates-Georgia-Atlanta';

# 2
is make-geographics-id('UnitedStates', 'Georgia', 'Atlanta', :$sep, :$spc), 'UnitedStates-Georgia-Atlanta';

# 3
is make-geographics-id(Whatever, Whatever, 'Fort Lauderdale', :$sep, :$spc), 'CITYNAME-Fort_Lauderdale';

# 4
is make-geographics-id(Whatever, 'Georgia', Whatever, :$sep, :$spc), 'STATENAME-Georgia';

# 5
is make-geographics-id(Whatever, 'Florida', 'Fort Lauderdale', :$sep, :$spc), 'UnitedStates-Florida-Fort_Lauderdale';

# 6
is make-geographics-id('Russia', Whatever, Whatever, :$sep, :$spc), 'COUNTRYNAME-Russia';

done-testing;
