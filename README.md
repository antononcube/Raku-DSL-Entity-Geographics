# Raku DSL::Entity::Geographics

Raku grammar classes for geographic entities (names.)

## Installation

**1.** Install Raku (Perl 6) : https://raku.org/downloads . 

**2.** Make sure you have Zef Module Installer. 
 
   - Type in `zef --version` in the command line.
   - Zef Module Installer can be installed from : https://github.com/ugexe/zef .

**3.** Open a command line program. (E.g. Terminal on Mac OS X.)

**4.** Run the commands:

```shell
zef install https://github.com/antononcube/Raku-DSL-Shared.git
zef install https://github.com/antononcube/Raku-DSL-Entity-Geographics.git
```

## Examples

```perl6
use DSL::Entity::Geographics::Grammar;
my $pCOMMAND = DSL::Entity::Geographics::Grammar;
say $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command');
say $pCOMMAND.parse('United States of America, Illinois, Peoria', rule => 'geographic-entity-command');
say $pCOMMAND.parse('United States, IL 60606', rule => 'geographic-entity-command');
```

## References

[AAr1] Anton Antonov,
[DSL::Shared Raku package](https://github.com/antononcube/Raku-DSL-Shared),
(2020),
[GitHub/antononcube](https://github.com/antononcube).

[AAr2] Anton Antonov,
[DSL::Entity::Jobs Raku package](https://github.com/antononcube/Raku-DSL-Entity-Jobs),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAr3] Anton Antonov,
[DSL::Entity::Foods Raku package](https://github.com/antononcube/Raku-DSL-Entity-Foods),
(2021),
[GitHub/antononcube](https://github.com/antononcube).
