use lib './lib';
use lib '.';
use DSL::Entity::English::Geographics;

my $pCOMMAND = DSL::Entity::English::Geographics::Grammar;

#use Grammar::Tracer;

#say $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command');
#
#say $pCOMMAND.parse('Bulgarian', rule => 'geographic-entity-command');
#
#say $pCOMMAND.parse('United States', rule => 'geographic-entity-command');
#
#say $pCOMMAND.parse('how many people in United States');


say "=" x 60;


my @testCommands = (
'Argentina',
'China',
'Chinese'
);


my @targets = ('WL-System');

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
